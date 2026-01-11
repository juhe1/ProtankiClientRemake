package projects.tanks.client.battlefield.models.bonus.battle.battlefield
{
   import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;
   
   public interface IBattlefieldBonusesModelBase
   {
      
      function attemptToTakeBonusFailedTankNotActive(param1:String) : void;
      
      function bonusTaken(param1:String) : void;
      
      function removeBonuses(param1:Vector.<String>) : void;
      
      function spawnBonuses(param1:Vector.<BonusSpawnData>) : void;
      
      function spawnBonusesOnGround(param1:Vector.<BonusSpawnData>) : void;
   }
}

