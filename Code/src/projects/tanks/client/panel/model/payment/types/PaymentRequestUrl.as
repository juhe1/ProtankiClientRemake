package projects.tanks.client.panel.model.payment.types
{
   import projects.tanks.client.panel.model.payment.modes.PaymentRequestVariable;
   
   public class PaymentRequestUrl
   {
      
      private var _getRequest:Boolean;
      
      private var _host:String;
      
      private var _parameters:Vector.<PaymentRequestVariable>;
      
      public function PaymentRequestUrl(param1:Boolean = false, param2:String = null, param3:Vector.<PaymentRequestVariable> = null)
      {
         super();
         this._getRequest = param1;
         this._host = param2;
         this._parameters = param3;
      }
      
      public function get getRequest() : Boolean
      {
         return this._getRequest;
      }
      
      public function set getRequest(param1:Boolean) : void
      {
         this._getRequest = param1;
      }
      
      public function get host() : String
      {
         return this._host;
      }
      
      public function set host(param1:String) : void
      {
         this._host = param1;
      }
      
      public function get parameters() : Vector.<PaymentRequestVariable>
      {
         return this._parameters;
      }
      
      public function set parameters(param1:Vector.<PaymentRequestVariable>) : void
      {
         this._parameters = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "PaymentRequestUrl [";
         _loc1_ += "getRequest = " + this.getRequest + " ";
         _loc1_ += "host = " + this.host + " ";
         _loc1_ += "parameters = " + this.parameters + " ";
         return _loc1_ + "]";
      }
   }
}

