package platform.client.core.general.socialnetwork.models.socialnetworkparameters
{
   public class SocialNetworkParametersCC
   {
      
      private var _hasOwnPaymentSystem:Boolean;
      
      private var _hasSocialFunction:Boolean;
      
      public function SocialNetworkParametersCC(param1:Boolean = false, param2:Boolean = false)
      {
         super();
         this._hasOwnPaymentSystem = param1;
         this._hasSocialFunction = param2;
      }
      
      public function get hasOwnPaymentSystem() : Boolean
      {
         return this._hasOwnPaymentSystem;
      }
      
      public function set hasOwnPaymentSystem(param1:Boolean) : void
      {
         this._hasOwnPaymentSystem = param1;
      }
      
      public function get hasSocialFunction() : Boolean
      {
         return this._hasSocialFunction;
      }
      
      public function set hasSocialFunction(param1:Boolean) : void
      {
         this._hasSocialFunction = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "SocialNetworkParametersCC [";
         _loc1_ += "hasOwnPaymentSystem = " + this.hasOwnPaymentSystem + " ";
         _loc1_ += "hasSocialFunction = " + this.hasSocialFunction + " ";
         return _loc1_ + "]";
      }
   }
}

