package alternativa.osgi.catalogs
{
   public class ServiceParam
   {
       
      
      private var _name:String;
      
      private var _value:*;
      
      public function ServiceParam(name:String, value:*)
      {
         super();
         this._name = name;
         this._value = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get value() : *
      {
         return this._value;
      }
   }
}
