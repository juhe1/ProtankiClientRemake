package projects.tanks.client.commons.types
{
   public class ItemCategoryEnum
   {
      public static const WEAPON:ItemCategoryEnum = new ItemCategoryEnum(0,"WEAPON");
      
      public static const ARMOR:ItemCategoryEnum = new ItemCategoryEnum(1,"ARMOR");
      
      public static const COLOR:ItemCategoryEnum = new ItemCategoryEnum(2,"COLOR");
      
      public static const INVENTORY:ItemCategoryEnum = new ItemCategoryEnum(3,"INVENTORY");
      
      public static const PLUGIN:ItemCategoryEnum = new ItemCategoryEnum(4,"PLUGIN");
      
      public static const KIT:ItemCategoryEnum = new ItemCategoryEnum(5,"KIT");
      
      public static const EMBLEM:ItemCategoryEnum = new ItemCategoryEnum(6,"EMBLEM");
      
      public static const PRESENT:ItemCategoryEnum = new ItemCategoryEnum(7,"PRESENT");
      
      public static const GIVEN_PRESENT:ItemCategoryEnum = new ItemCategoryEnum(8,"GIVEN_PRESENT");
      
      private var _value:int;
      
      private var _name:String;
      
      public function ItemCategoryEnum(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<ItemCategoryEnum>
      {
         var _loc1_:Vector.<ItemCategoryEnum> = new Vector.<ItemCategoryEnum>();
         _loc1_.push(WEAPON);
         _loc1_.push(ARMOR);
         _loc1_.push(COLOR);
         _loc1_.push(INVENTORY);
         _loc1_.push(PLUGIN);
         _loc1_.push(KIT);
         _loc1_.push(EMBLEM);
         _loc1_.push(PRESENT);
         _loc1_.push(GIVEN_PRESENT);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "ItemCategoryEnum [" + this._name + "]";
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

