package projects.tanks.client.battleservice
{
   public class BattleMode
   {
      
      public static const DM:BattleMode = new BattleMode(0,"DM");
      
      public static const TDM:BattleMode = new BattleMode(1,"TDM");
      
      public static const CTF:BattleMode = new BattleMode(2,"CTF");
      
      public static const CP:BattleMode = new BattleMode(3,"CP");
      
      public static const AS:BattleMode = new BattleMode(4,"AS");
      
      private var _value:int;
      
      private var _name:String;
      
      public function BattleMode(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<BattleMode>
      {
         var _loc1_:Vector.<BattleMode> = new Vector.<BattleMode>();
         _loc1_.push(DM);
         _loc1_.push(TDM);
         _loc1_.push(CTF);
         _loc1_.push(CP);
         _loc1_.push(AS);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "BattleMode [" + this._name + "]";
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

