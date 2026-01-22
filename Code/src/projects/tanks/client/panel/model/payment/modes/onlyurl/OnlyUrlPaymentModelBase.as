package projects.tanks.client.panel.model.payment.modes.onlyurl
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class OnlyUrlPaymentModelBase extends Model
   {

      protected var server:OnlyUrlPaymentModelServer;

      public static const modelId:Long = Long.getLong(969748537,-1870265676);

      public function OnlyUrlPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new OnlyUrlPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
