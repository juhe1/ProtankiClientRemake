package projects.tanks.client.tanksservices.model.logging
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.tanksservices.model.logging.battlelist.BattleSelectAction;
   import projects.tanks.client.tanksservices.model.logging.gamescreen.GameScreen;
   import projects.tanks.client.tanksservices.model.logging.garage.GarageAction;
   import projects.tanks.client.tanksservices.model.logging.payment.PaymentAction;

   public class UserActionsLoggerModelServer
   {

      private var model:IModel;

      public function UserActionsLoggerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function battleSelectAction(param1:BattleSelectAction, param2:BattleMode, param3:String) : void
      {
      }

      public function changeScreenAction(param1:GameScreen, param2:GameScreen) : void
      {
      }

      public function garageAction(param1:GarageAction, param2:IGameObject) : void
      {
      }

      public function paymentAction(param1:PaymentAction, param2:String, param3:String, param4:String, param5:String) : void
      {
      }

      public function settingsAction(param1:int) : void
      {
      }
   }
}
