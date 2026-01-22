package projects.tanks.client.panel.model.payment.modes.pricerange
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PriceRangeModelBase extends Model
   {

      protected var server:PriceRangeModelServer;

      public static const modelId:Long = Long.getLong(1510900807,1636785662);

      public function PriceRangeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PriceRangeModelServer(IModel(this));
      }

      protected function getInitParam() : PriceRangeCC
      {
         return PriceRangeCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
