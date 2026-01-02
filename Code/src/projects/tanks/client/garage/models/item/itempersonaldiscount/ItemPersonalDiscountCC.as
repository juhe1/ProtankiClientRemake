package projects.tanks.client.garage.models.item.itempersonaldiscount
{
   public class ItemPersonalDiscountCC
   {
      
      private var _discounts:Vector.<DiscountData>;
      
      public function ItemPersonalDiscountCC(param1:Vector.<DiscountData> = null)
      {
         super();
         this._discounts = param1;
      }
      
      public function get discounts() : Vector.<DiscountData>
      {
         return this._discounts;
      }
      
      public function set discounts(param1:Vector.<DiscountData>) : void
      {
         this._discounts = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ItemPersonalDiscountCC [";
         _loc1_ += "discounts = " + this.discounts + " ";
         return _loc1_ + "]";
      }
   }
}

