package projects.tanks.client.tanksservices.model.listener
{
   import platform.client.fp10.core.model.IModel;
   
   public class UserNotifierModelServer
   {      
      private var model:IModel;
      
      public function UserNotifierModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function subscribe(param1:String) : void
      {
      }
      
      public function unsubscribe(param1:Vector.<String>) : void
      {
      }
   }
}

