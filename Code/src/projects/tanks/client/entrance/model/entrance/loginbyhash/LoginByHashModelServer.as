package projects.tanks.client.entrance.model.entrance.loginbyhash
{
   import platform.client.fp10.core.model.IModel;
   
   public class LoginByHashModelServer
   {      
      private var model:IModel;
      
      public function LoginByHashModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function loginByHash(param1:String) : void
      {
      }
      
      public function loginBySingleUseHash(param1:String) : void
      {
      }
   }
}

