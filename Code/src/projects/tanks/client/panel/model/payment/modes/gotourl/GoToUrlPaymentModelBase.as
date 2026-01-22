package projects.tanks.client.panel.model.payment.modes.gotourl
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class GoToUrlPaymentModelBase extends Model
   {

      protected var server:GoToUrlPaymentModelServer;

      public static const modelId:Long = Long.getLong(662905925,-149486694);

      public function GoToUrlPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new GoToUrlPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
