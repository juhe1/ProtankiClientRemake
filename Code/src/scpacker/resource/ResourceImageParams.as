package scpacker.resource
{
   public class ResourceImageParams
   {
      private var _alpha:Boolean;
      
      public function ResourceImageParams(param1:Boolean = false)
      {
         super();
         this._alpha = param1;
      }
      
      public function get alpha() : Boolean
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Boolean) : void
      {
         this._alpha = param1;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

