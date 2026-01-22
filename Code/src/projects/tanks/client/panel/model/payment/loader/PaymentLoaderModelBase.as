package projects.tanks.client.panel.model.payment.loader
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PaymentLoaderModelBase extends Model
   {

      protected var server:PaymentLoaderModelServer;

      public static const modelId:Long = Long.getLong(235042838,289855486);

      public function PaymentLoaderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PaymentLoaderModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
