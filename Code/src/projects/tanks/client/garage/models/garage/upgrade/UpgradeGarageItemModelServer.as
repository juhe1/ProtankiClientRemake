package projects.tanks.client.garage.models.garage.upgrade
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   
   public class UpgradeGarageItemModelServer
   {
      private var model:IModel;
      
      public function UpgradeGarageItemModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function instantUpgrade(param1:IGameObject, param2:int, param3:int) : void
      {
      }
      
      public function speedUp(param1:IGameObject, param2:int) : void
      {
      }
      
      public function upgradeItem(param1:IGameObject, param2:int, param3:int) : void
      {
      }
   }
}

