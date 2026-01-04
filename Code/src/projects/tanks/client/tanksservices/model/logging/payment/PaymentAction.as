package projects.tanks.client.tanksservices.model.logging.payment
{
   public class PaymentAction
   {
      
      public static const OPEN_PAYMENT:PaymentAction = new PaymentAction(0,"OPEN_PAYMENT");
      
      public static const COUNTRY_SELECT:PaymentAction = new PaymentAction(1,"COUNTRY_SELECT");
      
      public static const MODE_CHOOSE:PaymentAction = new PaymentAction(2,"MODE_CHOOSE");
      
      public static const ITEM_CHOOSE:PaymentAction = new PaymentAction(3,"ITEM_CHOOSE");
      
      public static const CLOSE_PAYMENT:PaymentAction = new PaymentAction(4,"CLOSE_PAYMENT");
      
      public static const PROCEED:PaymentAction = new PaymentAction(5,"PROCEED");
      
      private var _value:int;
      
      private var _name:String;
      
      public function PaymentAction(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<PaymentAction>
      {
         var _loc1_:Vector.<PaymentAction> = new Vector.<PaymentAction>();
         _loc1_.push(OPEN_PAYMENT);
         _loc1_.push(COUNTRY_SELECT);
         _loc1_.push(MODE_CHOOSE);
         _loc1_.push(ITEM_CHOOSE);
         _loc1_.push(CLOSE_PAYMENT);
         _loc1_.push(PROCEED);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "PaymentAction [" + this._name + "]";
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}

