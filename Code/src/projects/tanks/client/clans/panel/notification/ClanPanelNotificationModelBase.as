package projects.tanks.client.clans.panel.notification
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanPanelNotificationModelBase extends Model
   {

      protected var server:ClanPanelNotificationModelServer;

      public static const modelId:Long = Long.getLong(606942677,1590617894);

      public function ClanPanelNotificationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanPanelNotificationModelServer(IModel(this));
      }

      protected function getInitParam() : ClanPanelNotificationCC
      {
         return ClanPanelNotificationCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
