package projects.tanks.client.panel.model.payment.panel
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PaymentButtonModelBase extends Model
   {

      protected var server:PaymentButtonModelServer;

      public static const modelId:Long = Long.getLong(735308238,-192682652);

      public function PaymentButtonModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PaymentButtonModelServer(IModel(this));
      }

      protected function getInitParam() : PaymentButtonCC
      {
         return PaymentButtonCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
