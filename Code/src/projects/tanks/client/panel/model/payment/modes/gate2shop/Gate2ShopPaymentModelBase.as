package projects.tanks.client.panel.model.payment.modes.gate2shop
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class Gate2ShopPaymentModelBase extends Model
   {

      protected var server:Gate2ShopPaymentModelServer;

      public static const modelId:Long = Long.getLong(1004681856,-270220968);

      public function Gate2ShopPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new Gate2ShopPaymentModelServer(IModel(this));
      }

      protected function getInitParam() : Gate2ShopPaymentCC
      {
         return Gate2ShopPaymentCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
