package alternativa.tanks.types
{
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   
   public class MultiGameObjectDictionary
   {
      
      private var dictionary:Dictionary = new Dictionary(true);
      
      public function MultiGameObjectDictionary()
      {
         super();
      }
      
      public function put(param1:IGameObject, param2:IGameObject) : void
      {
         var _loc3_:Vector.<IGameObject> = null;
         if(param1 in this.dictionary)
         {
            this.dictionary[param1].push(param2);
         }
         else
         {
            _loc3_ = new Vector.<IGameObject>();
            _loc3_.push(param2);
            this.dictionary[param1] = _loc3_;
         }
      }
      
      public function getValues(param1:IGameObject) : Vector.<IGameObject>
      {
         if(param1 in this.dictionary)
         {
            return this.dictionary[param1];
         }
         return new Vector.<IGameObject>();
      }
      
      public function clear() : void
      {
         this.dictionary = new Dictionary();
      }
      
      public function remove(param1:IGameObject, param2:IGameObject) : void
      {
         var _loc3_:Vector.<IGameObject> = null;
         var _loc4_:Number = NaN;
         if(param1 in this.dictionary)
         {
            _loc3_ = this.dictionary[param1];
            _loc4_ = Number(_loc3_.indexOf(param2));
            if(_loc4_ != -1)
            {
               _loc3_.splice(_loc4_,1);
            }
         }
      }
   }
}

