package alternativa.tanks.model.payment
{
   import alternativa.startup.StartupSettings;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import projects.tanks.client.panel.model.payment.modes.PaymentRequestVariable;
   import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;
   
   public class PaymentUtils
   {
      
      public function PaymentUtils()
      {
         super();
      }
      
      public static function createUrlRequest(param1:PaymentRequestUrl) : URLRequest
      {
         var _loc7_:PaymentRequestVariable = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc2_:Array = param1.host.split("?");
         var _loc3_:String = _loc2_[0];
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:URLVariables = new URLVariables();
         var _loc6_:String = _loc2_[1];
         if(_loc6_ != null)
         {
            for each(_loc8_ in _loc6_.split("&"))
            {
               _loc9_ = _loc8_.split("=");
               _loc5_[_loc9_[0]] = _loc9_[1];
            }
         }
         for each(_loc7_ in param1.parameters)
         {
            _loc5_[_loc7_.variable] = _loc7_.value;
         }
         _loc4_.data = _loc5_;
         _loc4_.method = getRequestMethod(param1);
         return _loc4_;
      }
      
      public static function createOrderedUrlRequest(param1:PaymentRequestUrl) : URLRequest
      {
         var _loc2_:Array = param1.host.split("?");
         var _loc3_:String = _loc2_[0];
         var _loc4_:Vector.<PaymentRequestVariable> = new Vector.<PaymentRequestVariable>();
         _loc4_ = _loc4_.concat(getParamsFromHostString(_loc2_[1]));
         _loc4_ = _loc4_.concat(param1.parameters);
         var _loc5_:URLRequest = new URLRequest();
         _loc5_.url = _loc3_;
         _loc5_.data = encodeRequestParams(_loc4_);
         _loc5_.method = getRequestMethod(param1);
         return _loc5_;
      }
      
      private static function getRequestMethod(param1:PaymentRequestUrl) : String
      {
         return param1.getRequest || Boolean(StartupSettings.isDesktop) ? URLRequestMethod.GET : URLRequestMethod.POST;
      }
      
      private static function getParamsFromHostString(param1:String) : Vector.<PaymentRequestVariable>
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc2_:Vector.<PaymentRequestVariable> = new Vector.<PaymentRequestVariable>();
         if(param1 != null)
         {
            for each(_loc3_ in param1.split("&"))
            {
               _loc4_ = _loc3_.split("=");
               _loc2_.push(new PaymentRequestVariable(_loc4_[1],_loc4_[0]));
            }
         }
         return _loc2_;
      }
      
      private static function encodeRequestParams(param1:Vector.<PaymentRequestVariable>) : Object
      {
         var _loc3_:PaymentRequestVariable = null;
         var _loc2_:String = "";
         for each(_loc3_ in param1)
         {
            _loc2_ = _loc2_ + encodeURIComponent(_loc3_.variable) + "=" + encodeURIComponent(_loc3_.value) + "&";
         }
         return _loc2_.substr(0,_loc2_.length - 1);
      }
   }
}

