package forms.payment
{
   import controls.base.LabelBase;
   import controls.statassets.StatLineBackgroundNormal;
   import controls.statassets.StatLineBackgroundSelected;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import utils.TextUtils;
   
   public class PaymentListRenderer extends CellRenderer
   {
      
      private static var _withSMSText:Boolean = false;
      
      private var nicon:DisplayObject;
      
      public function PaymentListRenderer()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         _data = param1;
         _withSMSText = _data.smsText !== "";
         var _loc2_:DisplayObject = new StatLineBackgroundNormal();
         var _loc3_:DisplayObject = new StatLineBackgroundSelected();
         this.nicon = this.myIcon(_data);
         setStyle("upSkin",_loc2_);
         setStyle("downSkin",_loc2_);
         setStyle("overSkin",_loc2_);
         setStyle("selectedUpSkin",_loc3_);
         setStyle("selectedOverSkin",_loc3_);
         setStyle("selectedDownSkin",_loc3_);
      }
      
      override public function set listData(param1:ListData) : void
      {
         _listData = param1;
         label = _listData.label;
         if(this.nicon != null)
         {
            setStyle("icon",this.nicon);
         }
      }
      
      private function myIcon(param1:Object) : Sprite
      {
         var _loc2_:Sprite = null;
         var _loc3_:LabelBase = null;
         var _loc4_:LabelBase = null;
         var _loc5_:Bitmap = null;
         var _loc6_:LabelBase = null;
         var _loc8_:int = 0;
         _loc2_ = new Sprite();
         _loc3_ = new LabelBase();
         _loc4_ = new LabelBase();
         _loc5_ = new Bitmap();
         _loc6_ = new LabelBase();
         var _loc7_:LabelBase = new LabelBase();
         _loc8_ = _withSMSText ? 80 : int((_width - 72) / 2);
         _loc3_.autoSize = TextFieldAutoSize.NONE;
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.size = 13;
         _loc3_.height = 20;
         _loc3_.x = -5;
         _loc3_.width = 70;
         _loc3_.text = _data.number;
         _loc2_.addChild(_loc3_);
         _loc6_.autoSize = TextFieldAutoSize.NONE;
         _loc6_.align = TextFormatAlign.RIGHT;
         _loc6_.size = 13;
         _loc6_.height = 20;
         _loc6_.text = _data.cost;
         _loc6_.x = 72;
         _loc6_.width = int(_loc8_) - 7;
         _loc2_.addChild(_loc6_);
         if(_withSMSText)
         {
            _loc4_.autoSize = TextFieldAutoSize.NONE;
            _loc4_.align = TextFormatAlign.LEFT;
            _loc4_.size = 12;
            _loc4_.height = 20;
            _loc5_.x = 72;
            _loc4_.width = _width - 210;
            _loc4_.text = _data.smsText;
            _loc5_.bitmapData = TextUtils.getTextInCells(_loc4_,12,18,5898034);
            _loc2_.addChild(_loc5_);
            _loc6_.x = _loc4_.width + 74;
         }
         _loc7_.autoSize = TextFieldAutoSize.NONE;
         _loc7_.align = TextFormatAlign.RIGHT;
         _loc7_.size = 13;
         _loc7_.height = 20;
         _loc7_.x = _loc6_.x + _loc6_.width + 2;
         _loc7_.width = int(_width - _loc7_.x - 12);
         _loc7_.text = _data.crystals;
         _loc2_.addChild(_loc7_);
         return _loc2_;
      }
      
      override protected function drawBackground() : void
      {
         var _loc1_:String = enabled ? mouseState : "disabled";
         if(selected)
         {
            _loc1_ = "selected" + _loc1_.substr(0,1).toUpperCase() + _loc1_.substr(1);
         }
         _loc1_ += "Skin";
         var _loc2_:DisplayObject = background;
         background = getDisplayObjectInstance(getStyleValue(_loc1_));
         addChildAt(background,0);
         if(_loc2_ != null && _loc2_ != background)
         {
            removeChild(_loc2_);
         }
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
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

