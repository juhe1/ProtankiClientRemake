package projects.tanks.client.panel.model.userscounter.panel
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class UsersCounterPanelModelServer
   {

      private var model:IModel;

      public function UsersCounterPanelModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function hasNotUniqueUserId() : void
      {
      }

      public function receiveUniqueUserId(param1:Long) : void
      {
      }
   }
}
