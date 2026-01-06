package alternativa.tanks.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   
   public class MovingObject3DPositionProvider extends PooledObject implements Object3DPositionProvider
   {
      
      private var initialPosition:Vector3 = new Vector3();
      
      private var velocity:Vector3 = new Vector3();
      
      private var acceleration:Number;
      
      public function MovingObject3DPositionProvider(param1:Pool)
      {
         super(param1);
      }
      
      public function initPosition(param1:Object3D) : void
      {
         param1.x = this.initialPosition.x;
         param1.y = this.initialPosition.y;
         param1.z = this.initialPosition.z;
      }
      
      public function init(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         this.initialPosition.copy(param1);
         this.velocity.copy(param2);
         this.acceleration = param3;
      }
      
      public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void
      {
         var _loc4_:Number = 0.001 * param3;
         param1.x += this.velocity.x * _loc4_;
         param1.y += this.velocity.y * _loc4_;
         param1.z += this.velocity.z * _loc4_;
         var _loc5_:Number = this.velocity.length();
         _loc5_ += this.acceleration * _loc4_;
         if(_loc5_ <= 0)
         {
            this.velocity.reset();
         }
         else
         {
            this.velocity.normalize();
            this.velocity.scale(_loc5_);
         }
      }
      
      public function destroy() : void
      {
         recycle();
      }
   }
}

