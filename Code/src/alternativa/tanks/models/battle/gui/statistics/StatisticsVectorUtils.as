package alternativa.tanks.models.battle.gui.statistics
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   import projects.tanks.client.battleservice.model.statistics.UserReward;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   
   public class StatisticsVectorUtils
   {
      
      public function StatisticsVectorUtils()
      {
         super();
      }
      
      public static function createUsersStat(param1:Dictionary, param2:Vector.<UserInfo>) : Vector.<ClientUserStat>
      {
         var _loc6_:UserInfo = null;
         var _loc7_:ClientUserStat = null;
         var _loc3_:Vector.<ClientUserStat> = new Vector.<ClientUserStat>();
         var _loc4_:int = int(param2.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param2[_loc5_];
            _loc7_ = new ClientUserStat();
            _loc7_.initUserInfo(_loc6_,param1[_loc6_.user]);
            _loc3_.push(_loc7_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function refreshUsersStat(param1:Dictionary, param2:Vector.<UserStat>) : Vector.<ClientUserStat>
      {
         var _loc6_:UserStat = null;
         var _loc7_:ClientUserStat = null;
         var _loc3_:Vector.<ClientUserStat> = new Vector.<ClientUserStat>();
         var _loc4_:int = int(param2.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param2[_loc5_];
            _loc7_ = new ClientUserStat();
            _loc7_.initUserStat(_loc6_,param1[_loc6_.user]);
            _loc3_.push(_loc7_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function createClientUserInfo(param1:UserInfo, param2:BattleTeam) : ClientUserInfo
      {
         return new ClientUserInfo(param1.user,param1.uid,param1.rank,false,false,param2,param1.chatModeratorLevel,param1.hasPremium);
      }
      
      public static function getUserInfo(param1:Long, param2:Vector.<UserInfo>) : UserInfo
      {
         var _loc5_:UserInfo = null;
         var _loc3_:int = int(param2.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2[_loc4_];
            if(param1 == _loc5_.user)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function deleteUserStat(param1:Vector.<ClientUserStat>, param2:Long) : Vector.<ClientUserStat>
      {
         var _loc6_:ClientUserStat = null;
         var _loc3_:Vector.<ClientUserStat> = new Vector.<ClientUserStat>();
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1[_loc5_];
            if(_loc6_.userId != param2)
            {
               _loc3_.push(_loc6_);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function updateReward(param1:Vector.<ClientUserStat>, param2:Vector.<UserReward>) : void
      {
         var _loc5_:UserReward = null;
         var _loc6_:ClientUserStat = null;
         var _loc3_:int = int(param2.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2[_loc4_];
            _loc6_ = getClientUserStat(param1,_loc5_.userId);
            if(_loc6_ != null)
            {
               _loc6_.reward = _loc5_.reward + _loc5_.premiumBonusReward + _loc5_.newbiesAbonementBonusReward;
               _loc6_.stars = _loc5_.starsReward;
            }
            _loc4_++;
         }
      }
      
      public static function getClientUserStat(param1:Vector.<ClientUserStat>, param2:Long) : ClientUserStat
      {
         var _loc5_:ClientUserStat = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.userId == param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function changeUserStat(param1:Vector.<ClientUserStat>, param2:UserStat) : ClientUserStat
      {
         var _loc5_:ClientUserStat = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.userId == param2.user)
            {
               _loc5_.updateUserStat(param2);
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function getRewardById(param1:Long, param2:Vector.<UserReward>) : UserReward
      {
         var _loc5_:UserReward = null;
         var _loc3_:int = int(param2.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2[_loc4_];
            if(param1 == _loc5_.userId)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function getUserPosition(param1:Vector.<ClientUserStat>, param2:Long) : int
      {
         var _loc5_:ClientUserStat = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.userId == param2)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
   }
}

