package projects.tanks.clients.fp10.libraries.tanksservices.model.listener
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   
   public class UserNotifierAdapt implements UserNotifier
   {
      
      private var object:IGameObject;
      
      private var impl:UserNotifier;
      
      public function UserNotifierAdapt(param1:IGameObject, param2:UserNotifier)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function getDataConsumer(param1:String) : UserInfoConsumer
      {
         var result:UserInfoConsumer = null;
         var userId:String = param1;
         try
         {
            Model.object = this.object;
            result = this.impl.getDataConsumer(userId);
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function hasDataConsumer(param1:String) : Boolean
      {
         var result:Boolean = false;
         var userId:String = param1;
         try
         {
            Model.object = this.object;
            result = Boolean(this.impl.hasDataConsumer(userId));
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function subcribe(param1:String, param2:UserInfoConsumer) : void
      {
         var userId:String = param1;
         var consumer:UserInfoConsumer = param2;
         try
         {
            Model.object = this.object;
            this.impl.subcribe(userId,consumer);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         var userId:String = param1;
         var consumer:UserInfoConsumer = param2;
         try
         {
            Model.object = this.object;
            this.impl.refresh(userId,consumer);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function unsubcribe(param1:Vector.<String>) : void
      {
         var usersId:Vector.<String> = param1;
         try
         {
            Model.object = this.object;
            this.impl.unsubcribe(usersId);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function getCurrentUserId() : String
      {
         var result:String = null;
         try
         {
            Model.object = this.object;
            result = this.impl.getCurrentUserId();
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
   }
}

