package alternativa.tanks.battle
{
   public class BattleRunnerProvider
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public function BattleRunnerProvider()
      {
         super();
      }
      
      protected function getBattleRunner() : BattleRunner
      {
         return battleService.getBattleRunner();
      }
   }
}

