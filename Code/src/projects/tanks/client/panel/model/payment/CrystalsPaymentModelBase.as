package projects.tanks.client.panel.model.payment
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CrystalsPaymentModelBase extends Model
   {

      protected var server:CrystalsPaymentModelServer;

      public static const modelId:Long = Long.getLong(1836258467,-1815527913);

      public function CrystalsPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new CrystalsPaymentModelServer(IModel(this));
      }

      protected function getInitParam() : CrystalsPaymentCC
      {
         return CrystalsPaymentCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
