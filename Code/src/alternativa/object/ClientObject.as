package alternativa.object
{
   import flash.utils.Dictionary;
   
   public class ClientObject
   {
      private var _id:String;
      
      private var initParams:Dictionary;
      
      public var params:Dictionary;
      
      public function ClientObject(param1:String)
      {
         super();
         this._id = param1;
         this.params = new Dictionary();
      }
      
      public function getParams(param1:Class) : Object
      {
         return this.params[param1];
      }
      
      public function putParams(param1:Class, param2:Object) : void
      {
         this.params[param1] = param2;
      }
      
      public function removeParams(param1:Class) : Object
      {
         var _loc2_:Object = this.params[param1];
         delete this.params[param1];
         return _loc2_;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

