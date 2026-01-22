package projects.tanks.client.partners.impl.facebook.payment
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FacebookPaymentModelBase extends Model
   {

      protected var server:FacebookPaymentModelServer;

      public static const modelId:Long = Long.getLong(698539894,1283037116);

      public function FacebookPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FacebookPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
