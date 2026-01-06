package alternativa.tanks.camera
{
   public class DummyCameraController implements CameraController
   {
      
      public static const INSTANCE:DummyCameraController = new DummyCameraController();
      
      public function DummyCameraController()
      {
         super();
      }
      
      public function update(param1:int, param2:int) : void
      {
      }
      
      public function deactivate() : void
      {
      }
      
      public function activate() : void
      {
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
      }
   }
}

