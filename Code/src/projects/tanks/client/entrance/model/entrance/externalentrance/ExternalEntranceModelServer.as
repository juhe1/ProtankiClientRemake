package projects.tanks.client.entrance.model.entrance.externalentrance
{
   import platform.client.fp10.core.model.IModel;
   
   public class ExternalEntranceModelServer
   {

      private var model:IModel;
      
      public function ExternalEntranceModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function createLinkForExistingUser(param1:String, param2:String) : void
      {
      }
      
      public function registerNewUser(param1:String, param2:String) : void
      {
      }
      
      public function setLoginData(param1:Boolean, param2:String) : void
      {
      }
   }
}

