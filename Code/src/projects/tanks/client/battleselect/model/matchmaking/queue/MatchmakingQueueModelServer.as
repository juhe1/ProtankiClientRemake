package projects.tanks.client.battleselect.model.matchmaking.queue
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class MatchmakingQueueModelServer
   {

      private var model:IModel;

      public function MatchmakingQueueModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function register(param1:MatchmakingMode) : void
      {
      }

      public function unregister() : void
      {
      }
   }
}
