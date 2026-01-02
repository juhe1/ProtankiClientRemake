package projects.tanks.client.garage.models.item.premium
{
   public class PremiumItemCC
   {
      
      private var _premiumItem:Boolean;
      
      public function PremiumItemCC(param1:Boolean = false)
      {
         super();
         this._premiumItem = param1;
      }
      
      public function get premiumItem() : Boolean
      {
         return this._premiumItem;
      }
      
      public function set premiumItem(param1:Boolean) : void
      {
         this._premiumItem = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "PremiumItemCC [";
         _loc1_ += "premiumItem = " + this.premiumItem + " ";
         return _loc1_ + "]";
      }
   }
}

