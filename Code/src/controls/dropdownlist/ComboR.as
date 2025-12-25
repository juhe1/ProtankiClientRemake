package controls.dropdownlist
{
   import controls.base.LabelBase;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import forms.ranks.SmallRankIcon;
   
   public class ComboR extends ComboBoxRenderer
   {
      
      public function ComboR()
      {
         super();
      }
      
      override protected function myIcon(param1:Object) : Sprite
      {
         var _loc3_:LabelBase = null;
         var _loc4_:SmallRankIcon = null;
         var _loc2_:Sprite = new Sprite();
         _loc3_ = new LabelBase();
         _loc3_.autoSize = TextFieldAutoSize.NONE;
         _loc3_.color = 16777215;
         _loc3_.alpha = param1.rang > 0 ? 0.5 : 1;
         _loc3_.text = param1.gameName;
         _loc3_.height = 20;
         _loc3_.width = _width - 20;
         _loc3_.y = 0;
         if(param1.rang > 0)
         {
            _loc4_ = new SmallRankIcon(param1.rang);
            _loc4_.x = -2;
            _loc4_.y = 2;
            _loc2_.addChild(_loc4_);
            _loc3_.x = 12;
         }
         else
         {
            _loc3_.x = -3;
         }
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
   }
}

