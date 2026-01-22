package projects.tanks.client.panel.model.payment.modes.platbox
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PlatBoxPaymentModelBase extends Model
   {

      protected var server:PlatBoxPaymentModelServer;

      public static const modelId:Long = Long.getLong(1738044130,-258469210);

      public function PlatBoxPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PlatBoxPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
