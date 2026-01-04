package alternativa.tanks.gui.alerts
{
   import alternativa.tanks.service.upgradingitems.ItemInfo;
   import projects.tanks.client.commons.types.ItemGarageProperty;
   import projects.tanks.client.panel.model.garage.GarageItemInfo;
   
   public class UpgradedItemsAlert extends ItemsAlert
   {
      
      public function UpgradedItemsAlert(param1:Vector.<ItemInfo>, param2:String, param3:String)
      {
         super(param2,param3,this.addItems,param1);
      }
      
      private function addItems(param1:Vector.<ItemInfo>) : void
      {
         var _loc4_:ItemInfo = null;
         var _loc5_:Vector.<ItemGarageProperty> = null;
         var _loc6_:GarageItemInfo = null;
         var _loc7_:int = 0;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = _loc4_.resistances;
            _loc6_ = _loc4_.info;
            _loc7_ = 0;
            partsList.addItem(_loc6_.item,_loc6_.name,_loc6_.category,_loc6_.position,0,_loc7_,false,true,0,_loc6_.preview,0,null,_loc6_.modificationIndex,null,_loc5_,true);
            _loc3_++;
         }
      }
   }
}

