package projects.tanks.client.partners.impl.kongregate
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KongregatePaymentModelBase extends Model
   {

      protected var server:KongregatePaymentModelServer;

      public static const modelId:Long = Long.getLong(1215969521,1635618100);

      public function KongregatePaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KongregatePaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
