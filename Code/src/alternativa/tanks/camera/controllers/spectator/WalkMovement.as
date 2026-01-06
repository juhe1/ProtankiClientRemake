package alternativa.tanks.camera.controllers.spectator
{
   import alternativa.math.Vector3;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.tanks.camera.GameCamera;
   
   internal class WalkMovement implements MovementMethod
   {
      
      private static const direction:Vector3 = new Vector3();
      
      private static const localDirection:Vector3 = new Vector3();
      
      private var _accelerationInverted:Boolean = false;
      
      private var conSpeed:ConsoleVarFloat;
      
      private var conAcceleration:ConsoleVarFloat;
      
      private var conDeceleration:ConsoleVarFloat;
      
      public function WalkMovement(param1:ConsoleVarFloat, param2:ConsoleVarFloat, param3:ConsoleVarFloat)
      {
         super();
         this.conSpeed = param1;
         this.conAcceleration = param2;
         this.conDeceleration = param3;
      }
      
      public function getDisplacement(param1:UserInput, param2:GameCamera, param3:Number) : Vector3
      {
         localDirection.y = param1.getForwardDirection();
         localDirection.x = param1.getSideDirection();
         var _loc4_:Number = Math.cos(param2.rotationZ);
         var _loc5_:Number = Math.sin(param2.rotationZ);
         direction.x = localDirection.x * _loc4_ - localDirection.y * _loc5_;
         direction.y = localDirection.x * _loc5_ + localDirection.y * _loc4_;
         direction.z = param1.getVerticalDirection();
         if(direction.lengthSqr() > 0)
         {
            direction.normalize();
         }
         if(param1.isAccelerated())
         {
            if(this._accelerationInverted)
            {
               direction.scale(this.conSpeed.value * this.conDeceleration.value * param3);
            }
            else
            {
               direction.scale(this.conSpeed.value * this.conAcceleration.value * param3);
            }
         }
         else
         {
            direction.scale(this.conSpeed.value * param3);
         }
         return direction;
      }
      
      public function invertAcceleration() : *
      {
         this._accelerationInverted = !this._accelerationInverted;
      }
      
      public function accelerationInverted() : Boolean
      {
         return this._accelerationInverted;
      }
      
      public function setAccelerationInverted(param1:Boolean) : *
      {
         this._accelerationInverted = param1;
      }
   }
}

