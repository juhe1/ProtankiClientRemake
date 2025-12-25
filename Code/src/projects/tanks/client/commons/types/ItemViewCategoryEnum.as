package projects.tanks.client.commons.types
{
   public class ItemViewCategoryEnum
   {
      public static const WEAPON:ItemViewCategoryEnum = new ItemViewCategoryEnum(0,"WEAPON");
      
      public static const ARMOR:ItemViewCategoryEnum = new ItemViewCategoryEnum(1,"ARMOR");
      
      public static const PAINT:ItemViewCategoryEnum = new ItemViewCategoryEnum(2,"PAINT");
      
      public static const INVENTORY:ItemViewCategoryEnum = new ItemViewCategoryEnum(3,"INVENTORY");
      
      public static const KIT:ItemViewCategoryEnum = new ItemViewCategoryEnum(4,"KIT");
      
      public static const SPECIAL:ItemViewCategoryEnum = new ItemViewCategoryEnum(5,"SPECIAL");
      
      public static const GIVEN_PRESENTS:ItemViewCategoryEnum = new ItemViewCategoryEnum(6,"GIVEN_PRESENTS");
      
      private var _value:int;
      
      private var _name:String;
      
      public function ItemViewCategoryEnum(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<ItemViewCategoryEnum>
      {
         var _loc1_:Vector.<ItemViewCategoryEnum> = new Vector.<ItemViewCategoryEnum>();
         _loc1_.push(WEAPON);
         _loc1_.push(ARMOR);
         _loc1_.push(PAINT);
         _loc1_.push(INVENTORY);
         _loc1_.push(KIT);
         _loc1_.push(SPECIAL);
         _loc1_.push(GIVEN_PRESENTS);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "ItemViewCategoryEnum [" + this._name + "]";
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

