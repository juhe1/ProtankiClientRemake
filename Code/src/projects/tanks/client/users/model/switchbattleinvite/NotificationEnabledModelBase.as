package projects.tanks.client.users.model.switchbattleinvite
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NotificationEnabledModelBase extends Model
   {

      protected var server:NotificationEnabledModelServer;

      public static const modelId:Long = Long.getLong(1190039526,-1224288945);

      public function NotificationEnabledModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NotificationEnabledModelServer(IModel(this));
      }

      protected function getInitParam() : NotificationEnabledCC
      {
         return NotificationEnabledCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
