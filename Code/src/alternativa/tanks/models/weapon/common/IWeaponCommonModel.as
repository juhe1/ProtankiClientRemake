package alternativa.tanks.models.weapon.common
{
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   
   [ModelInterface]
   public interface IWeaponCommonModel
   {
      
      function getCommonData() : WeaponCommonData;
      
      function getTurretController() : TurretController;
      
      function getLocalTurretController() : LocalTurretController;
      
      function storeTank(param1:Tank) : void;
      
      function getTank() : Tank;
      
      function getGunParams(param1:int = 0) : AllGlobalGunParams;
   }
}

