package projects.tanks.client.battlefield.models.bonus.bonus
{
   public class BonusesType
   {
      public static const NITRO:BonusesType = new BonusesType(0,"NITRO");
      
      public static const DAMAGE:BonusesType = new BonusesType(1,"DAMAGE");
      
      public static const ARMOR:BonusesType = new BonusesType(2,"ARMOR");
      
      public static const HEALTH:BonusesType = new BonusesType(3,"HEALTH");
      
      public static const CRYSTAL:BonusesType = new BonusesType(4,"CRYSTAL");
      
      public static const GOLD:BonusesType = new BonusesType(5,"GOLD");
      
      public static const SPECIAL:BonusesType = new BonusesType(6,"SPECIAL");
      
      public static const MOON:BonusesType = new BonusesType(7,"MOON");
      
      public static const PUMPKIN:BonusesType = new BonusesType(8,"PUMPKIN");
      
      private var _value:int;
      
      private var _name:String;
      
      public function BonusesType(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<BonusesType>
      {
         var _loc1_:Vector.<BonusesType> = new Vector.<BonusesType>();
         _loc1_.push(NITRO);
         _loc1_.push(DAMAGE);
         _loc1_.push(ARMOR);
         _loc1_.push(HEALTH);
         _loc1_.push(CRYSTAL);
         _loc1_.push(GOLD);
         _loc1_.push(SPECIAL);
         _loc1_.push(MOON);
         _loc1_.push(PUMPKIN);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "BonusesType [" + this._name + "]";
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

