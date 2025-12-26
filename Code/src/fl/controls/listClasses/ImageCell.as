package fl.controls.listClasses
{
   import fl.containers.UILoader;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.events.IOErrorEvent;
   
   [Style(name="textOverlayAlpha",type="Number",format="Length")]
   [Style(name="imagePadding",type="Number",format="Length")]
   [Style(name="textPadding",type="Number",format="Length")]
   [Style(name="selectedSkin",type="Class")]
   public class ImageCell extends CellRenderer implements ICellRenderer
   {
      
      private static var defaultStyles:Object = {
         "imagePadding":1,
         "textOverlayAlpha":0.7
      };
      
      protected var textOverlay:Shape;
      
      protected var loader:UILoader;
      
      public function ImageCell()
      {
         super();
         loader = new UILoader();
         loader.addEventListener(IOErrorEvent.IO_ERROR,handleErrorEvent,false,0,true);
         loader.autoLoad = true;
         loader.scaleContent = true;
         addChild(loader);
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(defaultStyles,CellRenderer.getStyleDefinition());
      }
      
      protected function handleErrorEvent(param1:IOErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override public function get listData() : ListData
      {
         return _listData;
      }
      
      override protected function drawLayout() : void
      {
         var _loc4_:Number = NaN;
         var _loc1_:Number = getStyleValue("imagePadding") as Number;
         loader.move(_loc1_,_loc1_);
         var _loc2_:Number = width - _loc1_ * 2;
         var _loc3_:Number = height - _loc1_ * 2;
         if(loader.width != _loc2_ && loader.height != _loc3_)
         {
            loader.setSize(_loc2_,_loc3_);
         }
         loader.drawNow();
         if(_label == "" || _label == null)
         {
            if(contains(textField))
            {
               removeChild(textField);
            }
            if(contains(textOverlay))
            {
               removeChild(textOverlay);
            }
         }
         else
         {
            _loc4_ = getStyleValue("textPadding") as Number;
            textField.width = Math.min(width - _loc4_ * 2,textField.textWidth + 5);
            textField.height = textField.textHeight + 5;
            textField.x = Math.max(_loc4_,width / 2 - textField.width / 2);
            textField.y = height - textField.height - _loc4_;
            textOverlay.x = _loc1_;
            textOverlay.height = textField.height + _loc4_ * 2;
            textOverlay.y = height - textOverlay.height - _loc1_;
            textOverlay.width = width - _loc1_ * 2;
            textOverlay.alpha = getStyleValue("textOverlayAlpha") as Number;
            addChild(textOverlay);
            addChild(textField);
         }
         background.width = width;
         background.height = height;
      }
      
      override public function set listData(param1:ListData) : void
      {
         _listData = param1;
         label = _listData.label;
         var _loc2_:Object = (_listData as TileListData).source;
         if(source != _loc2_)
         {
            source = _loc2_;
         }
      }
      
      public function set source(param1:Object) : void
      {
         loader.source = param1;
      }
      
      public function get source() : Object
      {
         return loader.source;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         textOverlay = new Shape();
         var _loc1_:Graphics = textOverlay.graphics;
         _loc1_.beginFill(16777215);
         _loc1_.drawRect(0,0,100,100);
         _loc1_.endFill();
      }
   }
}

