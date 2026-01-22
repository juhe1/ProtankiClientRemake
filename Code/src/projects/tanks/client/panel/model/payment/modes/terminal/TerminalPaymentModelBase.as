package projects.tanks.client.panel.model.payment.modes.terminal
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TerminalPaymentModelBase extends Model
   {

      protected var server:TerminalPaymentModelServer;

      public static const modelId:Long = Long.getLong(1869072851,552140822);

      public function TerminalPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TerminalPaymentModelServer(IModel(this));
      }

      protected function getInitParam() : TerminalPaymentCC
      {
         return TerminalPaymentCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
