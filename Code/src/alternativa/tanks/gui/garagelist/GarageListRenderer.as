package alternativa.tanks.gui.garagelist
{
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.DisplayObject;
   import platform.client.fp10.core.resource.types.ImageResource;
   import utils.preview.IImageResource;
   import utils.preview.ImageResourceLoadingWrapper;
   
   public class GarageListRenderer extends CellRenderer implements IImageResource
   {
      
      private var nicon:DisplayObject;
      
      private var sicon:DisplayObject;
      
      public function GarageListRenderer()
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
         this.loadLazyResource();
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
      
      private function loadLazyResource() : void
      {
         var _loc1_:ImageResource = _data.preview as ImageResource;
         if(_loc1_ != null && !_loc1_.isLoaded)
         {
            _loc1_.loadLazyResource(new ImageResourceLoadingWrapper(this));
         }
      }
      
      public function setPreviewResource(param1:ImageResource) : void
      {
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
   }
}

