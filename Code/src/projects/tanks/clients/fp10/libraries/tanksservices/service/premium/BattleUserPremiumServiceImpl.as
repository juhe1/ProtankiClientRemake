package projects.tanks.clients.fp10.libraries.tanksservices.service.premium
{
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import flash.utils.clearTimeout;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierCC;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierData;
   
   public class BattleUserPremiumServiceImpl extends EventDispatcher implements BattleUserPremiumService
   {
      
      private var usersPremium:Dictionary = new Dictionary();
      private var timeouts:Dictionary = new Dictionary();
      
      public function BattleUserPremiumServiceImpl()
      {
         super();
      }
      
      public function setUsersPremium(param1:Vector.<UserInfo>) : *
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            //_loc3_ = param1[_loc2_].hasPremium;
            _loc4_ = param1[_loc2_].user;
            this.usersPremium[_loc4_] = _loc3_;
            _loc2_++;
         }
      }

      // Custom function to make protanki premium notifier work
      public function setUsersPremiumProtanki(param1:Vector.<PremiumNotifierData>) : *
      {
         var hasPremium:Boolean = false;
         var userId:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            hasPremium = param1[_loc2_].premiumTimeLeftInSeconds > 0;
            userId = param1[_loc2_].userId;
            this.usersPremium[userId] = hasPremium;
            if(hasPremium)
            {
               this.timeouts[userId] = setTimeout(this.removePremium,param1[_loc2_].premiumTimeLeftInSeconds * 1000,userId);
            }
            _loc2_++;
         }
      }

      // Not origanal code
      private function removePremium(userId:String) : void
      {
         this.resetUserPremium(userId);
         this.removeTimeOut(userId);
      }

      // Not original code
      public function removeTimeOut(userId:String) : void
      {
         if(userId in this.timeouts)
         {
            clearTimeout(this.timeouts[userId]);
            delete this.timeouts[userId];
         }
      }
      
      public function hasUserPremium(param1:String) : Boolean
      {
         return this.usersPremium[param1] != null ? Boolean(this.usersPremium[param1]) : false;
      }
      
      public function resetUserPremium(param1:String) : *
      {
         delete this.usersPremium[param1];
      }
      
      public function removeUsersPremium() : void
      {
         this.usersPremium = new Dictionary();
      }
   }
}

