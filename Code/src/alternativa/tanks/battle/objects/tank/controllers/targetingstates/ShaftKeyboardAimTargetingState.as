package alternativa.tanks.battle.objects.tank.controllers.targetingstates
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.controllers.AimController;
   import alternativa.tanks.battle.objects.tank.controllers.TurretControlActionMap;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   
   public class ShaftKeyboardAimTargetingState extends KeyboardTargetingState implements AimController
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var camera:GameCamera;
      
      public function ShaftKeyboardAimTargetingState(param1:TurretController)
      {
         super(param1);
         setKeyMap(new TurretControlActionMap(GameActionEnum.CHASSIS_LEFT_MOVEMENT,GameActionEnum.CHASSIS_RIGHT_MOVEMENT,GameActionEnum.CENTER_TURRET,GameActionEnum.CHASSIS_FORWARD_MOVEMENT,GameActionEnum.CHASSIS_BACKWARD_MOVEMENT));
         this.camera = battleService.getBattleScene3D().getCamera();
      }
      
      public function getAimDirection(param1:Vector3) : void
      {
         param1.copy(this.camera.zAxis);
      }
      
      override protected function applyAction(param1:GameActionEnum, param2:Boolean) : void
      {
         super.applyAction(param1,param2);
         switch(param1)
         {
            case GameActionEnum.ROTATE_TURRET_LEFT:
               turretController.rotateLeft(param2);
               break;
            case GameActionEnum.ROTATE_TURRET_RIGHT:
               turretController.rotateRight(param2);
               break;
            case GameActionEnum.CENTER_TURRET:
               turretController.center(param2);
         }
      }
   }
}

