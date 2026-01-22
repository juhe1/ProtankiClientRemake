package platform.client.core.general.pushnotification.impl.model
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FirebasePushNotificationPanelUserProfileModelBase extends Model
   {

      protected var server:FirebasePushNotificationPanelUserProfileModelServer;

      public static const modelId:Long = Long.getLong(2033956669,-1526848204);

      public function FirebasePushNotificationPanelUserProfileModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FirebasePushNotificationPanelUserProfileModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
