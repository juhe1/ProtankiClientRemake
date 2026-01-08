package projects.tanks.client.garage.models.shopabonement
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.shopabonement.ShopAbonementCC;

   public class ShopAbonementModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1025127866,1054194996);

      protected var server:ShopAbonementModelServer;

      public function ShopAbonementModelBase()
      {
         super();
         this.server = new ShopAbonementModelServer(IModel(this));
      }

      protected function getInitParam() : ShopAbonementCC
      {
         return ShopAbonementCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
