package projects.tanks.client.battlefield.models.continuebattle
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

   public class MatchmakingContinueBattleModelServer
   {

      private var model:IModel;

      public function MatchmakingContinueBattleModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function continueBattle(param1:MatchmakingMode) : void
      {
      }
   }
}
