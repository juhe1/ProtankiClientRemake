package projects.tanks.client.partners.impl.china.china3rdplatform.payment
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class China3rdPlatformPaymentModelBase extends Model
   {

      protected var server:China3rdPlatformPaymentModelServer;

      public static const modelId:Long = Long.getLong(1051840655,1324649819);

      public function China3rdPlatformPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new China3rdPlatformPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
