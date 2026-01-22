package projects.tanks.client.entrance.model.entrance.notificationtoken
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NotificationTokenModelBase extends Model
   {

      protected var server:NotificationTokenModelServer;

      public static const modelId:Long = Long.getLong(185921630,-1096375880);

      public function NotificationTokenModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NotificationTokenModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
