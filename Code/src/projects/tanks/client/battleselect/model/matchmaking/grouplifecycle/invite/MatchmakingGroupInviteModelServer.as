package projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.invite
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class MatchmakingGroupInviteModelServer
   {

      private var model:IModel;

      public function MatchmakingGroupInviteModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function accept(param1:Long) : void
      {
      }

      public function reject(param1:Long) : void
      {
      }

      public function sendInvite(param1:Long) : void
      {
      }
   }
}
