package alternativa.tanks.battle.objects.tank.tankchassis
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleUtils;
   
   public class Track
   {
      
      public var body:Body;
      
      public var rays:Vector.<SuspensionRay>;
      
      public var numRays:int;
      
      public var numContacts:int;
      
      public var suspensionParams:SuspensionParams;
      
      public var animationSpeed:Number = 0;
      
      public var side:int;
      
      public const averageSurfaceVelocity:Vector3 = new Vector3();
      
      public function Track(param1:Body, param2:int, param3:Vector3, param4:Number, param5:SuspensionParams, param6:int)
      {
         super();
         this.body = param1;
         this.side = param6;
         this.setTrackParams(param2,param3,param4,param5);
      }
      
      private function setTrackParams(param1:int, param2:Vector3, param3:Number, param4:SuspensionParams) : void
      {
         var _loc7_:Vector3 = null;
         this.numRays = param1;
         this.suspensionParams = param4;
         this.rays = new Vector.<SuspensionRay>(param1);
         var _loc5_:Number = param3 / (param1 - 1);
         var _loc6_:int = 0;
         while(_loc6_ < param1)
         {
            _loc7_ = new Vector3(param2.x,param2.y + 0.5 * param3 - _loc6_ * _loc5_,param2.z);
            this.rays[_loc6_] = new SuspensionRay(this.body,_loc7_,Vector3.DOWN,param4);
            _loc6_++;
         }
      }
      
      public function setCollisionGroup(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.numRays)
         {
            SuspensionRay(this.rays[_loc2_]).collisionGroup = param1;
            _loc2_++;
         }
      }
      
      public function hasContactsWithStatic() : Boolean
      {
         var _loc1_:SuspensionRay = null;
         for each(_loc1_ in this.rays)
         {
            if(_loc1_.hasCollision && !BattleUtils.isTankBody(_loc1_.rayHit.shape.body))
            {
               return true;
            }
         }
         return false;
      }
      
      public function calculateSuspensionContacts(param1:Number) : void
      {
         var _loc4_:SuspensionRay = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         this.numContacts = 0;
         this.averageSurfaceVelocity.x = 0;
         this.averageSurfaceVelocity.y = 0;
         this.averageSurfaceVelocity.z = 0;
         var _loc2_:Vector3 = this.body.state.velocity;
         var _loc3_:int = 0;
         while(_loc3_ < this.numRays)
         {
            _loc4_ = this.rays[_loc3_];
            _loc4_.update(param1);
            if(_loc4_.hasCollision)
            {
               ++this.numContacts;
               this.body.addWorldForceScaled(_loc4_.getGlobalOrigin(),_loc4_.getGlobalDirection(),-_loc4_.springForce);
               this.averageSurfaceVelocity.x += _loc4_.contactVelocity.x;
               this.averageSurfaceVelocity.y += _loc4_.contactVelocity.y;
               this.averageSurfaceVelocity.z += _loc4_.contactVelocity.z;
               _loc5_ = _loc2_.x - _loc4_.contactVelocity.x;
               _loc6_ = _loc2_.y - _loc4_.contactVelocity.y;
               _loc7_ = _loc2_.z - _loc4_.contactVelocity.z;
               _loc4_.speed = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_ + _loc7_ * _loc7_);
            }
            else
            {
               _loc4_.speed = 0;
            }
            _loc3_++;
         }
         if(this.numContacts > 1)
         {
            this.averageSurfaceVelocity.x /= this.numContacts;
            this.averageSurfaceVelocity.y /= this.numContacts;
            this.averageSurfaceVelocity.z /= this.numContacts;
         }
      }
      
      public function setAnimationSpeed(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         if(this.animationSpeed < param1)
         {
            _loc3_ = this.animationSpeed + param2;
            this.animationSpeed = _loc3_ > param1 ? param1 : _loc3_;
         }
         else if(this.animationSpeed > param1)
         {
            _loc3_ = this.animationSpeed - param2;
            this.animationSpeed = _loc3_ < param1 ? param1 : _loc3_;
         }
      }
   }
}

