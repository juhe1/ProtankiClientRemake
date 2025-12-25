package platform.client.fp10.core.type.impl
{
   import alternativa.osgi.OSGi;
   import alternativa.types.Long;
   import flash.utils.getQualifiedClassName;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.type.*;
   
   public class GameClass implements IGameClass
   {
      
      private var _id:Long;
      
      private var _models:Vector.<Long>;
      
      public function GameClass(param1:Long, param2:Vector.<Long> = null)
      {
         super();
         this._id = param1;
         if(param2 != null)
         {
            this._models = param2;
         }
         else
         {
            this._models = new Vector.<Long>();
         }
      }
      
      public function get id() : Long
      {
         return this._id;
      }
      
      public function get models() : Vector.<Long>
      {
         return this._models;
      }
      
      public function toString() : String
      {
         var _loc3_:int = 0;
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         var _loc2_:String = "ClientClass\n";
         _loc2_ += "  id: " + this._id + "\n";
         if(this._models.length > 0)
         {
            _loc2_ += "  models:\n";
            _loc3_ = 0;
            while(_loc3_ < this._models.length)
            {
               _loc2_ += "    id: " + this._models[_loc3_] + ", class: " + getQualifiedClassName(_loc1_.getModel(this._models[_loc3_])) + "\n";
               _loc3_++;
            }
         }
         return _loc2_;
      }
   }
}

