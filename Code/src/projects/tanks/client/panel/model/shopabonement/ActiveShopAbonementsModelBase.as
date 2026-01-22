package projects.tanks.client.panel.model.shopabonement
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ActiveShopAbonementsModelBase extends Model
   {

      protected var server:ActiveShopAbonementsModelServer;

      public static const modelId:Long = Long.getLong(865583325,1347608741);

      public function ActiveShopAbonementsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ActiveShopAbonementsModelServer(IModel(this));
      }

      protected function getInitParam() : ShopAbonementsCC
      {
         return ShopAbonementsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
