package alternativa.tanks.model.item.buyable
{
   import alternativa.tanks.model.item.category.IItemCategory;
   import alternativa.tanks.model.item.discount.IDiscount;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.garage.models.item.buyable.BuyableModelBase;
   import projects.tanks.client.garage.models.item.buyable.IBuyableModelBase;
   
   [ModelInfo]
   public class BuyableModel extends BuyableModelBase implements IBuyableModelBase, IBuyable
   {
      
      public function BuyableModel()
      {
         super();
      }
      
      public function getPriceWithoutDiscount() : int
      {
         return getInitParam().priceWithoutDiscount;
      }
      
      public function getPrice() : int
      {
         //if(object.hasModel(IDroppableGoldItemModelBase))
         //{
         //   return 0;
         //}
         var _loc1_:IDiscount = IDiscount(object.adapt(IDiscount));
         return _loc1_.applyDiscount(getInitParam().priceWithoutDiscount);
      }
      
      public function isBuyable() : Boolean
      {
         var _loc1_:ItemCategoryEnum = IItemCategory(object.adapt(IItemCategory)).getCategory();
         return getInitParam().buyable; // || _loc1_ == ItemCategoryEnum.CONTAINER;
      }
   }
}

