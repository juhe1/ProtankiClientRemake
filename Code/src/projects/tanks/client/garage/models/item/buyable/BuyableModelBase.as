package projects.tanks.client.garage.models.item.buyable
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.buyable.BuyableCC;

   public class BuyableModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(644770553,-155779331);

      protected var server:BuyableModelServer;

      public function BuyableModelBase()
      {
         super();
         this.server = new BuyableModelServer(IModel(this));
      }

      protected function getInitParam() : BuyableCC
      {
         return BuyableCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
