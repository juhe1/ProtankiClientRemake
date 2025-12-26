package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle
{
   import alternativa.types.Long;
   import projects.tanks.client.battleservice.Range;
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   
   public class BattleLinkData
   {
      
      [Inject]
      public static var userInfoService:IUserInfoService;
      
      [Inject]
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject]
      public static var reconnectService:ReconnectService;
      
      private var _userId:String;
      
      private var battleData:BattleInfoData;
      
      private var _mapName:String;
      
      public function BattleLinkData(param1:String, param2:BattleNotifierData)
      {
         super();
         this._userId = param1;
         this.battleData = param2.battleData;
         this._mapName = this.battleData.mapName + " " + battleData.mode.name;
      }
      
      public function get userId() : String
      {
         return this._userId;
      }
      
      public function get battleId() : String
      {
         return this.battleData.battleId;
      }
      
      public function get range() : Range
      {
         return this.battleData.range;
      }
      
      public function getBattleData() : BattleInfoData
      {
         return this.battleData;
      }
      
      public function isSelfBattle() : Boolean
      {
         var _loc1_:String = userInfoService.getCurrentUserId();
         var _loc2_:IUserInfoLabelUpdater = userInfoService.getOrCreateUpdater(_loc1_);
         if(_loc2_.battleLink != null)
         {
            return int(this.battleId.toString()) != 0 && _loc2_.battleLink.battleId == this.battleId;
         }
         return false;
      }
      
      public function isShowBattle() : Boolean
      {
         var _loc1_:Boolean = true;
         if(this.battleData.privateBattle)
         {
            _loc1_ = this.isSelfBattle();
         }
         return _loc1_;
      }
      
      public function availableRank() : Boolean
      {
         var _loc1_:int = int(userPropertiesService.rank);
         return this.isShowBattle() && (_loc1_ >= this.battleData.range.min && _loc1_ <= this.battleData.range.max);
      }
      
      public function isClickable() : Boolean
      {
         return this.battleData.proBattle && !this.isSelfBattle() && this.isShowBattle();
      }
      
      public function get proBattle() : Boolean
      {
         return this.battleData.proBattle;
      }
      
      public function get mapName() : String
      {
         return this._mapName;
      }
   }
}

