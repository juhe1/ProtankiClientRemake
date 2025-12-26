package projects.tanks.clients.fp10.libraries.tanksservices.model.listener
{
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   
   [ModelInterface]
   public interface UserNotifier
   {
      
      function getDataConsumer(param1:String) : UserInfoConsumer;
      
      function hasDataConsumer(param1:String) : Boolean;
      
      function subcribe(param1:String, param2:UserInfoConsumer) : void;
      
      function refresh(param1:String, param2:UserInfoConsumer) : void;
      
      function unsubcribe(param1:Vector.<String>) : void;
      
      function getCurrentUserId() : String;
   }
}

