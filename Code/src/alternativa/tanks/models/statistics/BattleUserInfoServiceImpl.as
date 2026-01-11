package alternativa.tanks.models.statistics
{
   import alternativa.osgi.OSGi;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoListener;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   
   public class BattleUserInfoServiceImpl implements BattleUserInfoService, AutoClosable
   {
      
      private const userInfoListeners:Vector.<BattleUserInfoListener> = new Vector.<BattleUserInfoListener>();
      
      private var battleObject:IGameObject;
      
      public function BattleUserInfoServiceImpl(param1:IGameObject)
      {
         super();
         this.battleObject = param1;
         OSGi.getInstance().registerService(BattleUserInfoService,this);
      }
      
      public function getUserName(param1:String) : String
      {
         var _loc2_:ShortUserInfo = this.getShortUserInfo(param1);
         return _loc2_ != null ? _loc2_.uid : "";
      }
      
      public function getUserRank(param1:String) : int
      {
         var _loc2_:ShortUserInfo = this.getShortUserInfo(param1);
         return _loc2_ != null ? _loc2_.rank : -1;
      }
      
      public function isUserSuspected(param1:String) : Boolean
      {
         var _loc2_:ShortUserInfo = this.getShortUserInfo(param1);
         return _loc2_ != null ? _loc2_.suspicious : false;
      }
      
      public function getChatModeratorLevel(param1:String) : ChatModeratorLevel
      {
         var _loc2_:ShortUserInfo = this.getShortUserInfo(param1);
         return _loc2_ != null ? _loc2_.chatModeratorLevel : ChatModeratorLevel.NONE;
      }
      
      public function hasUserPremium(param1:String) : Boolean
      {
         var _loc2_:ShortUserInfo = this.getShortUserInfo(param1);
         return _loc2_ != null ? _loc2_.hasPremium : false;
      }
      
      public function addBattleUserInfoListener(param1:BattleUserInfoListener) : void
      {
         var _loc2_:int = int(this.userInfoListeners.indexOf(param1));
         if(_loc2_ < 0)
         {
            this.userInfoListeners.push(param1);
         }
      }
      
      public function removeBattleUserInfoListener(param1:BattleUserInfoListener) : void
      {
         var _loc2_:int = int(this.userInfoListeners.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.userInfoListeners.splice(_loc2_,1);
         }
      }
      
      public function dispatchStatChange(param1:ShortUserInfo) : void
      {
         var _loc2_:BattleUserInfoListener = null;
         for each(_loc2_ in this.userInfoListeners)
         {
            _loc2_.userInfoChanged(param1.userId,param1.uid,param1.rank,param1.suspicious);
         }
      }
      
      public function dispatchRankChange(param1:String, param2:int) : void
      {
         var _loc3_:BattleUserInfoListener = null;
         for each(_loc3_ in this.userInfoListeners)
         {
            _loc3_.userRankChanged(param1,param2);
         }
      }
      
      public function dispatchSuspiciousnessChange(param1:String, param2:Boolean) : void
      {
         var _loc3_:BattleUserInfoListener = null;
         for each(_loc3_ in this.userInfoListeners)
         {
            _loc3_.userSuspiciousnessChanged(param1,param2);
         }
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.battleObject = null;
         this.userInfoListeners.length = 0;
         OSGi.getInstance().unregisterService(BattleUserInfoService);
      }
      
      public function getUsersCount() : int
      {
         var _loc1_:IClientUserInfo = IClientUserInfo(this.battleObject.adapt(IClientUserInfo));
         return _loc1_.getUsersCount();
      }
      
      private function getShortUserInfo(param1:String) : ShortUserInfo
      {
         var _loc2_:IClientUserInfo = IClientUserInfo(this.battleObject.adapt(IClientUserInfo));
         return _loc2_.getShortUserInfo(param1);
      }
   }
}

