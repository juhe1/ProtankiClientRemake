package controls.dropdownlist
{
   import controls.base.LabelBase;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   
   public class AccountsRenderer extends ComboR
   {
      
      private static var overStyleClass:Class = AccountsRenderer_overStyleClass;
      
      private static var overStyleBitmapData:BitmapData = new overStyleClass().bitmapData;
      
      public function AccountsRenderer()
      {
         super();
      }
      
      override protected function myIcon(param1:Object) : Sprite
      {
         var _loc3_:LabelBase = null;
         var _loc2_:Sprite = new Sprite();
         _loc3_ = new LabelBase();
         _loc3_.autoSize = TextFieldAutoSize.NONE;
         _loc3_.color = 16777215;
         _loc3_.alpha = param1.rang > 0 ? 0.5 : 1;
         _loc3_.text = param1.gameName;
         _loc3_.height = AccountsList.ROW_HEIGHT;
         _loc3_.width = _width - 20;
         _loc3_.x -= 5;
         _loc2_.addChild(_loc3_);
         var _loc4_:DeleteIndicator = new DeleteIndicator(param1);
         _loc4_.x = _loc2_.width - _loc4_.width + 5;
         _loc2_.addChild(_loc4_);
         tabEnabled = false;
         mouseEnabled = false;
         mouseChildren = true;
         return _loc2_;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Bitmap = new Bitmap(new BitmapData(1,1,true,0));
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginBitmapFill(overStyleBitmapData);
         _loc3_.graphics.drawRect(0,0,1,18);
         _loc3_.graphics.endFill();
         _data = param1;
         setStyle("upSkin",_loc2_);
         setStyle("downSkin",_loc3_);
         setStyle("overSkin",_loc3_);
         setStyle("selectedUpSkin",_loc2_);
         setStyle("selectedOverSkin",_loc3_);
         setStyle("selectedDownSkin",_loc3_);
      }
   }
}

