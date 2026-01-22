package alternativa.tanks.gui.friends.list.refferals
{
   import controls.Money;
   import controls.base.LabelBase;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import forms.ColorConstants;
   import forms.stat.StatListRenderer;
   import forms.userlabel.UserLabel;
   
   public class ReferralStatListRenderer extends StatListRenderer
   {
      
      private var userLabel:UserLabel;
      
      public function ReferralStatListRenderer()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         _data = param1;
         _loc2_ = new ReferralStatLineBackgroundNormal();
         _loc3_ = new ReferalStatLineBackgroundSelected();
         this.mouseChildren = true;
         this.buttonMode = this.useHandCursor = false;
         nicon = this.myIcon(_data);
         _data.uid = this.userLabel.uid;
         setStyle("upSkin",_loc2_);
         setStyle("downSkin",_loc2_);
         setStyle("overSkin",_loc2_);
         setStyle("selectedUpSkin",_loc3_);
         setStyle("selectedOverSkin",_loc3_);
         setStyle("selectedDownSkin",_loc3_);
      }
      
      override protected function myIcon(param1:Object) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         this.userLabel = new UserLabel(param1.userId);
         this.userLabel.inviteBattleEnable = true;
         this.userLabel.setUidColor(ColorConstants.WHITE);
         this.userLabel.x = -3;
         this.userLabel.y = -1;
         _loc2_.addChild(this.userLabel);
         var _loc3_:LabelBase = new LabelBase();
         _loc3_.autoSize = TextFieldAutoSize.NONE;
         _loc3_.align = TextFormatAlign.RIGHT;
         _loc3_.width = 90;
         _loc3_.x = _width - 100;
         _loc3_.text = param1.income > -1 ? Money.numToString(param1.income,false) : "null";
         _loc3_.y = -1;
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
   }
}

