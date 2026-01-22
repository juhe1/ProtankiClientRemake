package projects.tanks.client.panel.model.payment
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PaymentModelBase extends Model
   {

      protected var server:PaymentModelServer;

      public static const modelId:Long = Long.getLong(330013883,1971598924);

      public function PaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PaymentModelServer(IModel(this));
      }

      protected function getInitParam() : PaymentCC
      {
         return PaymentCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
