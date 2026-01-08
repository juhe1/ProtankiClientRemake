package projects.tanks.client.battlefield.models.bonus.bonus.notification
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusNotificationModelBase extends Model
   {

      protected var server:BonusNotificationModelServer;

      private static const modelId:Long = Long.getLong(769592937,-1424822430);

      public function BonusNotificationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusNotificationModelServer(IModel(this));
      }

      protected function getInitParam() : NotificationBonusCC
      {
         return NotificationBonusCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
