package controls
{
   import assets.combo.ComboListOverState;
   import controls.rangicons.RangIconSmall;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ComboListRenderer extends CellRenderer
   {
      
      private var format:TextFormat = new TextFormat("MyriadPro",13);
      
      private var nicon:DisplayObject;
      
      private var normalStyle:Bitmap;
      
      private var overStyle:ComboListOverState = new ComboListOverState();
      
      public function ComboListRenderer()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ButtonState = null;
         this.normalStyle = new Bitmap(new BitmapData(1,1,true,0));
         _data = param1;
         setStyle("upSkin",this.normalStyle);
         setStyle("downSkin",this.overStyle);
         setStyle("overSkin",this.overStyle);
         setStyle("selectedUpSkin",this.normalStyle);
         setStyle("selectedOverSkin",this.overStyle);
         setStyle("selectedDownSkin",this.overStyle);
      }
      
      private function myIcon(param1:Object) : Sprite
      {
         var _loc3_:Label = null;
         var _loc4_:RangIconSmall = null;
         var _loc2_:Sprite = new Sprite();
         _loc3_ = new Label();
         _loc3_.autoSize = TextFieldAutoSize.NONE;
         _loc3_.color = 16777215;
         _loc3_.alpha = param1.rang > 0 ? 0.5 : 1;
         _loc3_.text = param1.gameName;
         _loc3_.height = 20;
         _loc3_.width = _width - 20;
         _loc3_.x = 12;
         _loc3_.y = 0;
         if(param1.rang > 0)
         {
            _loc4_ = new RangIconSmall(param1.rang);
            _loc4_.x = -2;
            _loc4_.y = 2;
            _loc2_.addChild(_loc4_);
         }
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      override public function set listData(param1:ListData) : void
      {
         _listData = param1;
         label = "";
         this.nicon = this.myIcon(_data);
         if(this.nicon != null)
         {
            setStyle("icon",this.nicon);
         }
      }
      
      override protected function drawIcon() : void
      {
         var _loc1_:DisplayObject = icon;
         var _loc2_:String = enabled ? mouseState : "disabled";
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

