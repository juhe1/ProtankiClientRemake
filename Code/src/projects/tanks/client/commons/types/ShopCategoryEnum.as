package projects.tanks.client.commons.types
{
   public class ShopCategoryEnum
   {
      
      public static const CRYSTALS:ShopCategoryEnum = new ShopCategoryEnum(0,"CRYSTALS");
      
      public static const PREMIUM:ShopCategoryEnum = new ShopCategoryEnum(1,"PREMIUM");
      
      public static const GOLD_BOXES:ShopCategoryEnum = new ShopCategoryEnum(2,"GOLD_BOXES");
      
      public static const PAINTS:ShopCategoryEnum = new ShopCategoryEnum(3,"PAINTS");
      
      public static const KITS:ShopCategoryEnum = new ShopCategoryEnum(4,"KITS");
      
      public static const OTHERS:ShopCategoryEnum = new ShopCategoryEnum(5,"OTHERS");
      
      public static const LOOT_BOXES:ShopCategoryEnum = new ShopCategoryEnum(6,"LOOT_BOXES");
      
      public static const NO_CATEGORY:ShopCategoryEnum = new ShopCategoryEnum(7,"NO_CATEGORY");
      
      private var _value:int;
      
      private var _name:String;
      
      public function ShopCategoryEnum(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<ShopCategoryEnum>
      {
         var _loc1_:Vector.<ShopCategoryEnum> = new Vector.<ShopCategoryEnum>();
         _loc1_.push(CRYSTALS);
         _loc1_.push(PREMIUM);
         _loc1_.push(GOLD_BOXES);
         _loc1_.push(PAINTS);
         _loc1_.push(KITS);
         _loc1_.push(OTHERS);
         _loc1_.push(LOOT_BOXES);
         _loc1_.push(NO_CATEGORY);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "ShopCategoryEnum [" + this._name + "]";
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}

