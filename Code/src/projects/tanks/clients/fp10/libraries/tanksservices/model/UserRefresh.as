package projects.tanks.clients.fp10.libraries.tanksservices.model
{
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   
   [ModelInterface]
   public interface UserRefresh
   {
      
      function refresh(param1:String, param2:UserInfoConsumer) : void;
      
      function remove(param1:String) : void;
   }
}

