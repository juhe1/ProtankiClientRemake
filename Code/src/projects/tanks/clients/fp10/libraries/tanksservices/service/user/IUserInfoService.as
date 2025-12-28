package projects.tanks.clients.fp10.libraries.tanksservices.service.user
{
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   
   public interface IUserInfoService
   {
      
      function init(param1:IGameObject) : void;
      
      function getOrCreateUpdater(param1:String) : IUserInfoLabelUpdater;
      
      function hasConsumer(param1:String) : Boolean;
      
      function getConsumer(param1:String) : UserInfoConsumer;
      
      function forciblySubscribe(param1:String) : void;
      
      function unload() : void;
      
      function getCurrentUserId() : String;
      
      function isOffer() : Boolean;
      
      function setOffer(param1:Boolean) : void;
      
      function hasPremium(param1:String) : Boolean;
   }
}

