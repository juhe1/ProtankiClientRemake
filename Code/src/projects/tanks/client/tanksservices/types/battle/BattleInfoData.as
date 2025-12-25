package projects.tanks.client.tanksservices.types.battle
{
   import alternativa.types.Long;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.Range;
   
   public class BattleInfoData
   {
      
      private var _battleId:String;
      
      private var _mapName:String;
      
      private var _mode:BattleMode;
      
      private var _privateBattle:Boolean;
      
      private var _proBattle:Boolean;
      
      private var _range:Range;
      
      private var _remote:Boolean;
      
      private var _serverNumber:int;
      
      public function BattleInfoData(param1:String = null, param2:String = null, param3:BattleMode = null, param4:Boolean = false, param5:Boolean = false, param6:Range = null, param7:Boolean = false, param8:int = 0)
      {
         super();
         this._battleId = param1;
         this._mapName = param2;
         this._mode = param3;
         this._privateBattle = param4;
         this._proBattle = param5;
         this._range = param6;
         this._remote = param7;
         this._serverNumber = param8;
      }
      
      public function get battleId() : String
      {
         return this._battleId;
      }
      
      public function set battleId(param1:String) : void
      {
         this._battleId = param1;
      }
      
      public function get mapName() : String
      {
         return this._mapName;
      }
      
      public function set mapName(param1:String) : void
      {
         this._mapName = param1;
      }
      
      public function get mode() : BattleMode
      {
         return this._mode;
      }
      
      public function set mode(param1:BattleMode) : void
      {
         this._mode = param1;
      }
      
      public function get privateBattle() : Boolean
      {
         return this._privateBattle;
      }
      
      public function set privateBattle(param1:Boolean) : void
      {
         this._privateBattle = param1;
      }
      
      public function get proBattle() : Boolean
      {
         return this._proBattle;
      }
      
      public function set proBattle(param1:Boolean) : void
      {
         this._proBattle = param1;
      }
      
      public function get range() : Range
      {
         return this._range;
      }
      
      public function set range(param1:Range) : void
      {
         this._range = param1;
      }
      
      public function get remote() : Boolean
      {
         return this._remote;
      }
      
      public function set remote(param1:Boolean) : void
      {
         this._remote = param1;
      }
      
      public function get serverNumber() : int
      {
         return this._serverNumber;
      }
      
      public function set serverNumber(param1:int) : void
      {
         this._serverNumber = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleInfoData [";
         _loc1_ += "battleId = " + this.battleId + " ";
         _loc1_ += "mapName = " + this.mapName + " ";
         _loc1_ += "mode = " + this.mode + " ";
         _loc1_ += "privateBattle = " + this.privateBattle + " ";
         _loc1_ += "proBattle = " + this.proBattle + " ";
         _loc1_ += "range = " + this.range + " ";
         _loc1_ += "remote = " + this.remote + " ";
         _loc1_ += "serverNumber = " + this.serverNumber + " ";
         return _loc1_ + "]";
      }
   }
}

