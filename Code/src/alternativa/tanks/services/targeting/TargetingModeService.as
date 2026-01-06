package alternativa.tanks.services.targeting
{
   import alternativa.tanks.battle.objects.tank.controllers.TurretControlActionMap;
   
   public interface TargetingModeService
   {
      
      function init() : void;
      
      function close() : void;
      
      function tick() : void;
      
      function getCurrentMode() : int;
      
      function setKeyMap(param1:TurretControlActionMap) : void;
      
      function getKeyMap() : TurretControlActionMap;
      
      function blockModeChange() : void;
      
      function unblockModeChange() : void;
   }
}

