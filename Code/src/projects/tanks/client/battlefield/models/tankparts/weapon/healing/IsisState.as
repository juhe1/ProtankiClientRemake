package projects.tanks.client.battlefield.models.tankparts.weapon.healing
{
   public class IsisState
   {
      
      public static const OFF:IsisState = new IsisState(0,"OFF");
      
      public static const IDLE:IsisState = new IsisState(1,"IDLE");
      
      public static const HEALING:IsisState = new IsisState(2,"HEALING");
      
      public static const DAMAGING:IsisState = new IsisState(3,"DAMAGING");
      
      private var _value:int;
      
      private var _name:String;
      
      public function IsisState(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<IsisState>
      {
         var _loc1_:Vector.<IsisState> = new Vector.<IsisState>();
         _loc1_.push(OFF);
         _loc1_.push(IDLE);
         _loc1_.push(HEALING);
         _loc1_.push(DAMAGING);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "IsisState [" + this._name + "]";
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

