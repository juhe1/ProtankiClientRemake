package projects.tanks.client.commons.models.externalauth
{
   import flash.utils.Dictionary;
   
   public class ExternalAuthParameters
   {
      
      private var _parameters:Dictionary;
      
      public function ExternalAuthParameters(param1:Dictionary = null)
      {
         super();
         this._parameters = param1;
      }
      
      public function get parameters() : Dictionary
      {
         return this._parameters;
      }
      
      public function set parameters(param1:Dictionary) : void
      {
         this._parameters = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ExternalAuthParameters [";
         _loc1_ += "parameters = " + this.parameters + " ";
         return _loc1_ + "]";
      }
   }
}

