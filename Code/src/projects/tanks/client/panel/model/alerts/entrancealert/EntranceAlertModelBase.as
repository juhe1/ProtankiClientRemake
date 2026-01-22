package projects.tanks.client.panel.model.alerts.entrancealert
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EntranceAlertModelBase extends Model
   {

      protected var server:EntranceAlertModelServer;

      public static const modelId:Long = Long.getLong(1825522664,-327255425);

      public function EntranceAlertModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EntranceAlertModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
