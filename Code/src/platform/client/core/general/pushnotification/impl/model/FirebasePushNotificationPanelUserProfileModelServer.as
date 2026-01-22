package platform.client.core.general.pushnotification.impl.model
{
   import platform.client.core.general.pushnotification.api.NotificationClientPlatform;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class FirebasePushNotificationPanelUserProfileModelServer
   {

      private var model:IModel;

      public function FirebasePushNotificationPanelUserProfileModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function storeToken(param1:NotificationClientPlatform, param2:String) : void
      {
      }
   }
}
