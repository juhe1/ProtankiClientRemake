package projects.tanks.client.battlefield.models.tankparts.sfx.bcsh
{
   import flash.utils.Dictionary;
   
   public class SetOfBCSHStruct
   {
      
      private var _dictionary:Dictionary = new Dictionary();
      
      public function SetOfBCSHStruct()
      {
         super();
      }
      
      public function add(param1:BCSHStruct) : void
      {
         this._dictionary[param1] = true;
      }
      
      public function contains(param1:BCSHStruct) : Boolean
      {
         return this._dictionary[param1];
      }
      
      public function remove(param1:BCSHStruct) : Boolean
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

