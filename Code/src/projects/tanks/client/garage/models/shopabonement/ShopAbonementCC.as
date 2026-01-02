package projects.tanks.client.garage.models.shopabonement
{
   import projects.tanks.client.commons.types.ShopCategoryEnum;
   
   public class ShopAbonementCC
   {
      
      private var _shopCategory:ShopCategoryEnum;
      
      public function ShopAbonementCC(param1:ShopCategoryEnum = null)
      {
         super();
         this._shopCategory = param1;
      }
      
      public function get shopCategory() : ShopCategoryEnum
      {
         return this._shopCategory;
      }
      
      public function set shopCategory(param1:ShopCategoryEnum) : void
      {
         this._shopCategory = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ShopAbonementCC [";
         _loc1_ += "shopCategory = " + this.shopCategory + " ";
         return _loc1_ + "]";
      }
   }
}

