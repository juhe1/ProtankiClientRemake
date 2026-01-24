package alternativa.tanks.models.battle.gui.indicators
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.utils.removeDisplayObject;
   import controls.base.LabelBase;
   import controls.statassets.BlackRoundRect;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class SuicideIndicator extends BlackRoundRect
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleGUIService:BattleGUIService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const reArmorIconClass:Class = SuicideIndicator_reArmorIconClass;
      
      private static const TIME_REPLACE_PATTERN:String = "{time}";
      
      private var _timeLabel:LabelBase;
      
      private var _throughText:String;
      
      private var _seconds:int;
      
      private var _isShow:Boolean;
      
      public function SuicideIndicator()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var _loc6_:int = 0;
         this._throughText = localeService.getText(TanksLocale.TEXT_REARM_SELFDISTRUCTION);
         var _loc1_:int = 33;
         var _loc2_:int = 33;
         var _loc3_:int = 5;
         var _loc4_:int = 16;
         var _loc5_:Bitmap = new Bitmap(new reArmorIconClass().bitmapData);
         addChild(_loc5_);
         _loc5_.y = _loc1_ - 5;
         _loc6_ = _loc5_.y + _loc5_.height + 2 * _loc3_;
         this._timeLabel = new LabelBase();
         this._timeLabel.size = _loc4_;
         this._timeLabel.autoSize = TextFieldAutoSize.LEFT;
         this._timeLabel.text = this._throughText.replace(TIME_REPLACE_PATTERN," 99:99");
         this._timeLabel.y = _loc6_;
         addChild(this._timeLabel);
         if(width < this._timeLabel.textWidth)
         {
            width = this._timeLabel.textWidth;
         }
         width += 2 * _loc2_;
         _loc5_.x = width - _loc5_.width >> 1;
         height = _loc6_ + this._timeLabel.height + _loc1_ - 5;
      }
      
      public function set seconds(param1:int) : void
      {
         if(this._seconds == param1)
         {
            return;
         }
         this._seconds = param1;
         var _loc2_:int = this._seconds / 60;
         this._seconds -= _loc2_ * 60;
         var _loc3_:String = this._seconds < 10 ? "0" + this._seconds : this._seconds.toString();
         this._timeLabel.text = this._throughText.replace(TIME_REPLACE_PATTERN,_loc2_ + ":" + _loc3_);
         this._timeLabel.x = width - this._timeLabel.width >> 1;
      }
      
      public function show(param1:int) : void
      {
         if(this._isShow)
         {
            return;
         }
         this._isShow = true;
         this.seconds = param1;
         battleGUIService.getViewportContainer().addChild(this);
         this.onResize();
         display.stage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onResize(param1:Event = null) : void
      {
         this.x = display.stage.stageWidth - this.width >> 1;
         this.y = display.stage.stageHeight - this.height >> 1;
      }
      
      public function hide() : void
      {
         if(!this._isShow)
         {
            return;
         }
         this._isShow = false;
         removeDisplayObject(this);
         display.stage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      public function destroy() : void
      {
         this.hide();
         this._timeLabel = null;
      }
   }
}

