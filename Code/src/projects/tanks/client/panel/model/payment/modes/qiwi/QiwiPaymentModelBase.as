package projects.tanks.client.panel.model.payment.modes.qiwi
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class QiwiPaymentModelBase extends Model
   {

      protected var server:QiwiPaymentModelServer;

      public static const modelId:Long = Long.getLong(1394146469,-1218623146);

      public function QiwiPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new QiwiPaymentModelServer(IModel(this));
      }

      protected function getInitParam() : QiwiPaymentCC
      {
         return QiwiPaymentCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
