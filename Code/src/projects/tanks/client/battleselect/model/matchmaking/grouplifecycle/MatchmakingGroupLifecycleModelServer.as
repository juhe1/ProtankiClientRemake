package projects.tanks.client.battleselect.model.matchmaking.grouplifecycle
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class MatchmakingGroupLifecycleModelServer
   {

      private var model:IModel;

      public function MatchmakingGroupLifecycleModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function createGroup() : void
      {
      }

      public function leaveGroup() : void
      {
      }

      public function removeUser(param1:Long) : void
      {
      }
   }
}
