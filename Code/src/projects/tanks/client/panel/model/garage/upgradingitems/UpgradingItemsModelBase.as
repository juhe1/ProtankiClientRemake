package projects.tanks.client.panel.model.garage.upgradingitems
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UpgradingItemsModelBase extends Model
   {

      protected var server:UpgradingItemsModelServer;

      public static const modelId:Long = Long.getLong(1118995569,-1424498497);

      public function UpgradingItemsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UpgradingItemsModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
