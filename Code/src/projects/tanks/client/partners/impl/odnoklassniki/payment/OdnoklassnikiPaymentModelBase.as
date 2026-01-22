package projects.tanks.client.partners.impl.odnoklassniki.payment
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class OdnoklassnikiPaymentModelBase extends Model
   {

      protected var server:OdnoklassnikiPaymentModelServer;

      public static const modelId:Long = Long.getLong(1273864280,-1855777834);

      public function OdnoklassnikiPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new OdnoklassnikiPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
