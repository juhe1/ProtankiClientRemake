package platform.client.fp10.core.resource.types
{
   import flash.utils.Dictionary;
   
   public class SetOfImageResource
   {
      
      private var _dictionary:Dictionary = new Dictionary();
      
      public function SetOfImageResource()
      {
         super();
      }
      
      public function add(param1:ImageResource) : void
      {
         this._dictionary[param1] = true;
      }
      
      public function contains(param1:ImageResource) : Boolean
      {
         return this._dictionary[param1];
      }
      
      public function remove(param1:ImageResource) : Boolean
      {
         var _loc2_:Boolean = this.contains(param1);
         if(_loc2_)
         {
            delete this._dictionary[param1];
         }
         return _loc2_;
      }
      
      public function get dictionary() : Dictionary
      {
         return this._dictionary;
      }
   }
}

