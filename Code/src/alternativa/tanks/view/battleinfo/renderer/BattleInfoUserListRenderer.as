package alternativa.tanks.view.battleinfo.renderer
{
   import alternativa.tanks.view.battleinfo.LocaleBattleInfo;
   import controls.base.LabelBase;
   import controls.cellrenderer.ButtonState;
   import controls.cellrenderer.CellNormal;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import fonts.TanksFontService;
   import forms.ColorConstants;
   import forms.Styles;
   import forms.userlabel.UserLabel;
   
   public class BattleInfoUserListRenderer extends CellRenderer
   {
      
      private var format:TextFormat = TanksFontService.getTextFormat(13);
      
      private var nicon:DisplayObject;
      
      private var style:ButtonState = new CellNormal();
      
      public function BattleInfoUserListRenderer()
      {
         super();
         this.format.color = ColorConstants.WHITE;
         setStyle(Styles.TEXT_FORMAT,this.format);
         setStyle(Styles.EMBED_FONTS,TanksFontService.isEmbedFonts());
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ButtonState = null;
         _loc2_ = this.getCurrentStyle();
         _data = param1;
         mouseChildren = true;
         buttonMode = false;
         useHandCursor = false;
         this.nicon = this.myIcon(_data);
         setStyle(Styles.UP_SKIN,_loc2_);
         setStyle(Styles.DOWN_SKIN,_loc2_);
         setStyle(Styles.OVER_SKIN,_loc2_);
         setStyle(Styles.SELECTED_UP_SKIN,_loc2_);
         setStyle(Styles.SELECTED_OVER_SKIN,_loc2_);
         setStyle(Styles.SELECTED_DOWN_SKIN,_loc2_);
      }
      
      private function myIcon(param1:Object) : Sprite
      {
         var _loc3_:UserLabel = null;
         var _loc4_:LabelBase = null;
         var _loc5_:LabelBase = null;
         if(_width < 0)
         {
            _width = 20;
         }
         var _loc2_:Sprite = new Sprite();
         if(param1.id != null)
         {
            _loc3_ = new UserLabel(param1.id);
            if(Boolean(param1.suspicious))
            {
               _loc3_.setUidColor(ColorConstants.SUSPICIOUS,true);
            }
            else
            {
               _loc3_.setUidColor(ColorConstants.WHITE);
            }
            _loc3_.x = -4;
            _loc3_.y = 0;
            _loc2_.addChild(_loc3_);
            _loc4_ = new LabelBase();
            _loc4_.mouseEnabled = false;
            _loc4_.color = ColorConstants.WHITE;
            _loc4_.autoSize = TextFieldAutoSize.NONE;
            _loc4_.align = TextFormatAlign.RIGHT;
            _loc4_.text = param1.score;
            _loc4_.height = 20;
            _loc4_.width = 120;
            _loc4_.x = _width - 135;
            _loc4_.y = 0;
            _loc2_.addChild(_loc4_);
         }
         else
         {
            _loc5_ = new LabelBase();
            _loc5_.text = LocaleBattleInfo.noNameText;
            _loc5_.alpha = 0.5;
            _loc5_.x = 10;
            _loc2_.addChild(_loc5_);
         }
         return _loc2_;
      }
      
      override public function set listData(param1:ListData) : void
      {
         _listData = param1;
         label = "";
         if(this.nicon != null)
         {
            setStyle(Styles.ICON,this.nicon);
         }
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         background.width = width - 4;
         background.height = height;
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
      
      public function getCurrentStyle() : ButtonState
      {
         return this.style;
      }
   }
}

