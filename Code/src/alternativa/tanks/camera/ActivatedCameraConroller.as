package alternativa.tanks.camera
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   
   public class ActivatedCameraConroller implements CameraController
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      public function ActivatedCameraConroller()
      {
         super();
      }
      
      public function activate() : void
      {
         this.battleScene().setCameraController(this);
      }
      
      public function update(param1:int, param2:int) : void
      {
      }
      
      public function deactivate() : void
      {
      }
      
      protected function getCamera() : GameCamera
      {
         return this.battleScene().getCamera();
      }
      
      protected function battleScene() : BattleScene3D
      {
         return battleService.getBattleScene3D();
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
      }
   }
}

