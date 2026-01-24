package alternativa.tanks.models.weapon.shotgun
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.IRayCollisionFilter;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.RayCollisionFilter;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
   import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming.ShotGunAimingCC;
   
   public class ShotgunRicochetTargetingSystem implements IRayCollisionFilter
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const rayHit:RayHit = new RayHit();
      
      private static const currOrigin:Vector3 = new Vector3();
      
      private static const currDirection:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const matrix:Matrix3 = new Matrix3();
      
      private var maxDistance:Number;
      
      private var targetEvaluator:CommonTargetEvaluator;
      
      private var ricochetCount:int;
      
      private var shooterBody:Body;
      
      private var collisionDetector:TanksCollisionDetector;
      
      private var maxRicochetCount:int;
      
      private var directions:Vector.<ShotgunTargetingDirection>;
      
      private var pelletDirectionGenerator:PelletDirectionCalculator;
      
      private var collisionFilter:RayCollisionFilter = new RayCollisionFilter();
      
      private var autoAiming:VerticalAutoAiming;
      
      private var bestDirectionIndexs:Vector.<int>;
      
      private var angleStep:Number;
      
      private var countSectors:int;
      
      private var lengthDirections:int;
      
      public function ShotgunRicochetTargetingSystem(param1:WeaponObject, param2:PelletDirectionCalculator, param3:ShotGunAimingCC)
      {
         super();
         this.collisionFilter.exclusion = this.shooterBody;
         this.autoAiming = param1.verticalAutoAiming();
         this.maxDistance = param1.distanceWeakening().getDistance();
         this.targetEvaluator = battleService.getCommonTargetEvaluator();
         this.collisionDetector = battleService.getBattleRunner().getCollisionDetector();
         this.pelletDirectionGenerator = param2;
         this.maxRicochetCount = 1;
         this.lengthDirections = this.autoAiming.getNumRaysUp() + this.autoAiming.getNumRaysDown() + 1;
         this.directions = new Vector.<ShotgunTargetingDirection>(this.lengthDirections);
         this.angleStep = (this.autoAiming.getElevationAngleDown() + this.autoAiming.getElevationAngleUp()) / (this.autoAiming.getNumRaysDown() + this.autoAiming.getNumRaysUp());
         this.countSectors = param3.coneVerticalAngle / this.angleStep;
         this.bestDirectionIndexs = new Vector.<int>(this.countSectors);
      }
      
      public function considerBody(param1:Body) : Boolean
      {
         return this.shooterBody != param1 || this.ricochetCount > 0;
      }
      
      public function getShotDirection(param1:AllGlobalGunParams, param2:Body, param3:Vector3) : Vector.<Tank>
      {
         var _loc7_:Number = NaN;
         var _loc8_:ShotgunTargetingDirection = null;
         param3.copy(param1.direction);
         this.shooterBody = param2;
         var _loc4_:int = 0;
         var _loc5_:Number = -this.autoAiming.getElevationAngleDown();
         direction.copy(param1.direction);
         matrix.fromAxisAngle(param1.elevationAxis,-this.autoAiming.getElevationAngleDown());
         direction.transform3(matrix);
         matrix.fromAxisAngle(param1.elevationAxis,this.angleStep);
         while(_loc5_ < this.autoAiming.getElevationAngleUp() + this.angleStep && _loc4_ < this.lengthDirections)
         {
            _loc7_ = this.procesingHitAndGetTargetPriority(param1.barrelOrigin,direction,_loc5_);
            _loc8_ = this.directions[_loc4_];
            if(_loc8_ == null)
            {
               _loc8_ = new ShotgunTargetingDirection(direction,_loc7_);
            }
            else
            {
               _loc8_.init(direction,_loc7_);
            }
            this.directions[_loc4_] = _loc8_;
            _loc4_++;
            _loc5_ += this.angleStep;
            direction.transform3(matrix);
         }
         this.finishTargetSearch(param3);
         var _loc6_:Vector.<Tank> = new Vector.<Tank>();
         this.processDirection(param3,param1,_loc6_);
         return _loc6_;
      }
      
      private function procesingHitAndGetTargetPriority(param1:Vector3, param2:Vector3, param3:Number) : Number
      {
         var _loc5_:Body = null;
         this.ricochetCount = 0;
         currOrigin.copy(param1);
         currDirection.copy(param2);
         var _loc4_:Number = this.maxDistance;
         while(_loc4_ > 0)
         {
            if(!this.collisionDetector.raycast(currOrigin,currDirection,CollisionGroup.WEAPON,_loc4_,this,rayHit))
            {
               return 0;
            }
            _loc4_ -= rayHit.t;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _loc5_ = rayHit.shape.body;
            if(_loc5_.tank != null && _loc5_ != this.shooterBody)
            {
               return this.calculateTargetPriority(_loc5_,_loc4_,param3);
            }
            if(_loc5_.tank != null)
            {
               return 0;
            }
            if(!this.processRicochet())
            {
               return 0;
            }
         }
         return 0;
      }
      
      private function calculateTargetPriority(param1:Body, param2:Number, param3:Number) : Number
      {
         var _loc4_:Number = this.maxDistance - param2;
         return this.targetEvaluator.getTargetPriority(param1,_loc4_,param3,this.maxDistance,Math.max(this.autoAiming.getElevationAngleUp(),this.autoAiming.getElevationAngleDown()));
      }
      
      private function processRicochet() : Boolean
      {
         var _loc1_:Vector3 = null;
         if(this.ricochetCount < this.maxRicochetCount)
         {
            ++this.ricochetCount;
            _loc1_ = rayHit.normal;
            currDirection.addScaled(-2 * currDirection.dot(_loc1_),_loc1_);
            currOrigin.copy(rayHit.position).addScaled(0.5,_loc1_);
            return true;
         }
         return false;
      }
      
      private function finishTargetSearch(param1:Vector3) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.shooterBody = null;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.directions.length)
         {
            _loc6_ = 0;
            _loc7_ = this.countSectors / 2;
            _loc8_ = -_loc7_;
            while(_loc8_ <= _loc7_)
            {
               _loc9_ = _loc4_ + _loc8_;
               if(_loc9_ >= 0 && _loc9_ < this.directions.length)
               {
                  _loc6_ += this.directions[_loc9_].getMaxPriority();
               }
               _loc8_++;
            }
            if(_loc2_ < _loc6_)
            {
               _loc2_ = _loc6_;
               _loc3_ = 0;
               this.bestDirectionIndexs[_loc3_] = _loc4_;
            }
            else if(_loc6_ == _loc2_ && _loc6_ > 0)
            {
               _loc3_++;
               this.bestDirectionIndexs[_loc3_] = _loc4_;
            }
            _loc4_++;
         }
         var _loc5_:ShotgunTargetingDirection = this.directions[this.bestDirectionIndexs[_loc3_ >> 1]];
         if(_loc5_.getMaxPriority() > 0)
         {
            param1.copy(_loc5_.getDirection());
         }
      }
      
      private function processDirection(param1:Vector3, param2:AllGlobalGunParams, param3:Vector.<Tank>) : void
      {
         var _loc5_:Vector3 = null;
         var _loc4_:Vector.<Vector3> = this.pelletDirectionGenerator.getDirectionsFor(param2.elevationAxis,param1.clone());
         param3.length = 0;
         for each(param1 in _loc4_)
         {
            if(!this.addTargetIfCollision(param2.barrelOrigin,param1,this.maxDistance,param3))
            {
               _loc5_ = rayHit.normal;
               currDirection.addScaled(-2 * currDirection.dot(_loc5_),_loc5_);
               currOrigin.copy(rayHit.position).addScaled(0.5,_loc5_);
               this.addTargetIfCollision(currOrigin,currDirection,this.maxDistance,param3);
            }
         }
      }
      
      private function addTargetIfCollision(param1:Vector3, param2:Vector3, param3:Number, param4:Vector.<Tank>) : Boolean
      {
         var _loc5_:Tank = null;
         if(this.collisionDetector.raycast(param1,param2,CollisionGroup.WEAPON,param3,this.collisionFilter,rayHit))
         {
            _loc5_ = rayHit.shape.body.tank;
            if(_loc5_ != null)
            {
               param4.push(_loc5_);
               return true;
            }
         }
         return false;
      }
   }
}

