package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   
   public class LocalSpawnHandler implements SpawnHandler
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public function LocalSpawnHandler()
      {
         super();
      }
      
      public function spawn(param1:Tank) : void
      {
         var _loc2_:ITankModel = ITankModel(param1.user.adapt(ITankModel));
         _loc2_.addTankToExclusionSet(param1);
         _loc2_.enableStateCorrection();
         _loc2_.addActivationTask();
         battleService.unlockFollowCamera();
         battleService.activateFollowCamera();
         battleService.getBattleRunner().setLocalBody(param1.getBody());
         _loc2_.getTitle().show();
         _loc2_.configureRemoteTankTitles();
      }
   }
}

