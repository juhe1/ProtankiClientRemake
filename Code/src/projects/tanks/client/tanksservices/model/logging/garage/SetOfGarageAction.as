package projects.tanks.client.tanksservices.model.logging.garage
{
   import flash.utils.Dictionary;
   
   public class SetOfGarageAction
   {
      
      private var _dictionary:Dictionary = new Dictionary();
      
      public function SetOfGarageAction()
      {
         super();
      }
      
      public function add(param1:GarageAction) : void
      {
         this._dictionary[param1] = true;
      }
      
      public function contains(param1:GarageAction) : Boolean
      {
         return this._dictionary[param1];
      }
      
      public function remove(param1:GarageAction) : Boolean
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

