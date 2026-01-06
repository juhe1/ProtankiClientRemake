package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn
{
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   
   public class RemoteSpawnHandler implements SpawnHandler
   {
      
      public function RemoteSpawnHandler()
      {
         super();
      }
      
      public function spawn(param1:Tank) : void
      {
         var _loc2_:ITankModel = ITankModel(param1.user.adapt(ITankModel));
         _loc2_.addTankToExclusionSet(param1);
         _loc2_.configureTankTitleAsRemote(param1.user);
         _loc2_.getTurretController().setControlState(0);
      }
   }
}

