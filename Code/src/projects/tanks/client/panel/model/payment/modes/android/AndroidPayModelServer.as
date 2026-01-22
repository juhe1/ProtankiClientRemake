package projects.tanks.client.panel.model.payment.modes.android
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class AndroidPayModelServer
   {

      private var model:IModel;

      public function AndroidPayModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function checkForConsumeTokens(param1:PurchaseData) : void
      {
      }

      public function consumeSuccess(param1:String) : void
      {
      }

      public function makePayment(param1:String, param2:Long, param3:String) : void
      {
      }
   }
}
