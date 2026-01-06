package projects.tanks.client.battlefield.models.battle.pointbased.flag
{
   public class FlyingMode
   {
      
      public static const FLY:FlyingMode = new FlyingMode(0,"FLY");
      
      public static const ROLL:FlyingMode = new FlyingMode(1,"ROLL");
      
      public static const IMPACT:FlyingMode = new FlyingMode(2,"IMPACT");
      
      public static const DROP:FlyingMode = new FlyingMode(3,"DROP");
      
      public static const KILL:FlyingMode = new FlyingMode(4,"KILL");
      
      private var _value:int;
      
      private var _name:String;
      
      public function FlyingMode(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<FlyingMode>
      {
         var _loc1_:Vector.<FlyingMode> = new Vector.<FlyingMode>();
         _loc1_.push(FLY);
         _loc1_.push(ROLL);
         _loc1_.push(IMPACT);
         _loc1_.push(DROP);
         _loc1_.push(KILL);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "FlyingMode [" + this._name + "]";
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

