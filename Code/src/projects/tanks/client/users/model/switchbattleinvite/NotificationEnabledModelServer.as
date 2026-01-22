package projects.tanks.client.users.model.switchbattleinvite
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class NotificationEnabledModelServer
   {

      private var model:IModel;

      public function NotificationEnabledModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function enable(param1:Boolean) : void
      {
      }
   }
}
