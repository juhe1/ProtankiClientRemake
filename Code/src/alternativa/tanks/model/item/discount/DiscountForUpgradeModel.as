package alternativa.tanks.model.item.discount
{
   import alternativa.tanks.service.item.ItemService;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.garage.models.item.upgradeable.discount.DiscountForUpgradeModelBase;
   import projects.tanks.client.garage.models.item.upgradeable.discount.IDiscountForUpgradeModelBase;
   
   [ModelInfo]
   public class DiscountForUpgradeModel extends DiscountForUpgradeModelBase implements IDiscountForUpgradeModelBase, ICollectDiscount
   {
      
      [Inject] // added
      public static var itemService:ItemService;
      
      public function DiscountForUpgradeModel()
      {
         super();
      }
      
      public function collectDiscountsInfo(param1:IDiscountCollector) : void
      {
         var _loc2_:IGameObject = itemService.getPreviousModification(object);
         //if(_loc2_ != null && Boolean(itemService.getUpgradableItemParams(_loc2_).isFullUpgraded()))
         //{
         //   param1.addDiscount(DiscountInfo.FULL_DISCOUNT);
         //}
      }
   }
}

