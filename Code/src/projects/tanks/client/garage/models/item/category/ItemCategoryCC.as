package projects.tanks.client.garage.models.item.category
{
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   
   public class ItemCategoryCC
   {
      
      private var _category:ItemCategoryEnum;
      
      public function ItemCategoryCC(param1:ItemCategoryEnum = null)
      {
         super();
         this._category = param1;
      }
      
      public function get category() : ItemCategoryEnum
      {
         return this._category;
      }
      
      public function set category(param1:ItemCategoryEnum) : void
      {
         this._category = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ItemCategoryCC [";
         _loc1_ += "category = " + this.category + " ";
         return _loc1_ + "]";
      }
   }
}

