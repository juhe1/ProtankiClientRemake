package projects.tanks.client.battlefield.models.user.damageindicator
{
   public class DamageIndicatorType
   {
      
      public static const NORMAL:DamageIndicatorType = new DamageIndicatorType(0,"NORMAL");
      
      public static const CRITICAL:DamageIndicatorType = new DamageIndicatorType(1,"CRITICAL");
      
      public static const FATAL:DamageIndicatorType = new DamageIndicatorType(2,"FATAL");
      
      public static const HEAL:DamageIndicatorType = new DamageIndicatorType(3,"HEAL");
      
      private var _value:int;
      
      private var _name:String;
      
      public function DamageIndicatorType(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<DamageIndicatorType>
      {
         var _loc1_:Vector.<DamageIndicatorType> = new Vector.<DamageIndicatorType>();
         _loc1_.push(NORMAL);
         _loc1_.push(CRITICAL);
         _loc1_.push(FATAL);
         _loc1_.push(HEAL);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "DamageIndicatorType [" + this._name + "]";
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

