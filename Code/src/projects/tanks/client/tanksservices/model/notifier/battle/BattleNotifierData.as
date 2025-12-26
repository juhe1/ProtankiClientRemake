package projects.tanks.client.tanksservices.model.notifier.battle
{
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   
   public class BattleNotifierData
   {
      private var _battleData:BattleInfoData;
      
      private var _userId:String;
      
      public function BattleNotifierData(param1:BattleInfoData = null, param2:String = null)
      {
         super();
         this._battleData = param1;
         this._userId = param2;
      }
      
      public function get battleData() : BattleInfoData
      {
         return this._battleData;
      }
      
      public function set battleData(param1:BattleInfoData) : void
      {
         this._battleData = param1;
      }
      
      public function get userId() : String
      {
         return this._userId;
      }
      
      public function set userId(param1:String) : void
      {
         this._userId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleNotifierData [";
         _loc1_ += "battleData = " + this._battleData + " ";
         _loc1_ += "userId = " + this._userId + " ";
         return _loc1_ + "]";
      }
   }
}

