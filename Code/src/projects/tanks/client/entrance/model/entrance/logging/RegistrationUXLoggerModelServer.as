package projects.tanks.client.entrance.model.entrance.logging
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class RegistrationUXLoggerModelServer
   {

      private var model:IModel;

      public function RegistrationUXLoggerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function initLogger(param1:String, param2:Boolean, param3:Boolean) : void
      {
      }

      public function logFormAction(param1:RegistrationUXFormAction, param2:int) : void
      {
      }

      public function logNavigationFinish() : void
      {
      }

      public function logNavigationStart(param1:RegistrationUXScreen) : void
      {
      }
   }
}
