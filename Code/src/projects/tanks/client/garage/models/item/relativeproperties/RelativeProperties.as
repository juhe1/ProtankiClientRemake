package projects.tanks.client.garage.models.item.relativeproperties
{
   public class RelativeProperties
   {
      
      public static const ARMOR:RelativeProperties = new RelativeProperties(0,"ARMOR");
      
      public static const SPEED:RelativeProperties = new RelativeProperties(1,"SPEED");
      
      public static const HANDLING:RelativeProperties = new RelativeProperties(2,"HANDLING");
      
      public static const MASS:RelativeProperties = new RelativeProperties(3,"MASS");
      
      public static const SIZE:RelativeProperties = new RelativeProperties(4,"SIZE");
      
      public static const BURST_DAMAGE:RelativeProperties = new RelativeProperties(5,"BURST_DAMAGE");
      
      public static const DPS:RelativeProperties = new RelativeProperties(6,"DPS");
      
      public static const FIRE_RATE:RelativeProperties = new RelativeProperties(7,"FIRE_RATE");
      
      public static const RANGE:RelativeProperties = new RelativeProperties(8,"RANGE");
      
      public static const COMPLEXITY:RelativeProperties = new RelativeProperties(9,"COMPLEXITY");
      
      private var _value:int;
      
      private var _name:String;
      
      public function RelativeProperties(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<RelativeProperties>
      {
         var _loc1_:Vector.<RelativeProperties> = new Vector.<RelativeProperties>();
         _loc1_.push(ARMOR);
         _loc1_.push(SPEED);
         _loc1_.push(HANDLING);
         _loc1_.push(MASS);
         _loc1_.push(SIZE);
         _loc1_.push(BURST_DAMAGE);
         _loc1_.push(DPS);
         _loc1_.push(FIRE_RATE);
         _loc1_.push(RANGE);
         _loc1_.push(COMPLEXITY);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "RelativeProperties [" + this._name + "]";
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

