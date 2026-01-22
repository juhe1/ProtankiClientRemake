package projects.tanks.client.battleselect.model.matchmaking.spectator
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

   public class MatchmakingSpectatorEntranceModelServer
   {

      private var model:IModel;

      public function MatchmakingSpectatorEntranceModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function enter(param1:MatchmakingMode) : void
      {
      }
   }
}
