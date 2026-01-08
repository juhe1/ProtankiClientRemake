package alternativa.tanks.models.battle.ctf
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.Trigger;
   import alternativa.tanks.physics.CollisionGroup;
   
   public class FlagBaseTrigger implements Trigger
   {
      
      private static const FLAG_VISOR_HEIGHT:Number = 250;
      
      private static const rayHit:RayHit = new RayHit();
      
      private var center:Vector3;
      
      private var radiusSquared:Number;
      
      private var ctfModel:ICTFModel;
      
      private var inZone:Boolean;
      
      private var collisionDetector:CollisionDetector;
      
      public function FlagBaseTrigger(param1:Vector3, param2:Number, param3:ICTFModel, param4:CollisionDetector)
      {
         super();
         this.collisionDetector = param4;
         this.center = param1.clone();
         this.radiusSquared = param2 * param2;
         this.ctfModel = param3;
      }
      
      public function reset() : void
      {
         this.inZone = false;
      }
      
      public function checkTrigger(param1:Body) : void
      {
         var _loc2_:Vector3 = param1.state.position;
         this.checkMineRestrictionZone(_loc2_);
         var _loc3_:Number = _loc2_.x - this.center.x;
         var _loc4_:Number = _loc2_.y - this.center.y;
         var _loc5_:Number = _loc2_.z - this.center.z;
         var _loc6_:Number = _loc3_ * _loc3_ + _loc4_ * _loc4_ + _loc5_ * _loc5_;
         if(this.inZone)
         {
            if(_loc6_ > this.radiusSquared)
            {
               this.inZone = false;
               this.ctfModel.onLeaveFlagBaseZone();
            }
         }
         else if(_loc6_ <= this.radiusSquared)
         {
            this.inZone = true;
            this.ctfModel.onEnterFlagBaseZone();
         }
      }
      
      private function checkMineRestrictionZone(param1:Vector3) : void
      {
         var _loc2_:Number = param1.distanceToXYSquared(this.center);
         if(this.inZone)
         {
            if(_loc2_ > this.radiusSquared || !this.isGroundPointInCapturingZone(param1))
            {
               this.inZone = false;
               this.ctfModel.onLeaveFlagBaseZone();
            }
         }
         else if(_loc2_ <= this.radiusSquared && this.isGroundPointInCapturingZone(param1))
         {
            this.inZone = true;
            this.ctfModel.onEnterFlagBaseZone();
         }
      }
      
      private function isGroundPointInCapturingZone(param1:Vector3) : Boolean
      {
         var _loc3_:Vector3 = null;
         var _loc4_:Vector3 = null;
         var _loc2_:Vector3 = new Vector3(this.center.x,this.center.y,this.center.z + FLAG_VISOR_HEIGHT);
         if(this.collisionDetector.raycastStatic(param1,Vector3.DOWN,CollisionGroup.STATIC,10000000000,null,rayHit))
         {
            _loc3_ = rayHit.position;
            _loc3_.z += 0.1;
            _loc4_ = _loc3_.subtract(_loc2_);
            return !this.collisionDetector.raycastStatic(_loc2_,_loc4_,CollisionGroup.STATIC,1,null,rayHit);
         }
         return false;
      }
   }
}

