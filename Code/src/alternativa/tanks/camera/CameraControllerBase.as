package alternativa.tanks.camera
{
   import alternativa.math.Vector3;
   
   public class CameraControllerBase extends ActivatedCameraConroller
   {
      
      public function CameraControllerBase()
      {
         super();
      }
      
      protected function setPosition(param1:Vector3) : void
      {
         var _loc2_:GameCamera = getCamera();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.z = param1.z;
      }
      
      protected function setOrientation(param1:Vector3) : void
      {
         var _loc2_:GameCamera = getCamera();
         _loc2_.rotationX = param1.x;
         _loc2_.rotationY = param1.y;
         _loc2_.rotationZ = param1.z;
      }
      
      protected function rotateBy(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:GameCamera = null;
         _loc4_ = getCamera();
         _loc4_.rotationX += param1;
         _loc4_.rotationY += param2;
         _loc4_.rotationZ += param3;
      }
      
      protected function getCameraPosition() : Vector3
      {
         var _loc1_:GameCamera = getCamera();
         return _loc1_.position;
      }
      
      protected function getCameraRotationX() : Number
      {
         var _loc1_:GameCamera = getCamera();
         return _loc1_.rotationX;
      }
      
      protected function getCameraRotationY() : Number
      {
         var _loc1_:GameCamera = getCamera();
         return _loc1_.rotationY;
      }
      
      protected function getCameraRotationZ() : Number
      {
         var _loc1_:GameCamera = getCamera();
         return _loc1_.rotationZ;
      }
   }
}

