package projects.tanks.client.battleselect.model.item
{
   public class BattleSuspicionLevel
   {
      public static const NONE:BattleSuspicionLevel = new BattleSuspicionLevel(0,"NONE");
      
      public static const LOW:BattleSuspicionLevel = new BattleSuspicionLevel(1,"LOW");
      
      public static const HIGH:BattleSuspicionLevel = new BattleSuspicionLevel(2,"HIGH");
      
      private var _value:int;
      
      private var _name:String;
      
      public function BattleSuspicionLevel(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<BattleSuspicionLevel>
      {
         var _loc1_:Vector.<BattleSuspicionLevel> = new Vector.<BattleSuspicionLevel>();
         _loc1_.push(NONE);
         _loc1_.push(LOW);
         _loc1_.push(HIGH);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "BattleSuspicionLevel [" + this._name + "]";
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

