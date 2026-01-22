package projects.tanks.client.panel.model.payment.modes.leogaming.mobile
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LeogamingPaymentMobileModelBase extends Model
   {

      protected var server:LeogamingPaymentMobileModelServer;

      public static const modelId:Long = Long.getLong(952947688,-264256106);

      public function LeogamingPaymentMobileModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LeogamingPaymentMobileModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
