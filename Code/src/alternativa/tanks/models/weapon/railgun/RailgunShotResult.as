package alternativa.tanks.models.weapon.railgun
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   
   public class RailgunShotResult
   {
      
      public var staticHitPoint:Vector3 = new Vector3();
      
      public var staticHitNormal:Vector3 = new Vector3();
      
      public var hasStaticHit:Boolean;
      
      public var targets:Vector.<Body> = new Vector.<Body>();
      
      public var hitPoints:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var shotDirection:Vector3 = new Vector3();
      
      public function RailgunShotResult()
      {
         super();
      }
      
      public function setFromTargetingResult(param1:TargetingResult) : void
      {
         var _loc2_:RayHit = null;
         var _loc3_:RayHit = null;
         if(this.hasStaticHit = param1.hasStaticHit())
         {
            _loc3_ = param1.getStaticHit();
            this.staticHitPoint.copy(_loc3_.position);
            this.staticHitNormal.copy(_loc3_.normal);
         }
         this.shotDirection.copy(param1.getDirection());
         this.targets.length = 0;
         this.hitPoints.length = 0;
         for each(_loc2_ in param1.getHits())
         {
            this.targets.push(_loc2_.shape.body);
            this.hitPoints.push(_loc2_.position);
         }
      }
      
      public function copyDirectionShotResult(param1:DirectionShotResult) : void
      {
         var _loc2_:int = int(param1.targets.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.targets[_loc3_] = param1.targets[_loc3_];
            this.hitPoints[_loc3_] = param1.hitPoints[_loc3_];
            _loc3_++;
         }
         this.targets.length = _loc2_;
         this.hitPoints.length = _loc2_;
         this.hasStaticHit = param1.hasStaticHit;
         if(this.hasStaticHit)
         {
            this.staticHitPoint.copy(param1.staticHitPoint);
            this.staticHitNormal.copy(param1.staticHitNormal);
         }
      }
      
      public function setStaticHitPoint(param1:Vector3, param2:Vector3) : void
      {
         this.hasStaticHit = true;
         this.staticHitPoint.copy(param1);
         this.staticHitNormal.copy(param2);
      }
      
      public function getStaticHitPoint() : Vector3
      {
         return this.hasStaticHit ? this.staticHitPoint : null;
      }
   }
}

