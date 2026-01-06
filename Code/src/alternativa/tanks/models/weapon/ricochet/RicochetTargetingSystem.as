package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.IRayCollisionFilter;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.models.weapon.shared.MarginalCollider;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TanksCollisionDetector;
   
   public class RicochetTargetingSystem implements IRayCollisionFilter
   {
      
      private static const rayHit:RayHit = new RayHit();
      
      private static const currOrigin:Vector3 = new Vector3();
      
      private static const currDirection:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const matrix:Matrix3 = new Matrix3();
      
      private var angleUp:Number;
      
      private var numRaysUp:int;
      
      private var angleDown:Number;
      
      private var numRaysDown:int;
      
      private var maxDistance:Number;
      
      private var targetEvaluator:RicochetTargetEvaluator;
      
      private var maxPriority:Number;
      
      private var ricochetCount:int;
      
      private var shooterBody:Body;
      
      private var collisionDetector:TanksCollisionDetector;
      
      private var maxRicochetCount:int;
      
      public function RicochetTargetingSystem(param1:Number, param2:int, param3:Number, param4:int, param5:Number, param6:TanksCollisionDetector, param7:RicochetTargetEvaluator, param8:int)
      {
         super();
         this.angleUp = param1;
         this.numRaysUp = param2;
         this.angleDown = param3;
         this.numRaysDown = param4;
         this.maxDistance = param5;
         this.targetEvaluator = param7;
         this.collisionDetector = param6;
         this.maxRicochetCount = param8;
      }
      
      public function considerBody(param1:Body) : Boolean
      {
         return this.shooterBody != param1 || this.ricochetCount > 0;
      }
      
      public function getShotDirection(param1:Vector3, param2:Vector3, param3:Vector3, param4:Body, param5:Vector3) : void
      {
         this.initTargetSearch(param4);
         this.checkDirection(param1,param2,0,param5);
         this.checkSector(param1,param2,param3,this.angleUp / this.numRaysUp,this.numRaysUp,param5);
         this.checkSector(param1,param2,param3,-this.angleDown / this.numRaysDown,this.numRaysDown,param5);
         this.finishTargetSearch(param5,param2);
      }
      
      private function initTargetSearch(param1:Body) : void
      {
         this.shooterBody = param1;
         this.maxPriority = 0;
      }
      
      private function checkDirection(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : void
      {
         var _loc6_:Body = null;
         var _loc7_:Boolean = false;
         this.ricochetCount = 0;
         currOrigin.copy(param1);
         currDirection.copy(param2);
         var _loc5_:Number = this.maxDistance;
         while(_loc5_ > 0)
         {
            if(!this.collisionDetector.raycast(currOrigin,currDirection,CollisionGroup.WEAPON,_loc5_,this,rayHit))
            {
               return;
            }
            _loc5_ -= rayHit.t;
            if(_loc5_ < 0)
            {
               _loc5_ = 0;
            }
            _loc6_ = rayHit.shape.body;
            _loc7_ = false;
            if(_loc6_.tank != null)
            {
               if(this.ricochetCount > 0)
               {
                  _loc7_ = true;
               }
               else
               {
                  _loc7_ = !MarginalCollider.segmentWithStaticIntersection(currOrigin,rayHit.position);
               }
            }
            if(_loc6_.tank != null && _loc6_ != this.shooterBody && _loc7_)
            {
               this.processTargetHit(_loc6_,_loc5_,param3,param2,param4);
               return;
            }
            if(_loc7_)
            {
               return;
            }
            if(!this.processRicochet())
            {
               return;
            }
         }
      }
      
      private function processTargetHit(param1:Body, param2:Number, param3:Number, param4:Vector3, param5:Vector3) : void
      {
         var _loc6_:Number = this.maxDistance - param2;
         var _loc7_:Number = Number(this.targetEvaluator.getTargetPriority(param1,this.ricochetCount,_loc6_,param3,this.maxDistance,Math.max(this.angleUp,this.angleDown)));
         if(_loc7_ > this.maxPriority)
         {
            this.maxPriority = _loc7_;
            param5.copy(param4);
         }
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
      
      private function checkSector(param1:Vector3, param2:Vector3, param3:Vector3, param4:Number, param5:int, param6:Vector3) : void
      {
         direction.copy(param2);
         matrix.fromAxisAngle(param3,param4);
         if(param4 < 0)
         {
            param4 = -param4;
         }
         var _loc7_:Number = param4;
         var _loc8_:int = 0;
         while(_loc8_ < param5)
         {
            direction.transform3(matrix);
            this.checkDirection(param1,direction,_loc7_,param6);
            _loc8_++;
            _loc7_ += param4;
         }
      }
      
      private function finishTargetSearch(param1:Vector3, param2:Vector3) : void
      {
         this.shooterBody = null;
         if(this.maxPriority == 0)
         {
            param1.copy(param2);
         }
      }
   }
}

