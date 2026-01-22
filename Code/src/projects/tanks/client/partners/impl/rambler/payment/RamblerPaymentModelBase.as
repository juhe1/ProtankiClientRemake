package projects.tanks.client.partners.impl.rambler.payment
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RamblerPaymentModelBase extends Model
   {

      protected var server:RamblerPaymentModelServer;

      public static const modelId:Long = Long.getLong(723546009,-53480122);

      public function RamblerPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RamblerPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
