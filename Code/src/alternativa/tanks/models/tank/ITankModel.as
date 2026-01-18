package alternativa.tanks.models.tank
{
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.controllers.ChassisController;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.display.usertitle.UserTitle;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   [ModelInterface]
   public interface ITankModel
   {
      function onReadyToActivate() : void;
      function addActivationTask() : void;

      function getTank() : Tank;
      
      function lockMovementControl(param1:int) : void;
      
      function unlockMovementControl(param1:int) : void;
      
      function getWeaponController() : IWeaponController;
      
      function getChassisController() : ChassisController;
      
      function getTurretController() : TurretController;
      
      function getTitle() : UserTitle;
      
      function getUserInfo() : UserInfo;
      
      function onTurretDirectionCorrection(param1:Boolean) : void;
      
      function sendStateCorrection(param1:Boolean) : void;
      
      function onPrevStateCorrection(param1:Boolean) : void;
      
      function handleCollisionWithOtherTank(param1:Tank) : void;
      
      function sendDeathConfirmationCommand() : void;
      
      function disableStateCorrection() : void;
      
      function enableStateCorrection() : void;
      
      function removeTankFromBattle() : void;
      
      function die(param1:int) : void;
      
      function isLocal() : Boolean;
      
      function configureTankTitleAsRemote(param1:IGameObject) : void;
      
      function configureRemoteTankTitles() : void;
      
      function addTankToBattle(param1:Tank) : void;
      
      function doSetHealth(param1:Number) : void;
      
      function setChassisState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d, param5:int) : void;
      
      function getMovementAnticheatTask() : MovementTimeoutAndDistanceAnticheatTask;
      
      function addTankToExclusionSet(param1:Tank) : void;
      
      function getTankSet() : TankSet;
   }
}

