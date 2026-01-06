package projects.tanks.client.battlefield.models.user.tank
{
   public class TankLogicState
   {
      
      public static const NEW:TankLogicState = new TankLogicState(0,"NEW");
      
      public static const OUT_OF_GAME:TankLogicState = new TankLogicState(1,"OUT_OF_GAME");
      
      public static const ACTIVATING:TankLogicState = new TankLogicState(2,"ACTIVATING");
      
      public static const ACTIVE:TankLogicState = new TankLogicState(3,"ACTIVE");
      
      public static const DEAD:TankLogicState = new TankLogicState(4,"DEAD");
      
      private var _value:int;
      
      private var _name:String;
      
      public function TankLogicState(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<TankLogicState>
      {
         var _loc1_:Vector.<TankLogicState> = new Vector.<TankLogicState>();
         _loc1_.push(NEW);
         _loc1_.push(OUT_OF_GAME);
         _loc1_.push(ACTIVATING);
         _loc1_.push(ACTIVE);
         _loc1_.push(DEAD);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "TankLogicState [" + this._name + "]";
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

