package platform.client.fp10.core.resource.types
{
   import flash.utils.Dictionary;
   
   public class SetOfMultiframeImageResource
   {
      
      private var _dictionary:Dictionary = new Dictionary();
      
      public function SetOfMultiframeImageResource()
      {
         super();
      }
      
      public function add(param1:MultiframeImageResource) : void
      {
         this._dictionary[param1] = true;
      }
      
      public function contains(param1:MultiframeImageResource) : Boolean
      {
         return this._dictionary[param1];
      }
      
      public function remove(param1:MultiframeImageResource) : Boolean
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

