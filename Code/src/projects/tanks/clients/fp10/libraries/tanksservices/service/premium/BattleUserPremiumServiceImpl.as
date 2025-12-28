package projects.tanks.clients.fp10.libraries.tanksservices.service.premium
{
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   
   public class BattleUserPremiumServiceImpl extends EventDispatcher implements BattleUserPremiumService
   {
      
      private var usersPremium:Dictionary = new Dictionary();
      
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
      
      public function hasUserPremium(param1:Long) : Boolean
      {
         return this.usersPremium[param1] != null ? Boolean(this.usersPremium[param1]) : false;
      }
      
      public function resetUserPremium(param1:Long) : *
      {
         delete this.usersPremium[param1];
      }
      
      public function removeUsersPremium() : void
      {
         this.usersPremium = new Dictionary();
      }
   }
}

