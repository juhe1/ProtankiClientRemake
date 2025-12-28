package platform.client.fp10.core.type.impl
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.type.*;
   
   public class GameObject implements IGameObject, IGameObjectInternal
   {
      
      [Inject] // added
      public static var modelRegistry:ModelRegistry;
      
      private var _name:String;
      
      private var _id:Long;
      
      private var _gameClass:IGameClass;
      
      private var _space:ISpace;
      
      private var data:Dictionary = new Dictionary();
      
      private var adapts:Dictionary;
      
      private var events:Dictionary;
      
      private var interfaceToComponentsList:*;
      
      private var components:Vector.<Component>;
      
      public function GameObject(param1:Long, param2:IGameClass, param3:String, param4:ISpace)
      {
         super();
         this._id = param1;
         this._gameClass = param2;
         this._name = param3;
         this._space = param4;
      }
      
      public function get id() : Long
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get gameClass() : IGameClass
      {
         return this._gameClass;
      }
      
      public function get space() : ISpace
      {
         return this._space;
      }
      
      public function addComponent(param1:Component) : void
      {
         this.resetInterfaceCache();
         if(param1.gameObject != null)
         {
            throw new Error("Component has already added to gameObject " + param1.gameObject);
         }
         if(this.components == null)
         {
            this.components = new Vector.<Component>();
         }
         this.components.push(param1);
      }
      
      public function event(param1:Class) : Object
      {
         var _loc3_:Vector.<Object> = null;
         var _loc4_:Class = null;
         if(this.events == null)
         {
            this.events = new Dictionary();
         }
         var _loc2_:Object = this.events[param1];
         if(_loc2_ == null)
         {
            _loc3_ = this.getComponents(param1);
            _loc4_ = modelRegistry.getEventsClass(param1);
            _loc2_ = new _loc4_(this,_loc3_);
            this.events[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function hasModel(param1:Class) : Boolean
      {
         return this.getComponents(param1).length > 0;
      }
      
      public function adapt(param1:Class) : Object
      {
         var _loc3_:Vector.<Object> = null;
         var _loc4_:Class = null;
         if(this.adapts == null)
         {
            this.adapts = new Dictionary();
         }
         var _loc2_:Object = this.adapts[param1];
         if(_loc2_ == null)
         {
            _loc3_ = this.getComponents(param1);
            if(_loc3_.length > 1)
            {
               throw new Error("GameObject::_adapt() Multiple models have been found. Object: " + this + ", interface: " + param1);
            }
            if(_loc3_.length == 0)
            {
               throw new Error("GameObject::adapt() No models have been found. Object: " + this + ", interface: " + param1);
            }
            _loc4_ = modelRegistry.getAdaptClass(param1);
            _loc2_ = new _loc4_(this,_loc3_[0]);
            this.adapts[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function putData(param1:Model, param2:Class, param3:Object) : void
      {
         var _loc4_:Dictionary = this.data[param1];
         if(_loc4_ == null)
         {
            _loc4_ = new Dictionary();
            this.data[param1] = _loc4_;
         }
         _loc4_[param2] = param3;
      }
      
      public function getData(param1:Model, param2:Class) : Object
      {
         var _loc3_:Dictionary = this.data[param1];
         return _loc3_ == null ? null : _loc3_[param2];
      }
      
      public function clearData(param1:Model, param2:Class) : Object
      {
         var _loc3_:Dictionary = this.data[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:Object = _loc3_[param2];
         delete _loc3_[param2];
         return _loc4_;
      }
      
      public function toString() : String
      {
         return "[GameObject id=" + this._id + "]";
      }
      
      private function getComponents(param1:Class) : Vector.<Object>
      {
         var _loc3_:Long = null;
         var _loc4_:Object = null;
         var _loc5_:Component = null;
         if(this.interfaceToComponentsList == null)
         {
            this.interfaceToComponentsList = new Dictionary();
         }
         if(param1 in this.interfaceToComponentsList)
         {
            return this.interfaceToComponentsList[param1];
         }
         var _loc2_:Vector.<Object> = new Vector.<Object>();
         if(this.gameClass != null)
         {
            for each(_loc3_ in this.gameClass.models)
            {
               _loc4_ = modelRegistry.getModel(_loc3_);
               if(_loc4_ is param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         if(this.components != null)
         {
            for each(_loc5_ in this.components)
            {
               if(_loc5_ is param1)
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         this.interfaceToComponentsList[param1] = _loc2_;
         return _loc2_;
      }
      
      public function clear() : void
      {
         this.clearModelsInitParams();
         this._gameClass = null;
         this._space = null;
         this.clearModelData();
         this.resetInterfaceCache();
      }
      
      private function clearModelData() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:Dictionary = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         for(_loc1_ in this.data)
         {
            _loc2_ = this.data[_loc1_];
            for(_loc3_ in _loc2_)
            {
               _loc4_ = _loc2_[_loc3_];
               if(_loc4_ is AutoClosable)
               {
                  AutoClosable(_loc4_).close();
               }
               delete _loc2_[_loc3_];
            }
            delete this.data[_loc1_];
         }
      }
      
      private function clearModelsInitParams() : void
      {
         var _loc1_:Long = null;
         var _loc2_:IModel = null;
         Model.object = this;
         for each(_loc1_ in this.gameClass.models)
         {
            _loc2_ = modelRegistry.getModel(_loc1_);
            if(_loc2_ != null)
            {
               _loc2_.clearInitParams();
            }
         }
         Model.popObject();
      }
      
      private function resetInterfaceCache() : void
      {
         this.clearDictionary(this.interfaceToComponentsList);
         this.clearDictionary(this.adapts);
         this.clearDictionary(this.events);
         this.interfaceToComponentsList = null;
         this.adapts = null;
         this.events = null;
      }
      
      private function clearDictionary(param1:Dictionary) : void
      {
         var _loc2_:* = undefined;
         if(param1 == null)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            delete param1[_loc2_];
         }
      }
   }
}

