package alternativa.tanks.model.item.itempersonaldiscount
{
   import alternativa.tanks.model.item.discount.DiscountInfo;
   import alternativa.tanks.model.item.discount.ICollectDiscount;
   import alternativa.tanks.model.item.discount.IDiscountCollector;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.garage.models.item.itempersonaldiscount.DiscountData;
   import projects.tanks.client.garage.models.item.itempersonaldiscount.IItemPersonalDiscountModelBase;
   import projects.tanks.client.garage.models.item.itempersonaldiscount.ItemPersonalDiscountModelBase;
   
   [ModelInfo]
   public class ItemPersonalDiscountModel extends ItemPersonalDiscountModelBase implements IItemPersonalDiscountModelBase, ICollectDiscount, ObjectLoadListener
   {
      
      private static const DELAY_IN_SECONDS:int = 5;
      
      public function ItemPersonalDiscountModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc4_:DiscountData = null;
         var _loc5_:uint = 0;
         var _loc1_:Vector.<DiscountInfo> = new Vector.<DiscountInfo>();
         var _loc2_:Vector.<DiscountData> = getInitParam().discounts;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = uint(getTimer() + (_loc4_.duration - DELAY_IN_SECONDS) * 1000);
            _loc1_[_loc3_] = new DiscountInfo(_loc4_.discountForPercent,0,_loc5_);
            _loc3_++;
         }
         putData(DiscountInfo,_loc1_);
      }
      
      public function collectDiscountsInfo(param1:IDiscountCollector) : void
      {
         var _loc2_:DiscountInfo = null;
         for each(_loc2_ in Vector.<DiscountInfo>(getData(DiscountInfo)))
         {
            if(_loc2_ == null)
            {
               continue;
            }
            param1.addDiscount(_loc2_);
         }
      }
   }
}

