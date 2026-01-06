package projects.tanks.client.battlefield.types
{
   public class DamageType
   {
      
      public static const SMOKY:DamageType = new DamageType(0,"SMOKY");
      
      public static const SMOKY_CRITICAL:DamageType = new DamageType(1,"SMOKY_CRITICAL");
      
      public static const FIREBIRD:DamageType = new DamageType(2,"FIREBIRD");
      
      public static const FIREBIRD_OVERHEAT:DamageType = new DamageType(3,"FIREBIRD_OVERHEAT");
      
      public static const TWINS:DamageType = new DamageType(4,"TWINS");
      
      public static const RAILGUN:DamageType = new DamageType(5,"RAILGUN");
      
      public static const ISIS:DamageType = new DamageType(6,"ISIS");
      
      public static const MINE:DamageType = new DamageType(7,"MINE");
      
      public static const THUNDER:DamageType = new DamageType(8,"THUNDER");
      
      public static const RICOCHET:DamageType = new DamageType(9,"RICOCHET");
      
      public static const FREEZE:DamageType = new DamageType(10,"FREEZE");
      
      public static const SHAFT:DamageType = new DamageType(11,"SHAFT");
      
      public static const MACHINE_GUN:DamageType = new DamageType(12,"MACHINE_GUN");
      
      public static const SHOTGUN:DamageType = new DamageType(13,"SHOTGUN");
      
      public static const ROCKET:DamageType = new DamageType(14,"ROCKET");
      
      public static const ARTILLERY:DamageType = new DamageType(15,"ARTILLERY");
      
      public static const TERMINATOR:DamageType = new DamageType(16,"TERMINATOR");
      
      public static const BOMB:DamageType = new DamageType(17,"BOMB");
      
      private var _value:int;
      
      private var _name:String;
      
      public function DamageType(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<DamageType>
      {
         var _loc1_:Vector.<DamageType> = new Vector.<DamageType>();
         _loc1_.push(SMOKY);
         _loc1_.push(SMOKY_CRITICAL);
         _loc1_.push(FIREBIRD);
         _loc1_.push(FIREBIRD_OVERHEAT);
         _loc1_.push(TWINS);
         _loc1_.push(RAILGUN);
         _loc1_.push(ISIS);
         _loc1_.push(MINE);
         _loc1_.push(THUNDER);
         _loc1_.push(RICOCHET);
         _loc1_.push(FREEZE);
         _loc1_.push(SHAFT);
         _loc1_.push(MACHINE_GUN);
         _loc1_.push(SHOTGUN);
         _loc1_.push(ROCKET);
         _loc1_.push(ARTILLERY);
         _loc1_.push(TERMINATOR);
         _loc1_.push(BOMB);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "DamageType [" + this._name + "]";
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

