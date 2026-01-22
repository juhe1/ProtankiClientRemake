package projects.tanks.client.panel.model.payment.modes.tianxiafu
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class TianxiafuModelServer
   {

      private var model:IModel;

      public function TianxiafuModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function requestPayment(param1:int, param2:int) : void
      {
      }
   }
}
