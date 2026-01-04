package alternativa.tanks.gui.itemslist
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.DisplayObject;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class PartsListRenderer extends CellRenderer implements IResourceLoadingListener
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      private static var defaultStyles:Object = {
         "upSkin":null,
         "downSkin":null,
         "overSkin":null,
         "disabledSkin":null,
         "selectedDisabledSkin":null,
         "selectedUpSkin":null,
         "selectedDownSkin":null,
         "selectedOverSkin":null,
         "textFormat":null,
         "disabledTextFormat":null,
         "embedFonts":null,
         "textPadding":5
      };
      
      private var nicon:DisplayObject;
      
      private var sicon:DisplayObject;
      
      public function PartsListRenderer()
      {
         super();
         this.buttonMode = true;
         this.useHandCursor = true;
      }
      
      override public function set data(param1:Object) : void
      {
         _data = param1;
         this.nicon = param1.iconNormal;
         this.sicon = param1.iconSelected;
      }
      
      override public function set listData(param1:ListData) : void
      {
         var _loc2_:ImageResource = _data.dat.preview as ImageResource;
         if(_loc2_ != null)
         {
            if(_loc2_.data == null)
            {
               _loc2_.loadLazyResource(this);
            }
         }
         _listData = param1;
         label = _listData.label;
         if(this.nicon != null && this.sicon != null)
         {
            setStyle("icon",this.nicon);
            setStyle("selectedUpIcon",this.sicon);
            setStyle("selectedOverIcon",this.sicon);
            setStyle("selectedDownIcon",this.sicon);
         }
      }
      
      override protected function drawBackground() : void
      {
      }
      
      override protected function drawLayout() : void
      {
      }
      
      override protected function drawIcon() : void
      {
         var _loc2_:String = null;
         var _loc1_:DisplayObject = icon;
         _loc2_ = enabled ? mouseState : "disabled";
         if(selected)
         {
            _loc2_ = "selected" + _loc2_.substr(0,1).toUpperCase() + _loc2_.substr(1);
         }
         _loc2_ += "Icon";
         var _loc3_:Object = getStyleValue(_loc2_);
         if(_loc3_ == null)
         {
            _loc3_ = getStyleValue("icon");
         }
         if(_loc3_ != null)
         {
            icon = getDisplayObjectInstance(_loc3_);
         }
         if(icon != null)
         {
            addChildAt(icon,1);
         }
         if(_loc1_ != null && _loc1_ != icon && _loc1_.parent == this)
         {
            removeChild(_loc1_);
         }
      }
      
      public function onResourceLoadingStart(param1:Resource) : void
      {
      }
      
      public function onResourceLoadingProgress(param1:Resource, param2:int) : void
      {
      }
      
      public function onResourceLoadingComplete(param1:Resource) : void
      {
      }
      
      public function onResourceLoadingError(param1:Resource, param2:String) : void
      {
      }
      
      public function onResourceLoadingFatalError(param1:Resource, param2:String) : void
      {
      }
   }
}

