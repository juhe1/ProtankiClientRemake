package projects.tanks.client.panel.model.payment.modes.alipay
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AlipayPaymentModelBase extends Model
   {

      protected var server:AlipayPaymentModelServer;

      public static const modelId:Long = Long.getLong(905082594,773468886);

      public function AlipayPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AlipayPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
