package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions
{
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import projects.tanks.client.tanksservices.model.logging.payment.PaymentAction;
   
   public class UserPaymentActionsServiceImpl extends EventDispatcher implements UserPaymentActionsService
   {
      
      public function UserPaymentActionsServiceImpl()
      {
         super();
      }
      
      public function openPayment(param1:String) : void
      {
         var _loc2_:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.OPEN_PAYMENT);
         _loc2_.setLayoutName(param1);
         dispatchEvent(_loc2_);
      }
      
      public function closePayment(param1:String) : void
      {
         var _loc2_:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.CLOSE_PAYMENT);
         _loc2_.setLayoutName(param1);
         dispatchEvent(_loc2_);
      }
      
      public function selectCountry(param1:String) : void
      {
         var _loc2_:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.COUNTRY_SELECT);
         _loc2_.setCountryCode(param1);
         dispatchEvent(_loc2_);
      }
      
      public function choosePaymode(param1:Long, param2:Long) : void
      {
         var _loc3_:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.MODE_CHOOSE);
         _loc3_.setPayModeId(param1.toString());
         _loc3_.setShopItemId(param2.toString());
         dispatchEvent(_loc3_);
      }
      
      public function chooseItem(param1:Long) : void
      {
         var _loc2_:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.ITEM_CHOOSE);
         _loc2_.setShopItemId(param1.toString());
         dispatchEvent(_loc2_);
      }
      
      public function proceed(param1:Long, param2:Long) : void
      {
         var _loc3_:UserPaymentActionEvent = new UserPaymentActionEvent(PaymentAction.PROCEED);
         _loc3_.setPayModeId(param1.toString());
         _loc3_.setShopItemId(param2.toString());
         dispatchEvent(_loc3_);
      }
   }
}

