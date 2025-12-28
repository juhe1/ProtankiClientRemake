package projects.tanks.client.panel.model.payment
{
   public class PaymentPackage
   {
      
      private var _amountCrystals:int;
      
      private var _bonusCrystals:int;
      
      private var _currency:String;
      
      private var _premiumDurationInDays:int;
      
      private var _price:Number;
      
      public function PaymentPackage(param1:int = 0, param2:int = 0, param3:String = null, param4:int = 0, param5:Number = 0)
      {
         super();
         this._amountCrystals = param1;
         this._bonusCrystals = param2;
         this._currency = param3;
         this._premiumDurationInDays = param4;
         this._price = param5;
      }
      
      public function get amountCrystals() : int
      {
         return this._amountCrystals;
      }
      
      public function set amountCrystals(param1:int) : void
      {
         this._amountCrystals = param1;
      }
      
      public function get bonusCrystals() : int
      {
         return this._bonusCrystals;
      }
      
      public function set bonusCrystals(param1:int) : void
      {
         this._bonusCrystals = param1;
      }
      
      public function get currency() : String
      {
         return this._currency;
      }
      
      public function set currency(param1:String) : void
      {
         this._currency = param1;
      }
      
      public function get premiumDurationInDays() : int
      {
         return this._premiumDurationInDays;
      }
      
      public function set premiumDurationInDays(param1:int) : void
      {
         this._premiumDurationInDays = param1;
      }
      
      public function get price() : Number
      {
         return this._price;
      }
      
      public function set price(param1:Number) : void
      {
         this._price = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "PaymentPackage [";
         _loc1_ += "amountCrystals = " + this.amountCrystals + " ";
         _loc1_ += "bonusCrystals = " + this.bonusCrystals + " ";
         _loc1_ += "currency = " + this.currency + " ";
         _loc1_ += "premiumDurationInDays = " + this.premiumDurationInDays + " ";
         _loc1_ += "price = " + this.price + " ";
         return _loc1_ + "]";
      }
   }
}

