package projects.tanks.client.panel.model.payment.modes.sms
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class SMSPayModeModelServer
   {

      private var model:IModel;

      public function SMSPayModeModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getNumbers(param1:int) : void
      {
      }

      public function getOperators(param1:String) : void
      {
      }
   }
}
