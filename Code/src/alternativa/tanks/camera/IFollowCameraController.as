package alternativa.tanks.camera
{
   import alternativa.math.Vector3;
   
   public interface IFollowCameraController extends CameraController
   {
      
      function getCameraT() : Number;
      
      function setCameraT(param1:Number) : void;
      
      function setLocked(param1:Boolean) : void;
      
      function setTargetParams(param1:Vector3, param2:Vector3) : void;
      
      function setTarget(param1:CameraTarget) : void;
      
      function initCameraComponents() : void;
      
      function getCameraState(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3) : void;
      
      function recalculateTargetData() : void;
   }
}

