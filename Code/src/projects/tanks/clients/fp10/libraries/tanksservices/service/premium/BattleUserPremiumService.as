package projects.tanks.clients.fp10.libraries.tanksservices.service.premium
{
   import alternativa.types.Long;
   import flash.events.IEventDispatcher;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierData;
   
   public interface BattleUserPremiumService extends IEventDispatcher
   {
      
      function hasUserPremium(param1:String) : Boolean;
      
      function setUsersPremium(param1:Vector.<UserInfo>) : *;
      
      function resetUserPremium(param1:String) : *;
      
      function removeUsersPremium() : void;

      function setUsersPremiumProtanki(param1:Vector.<PremiumNotifierData>) : *;
   }
}

