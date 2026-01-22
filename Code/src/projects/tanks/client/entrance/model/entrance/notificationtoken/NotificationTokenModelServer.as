package projects.tanks.client.entrance.model.entrance.notificationtoken
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.entrance.model.users.pushnotification.NotificationClientPlatform;

   public class NotificationTokenModelServer
   {

      private var model:IModel;

      public function NotificationTokenModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function storeToken(param1:NotificationClientPlatform, param2:String) : void
      {
      }
   }
}
