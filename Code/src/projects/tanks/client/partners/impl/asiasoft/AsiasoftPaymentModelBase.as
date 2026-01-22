package projects.tanks.client.partners.impl.asiasoft
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AsiasoftPaymentModelBase extends Model
   {

      protected var server:AsiasoftPaymentModelServer;

      public static const modelId:Long = Long.getLong(1386392731,192355220);

      public function AsiasoftPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AsiasoftPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
