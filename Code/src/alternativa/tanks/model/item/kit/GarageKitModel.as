package alternativa.tanks.model.item.kit
{
   import alternativa.tanks.model.item.discount.DiscountInfo;
   import alternativa.tanks.model.item.discount.ICollectDiscount;
   import alternativa.tanks.model.item.discount.IDiscount;
   import alternativa.tanks.model.item.discount.IDiscountCollector;
   import alternativa.tanks.service.item.ItemService;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.garage.models.item.kit.GarageKitModelBase;
   import projects.tanks.client.garage.models.item.kit.IGarageKitModelBase;
   import projects.tanks.client.garage.models.item.kit.KitItem;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.garage.models.item.kit.GarageKitCC;
   
   [ModelInfo]
   public class GarageKitModel extends GarageKitModelBase implements IGarageKitModelBase, GarageKit, ICollectDiscount
   {
      
      [Inject] // added
      public static var itemService:ItemService;
      
      [Inject] // added
      public static var userPropertyService:IUserPropertiesService;
      
      public function GarageKitModel()
      {
         super();
      }
      
      public function getImage() : ImageResource
      {
         return getInitParam().image;
      }
      
      public function getPrice() : int
      {
         var _loc1_:int = this.getPriceWithoutDiscount();
         var _loc2_:IDiscount = IDiscount(object.adapt(IDiscount));
         return _loc2_.applyDiscount(_loc1_);
      }
      
      public function getPriceWithoutDiscount() : int
      {
         var _loc2_:KitItem = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.getItems())
         {
            _loc1_ += itemService.getPriceWithoutDiscount(_loc2_.item) * _loc2_.count;
         }
         return _loc1_;
      }
      
      public function getPriceAlreadyBought() : int
      {
         var _loc2_:KitItem = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.getItems())
         {
            if(Boolean(itemService.hasItem(_loc2_.item)) && !itemService.isCountable(_loc2_.item) && itemService.getCategory(_loc2_.item) != ItemCategoryEnum.PLUGIN)
            {
               _loc1_ += itemService.getPrice(_loc2_.item) * _loc2_.count;
            }
         }
         return _loc1_;
      }
      
      public function getPriceYouSave() : int
      {
         return this.getPriceWithoutDiscount() - this.getPrice() - this.getPriceAlreadyBought();
      }
      
      public function canBuy() : Boolean
      {
         var _loc1_:KitItem = null;
         for each(_loc1_ in this.getItems())
         {
            if(!itemService.hasItem(_loc1_.item) && itemService.getMinRankIndex(_loc1_.item) > userPropertyService.rank)
            {
               return true;
            }
         }
         return this.getPriceYouSave() > 0;
      }
      
      public function getItems() : Vector.<KitItem>
      {
         return getInitParam().kitItems;
      }
      
      public function collectDiscountsInfo(param1:IDiscountCollector) : void
      {
         var initParams:GarageKitCC = getInitParam();
         if(initParams == null)
         {
            return;
         }
         param1.addDiscount(new DiscountInfo(initParams.discountInPercent,0));
      }
   }
}

