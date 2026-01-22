package projects.tanks.client.partners.impl.steam
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class SteamPaymentModelServer
   {

      private var model:IModel;

      public function SteamPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function finalizePayment(param1:String) : void
      {
      }

      public function makePaymentRequest(param1:Long) : void
      {
      }
   }
}
