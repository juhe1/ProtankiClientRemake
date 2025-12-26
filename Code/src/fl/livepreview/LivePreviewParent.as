package fl.livepreview
{
   import flash.display.*;
   import flash.external.*;
   import flash.utils.*;
   
   public class LivePreviewParent extends MovieClip
   {
      
      public var myInstance:DisplayObject;
      
      public function LivePreviewParent()
      {
         super();
         try
         {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            myInstance = getChildAt(0);
            onResize(stage.width,stage.height);
            if(ExternalInterface.available)
            {
               ExternalInterface.addCallback("onResize",onResize);
               ExternalInterface.addCallback("onUpdate",onUpdate);
            }
         }
         catch(e:*)
         {
         }
      }
      
      public function onUpdate(... rest) : void
      {
         var name:String = null;
         var value:* = undefined;
         var updateArray:Array = rest;
         var i:int = 0;
         while(i + 1 < updateArray.length)
         {
            try
            {
               name = String(updateArray[i]);
               value = updateArray[i + 1];
               if(typeof value == "object" && Boolean(value.__treatAsCollectionSpecialSauce__))
               {
                  updateCollection(value,name);
               }
               else
               {
                  myInstance[name] = value;
               }
            }
            catch(e:Error)
            {
            }
            i += 2;
         }
      }
      
      public function onResize(param1:Number, param2:Number) : void
      {
         var width:Number = param1;
         var height:Number = param2;
         var setSizeFn:Function = null;
         try
         {
            setSizeFn = myInstance["setSize"];
         }
         catch(e:Error)
         {
            setSizeFn = null;
         }
         if(setSizeFn != null)
         {
            setSizeFn(width,height);
         }
         else
         {
            myInstance.width = width;
            myInstance.height = height;
         }
      }
      
      private function updateCollection(param1:Object, param2:String) : void
      {
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:* = undefined;
         var _loc3_:Class = Class(getDefinitionByName(param1.collectionClass));
         var _loc4_:Class = Class(getDefinitionByName(param1.collectionItemClass));
         var _loc5_:Object = new _loc3_();
         var _loc6_:int = 0;
         while(_loc6_ < param1.collectionArray.length)
         {
            _loc7_ = new _loc4_();
            _loc8_ = param1.collectionArray[_loc6_];
            for(_loc9_ in _loc8_)
            {
               _loc7_[_loc9_] = _loc8_[_loc9_];
            }
            _loc5_.addItem(_loc7_);
            _loc6_++;
         }
         myInstance[param2] = _loc5_ as _loc3_;
      }
   }
}

