package projects.tanks.client.commons.models.layout
{
   public class LayoutState
   {
      
      public static const BATTLE_SELECT:LayoutState = new LayoutState(0,"BATTLE_SELECT");
      
      public static const GARAGE:LayoutState = new LayoutState(1,"GARAGE");
      
      public static const PAYMENT:LayoutState = new LayoutState(2,"PAYMENT");
      
      public static const BATTLE:LayoutState = new LayoutState(3,"BATTLE");
      
      public static const RELOAD_SPACE:LayoutState = new LayoutState(4,"RELOAD_SPACE");
      
      private var _value:int;
      
      private var _name:String;
      
      public function LayoutState(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<LayoutState>
      {
         var _loc1_:Vector.<LayoutState> = new Vector.<LayoutState>();
         _loc1_.push(BATTLE_SELECT);
         _loc1_.push(GARAGE);
         _loc1_.push(PAYMENT);
         _loc1_.push(BATTLE);
         _loc1_.push(RELOAD_SPACE);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "LayoutState [" + this._name + "]";
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

