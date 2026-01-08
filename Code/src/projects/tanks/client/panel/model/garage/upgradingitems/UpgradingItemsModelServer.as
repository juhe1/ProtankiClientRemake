package projects.tanks.client.panel.model.garage.upgradingitems
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class UpgradingItemsModelServer
   {

      private var model:IModel;

      public function UpgradingItemsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function itemUpgraded(param1:IGameObject) : void
      {
      }

      public function select(param1:IGameObject) : void
      {
      }
   }
}
