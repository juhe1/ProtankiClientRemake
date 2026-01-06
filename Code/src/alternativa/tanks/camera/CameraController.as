package alternativa.tanks.camera
{
   import platform.client.fp10.core.type.AutoClosable;
   
   public interface CameraController extends AutoClosable
   {
      
      function deactivate() : void;
      
      function activate() : void;
      
      function update(param1:int, param2:int) : void;
   }
}

