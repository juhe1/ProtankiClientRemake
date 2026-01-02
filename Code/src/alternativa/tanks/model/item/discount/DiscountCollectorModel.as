package alternativa.tanks.model.item.discount
{
   import alternativa.tanks.model.item.discount.proabonement.ProAbonementRankDiscount;
   import flash.utils.getTimer;
   import projects.tanks.client.garage.models.item.discount.DiscountCollectorModelBase;
   import projects.tanks.client.garage.models.item.discount.IDiscountCollectorModelBase;
   
   [ModelInfo]
   public class DiscountCollectorModel extends DiscountCollectorModelBase implements IDiscountCollectorModelBase, IDiscount
   {
      
      public function DiscountCollectorModel()
      {
         super();
      }
      
      public function getDiscountInPercent() : int
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = this.getDiscount();
         if(object.hasModel(ProAbonementRankDiscount))
         {
            _loc2_ = ProAbonementRankDiscount(object.adapt(ProAbonementRankDiscount)).getRankDiscount() * 0.01;
            _loc1_ = (_loc1_ - _loc2_) / (1 - _loc2_);
         }
         return _loc1_ * 100 + 0.0001;
      }
      
      public function applyDiscount(param1:int) : int
      {
         var _loc5_:DiscountInfo = null;
         var _loc6_:int = 0;
         var _loc2_:int = getTimer();
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc4_:DiscountCollector = new DiscountCollector();
         ICollectDiscount(object.event(ICollectDiscount)).collectDiscountsInfo(_loc4_);
         for each(_loc5_ in _loc4_.getDiscountInfoes())
         {
            if(_loc5_.hasDiscount() && _loc5_.isDiscountTime(_loc2_))
            {
               _loc3_.push(_loc5_.getDiscountInPercent());
            }
         }
         _loc3_.sort(Array.NUMERIC);
         for each(_loc6_ in _loc3_)
         {
            param1 = int(param1 * (100 - _loc6_) / 100 + 0.001);
         }
         return param1;
      }
      
      private function getDiscount() : Number
      {
         var _loc4_:DiscountInfo = null;
         var _loc1_:Number = 0;
         var _loc2_:int = getTimer();
         var _loc3_:DiscountCollector = new DiscountCollector();
         ICollectDiscount(object.event(ICollectDiscount)).collectDiscountsInfo(_loc3_);
         for each(_loc4_ in _loc3_.getDiscountInfoes())
         {
            if(_loc4_.isDiscountTime(_loc2_))
            {
               _loc1_ = 1 - (1 - _loc1_) * (1 - _loc4_.getDiscountInPercent() * 0.01);
            }
         }
         return _loc1_;
      }
   }
}

