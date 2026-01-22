package projects.tanks.client.panel.model.payment.modes.sms
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SMSPayModeModelBase extends Model
   {

      protected var server:SMSPayModeModelServer;

      public static const modelId:Long = Long.getLong(1938293825,420250171);

      public function SMSPayModeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SMSPayModeModelServer(IModel(this));
      }

      protected function getInitParam() : SMSPayModeCC
      {
         return SMSPayModeCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
