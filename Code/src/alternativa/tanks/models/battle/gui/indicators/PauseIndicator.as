package alternativa.tanks.models.battle.gui.indicators
{
   import assets.IconAlarm;
   import controls.Label;
   import controls.statassets.BlackRoundRect;
   import flash.text.TextFieldAutoSize;
   
   public class PauseIndicator extends BlackRoundRect
   {
      
      private static const TIME_REPLACE_PATTERN:String = "{time}";
      
      private var timelLabel:Label;
      
      private var battleLeaveText:String;
      
      private var _seconds:int;
      
      public function PauseIndicator(param1:String, param2:String, param3:String)
      {
         var _loc9_:int = 0;
         var _loc10_:Label = null;
         var _loc11_:Label = null;
         super();
         this.battleLeaveText = param3;
         var _loc4_:int = 33;
         var _loc5_:int = 33;
         var _loc6_:int = 5;
         var _loc7_:int = 16;
         var _loc8_:IconAlarm = new IconAlarm();
         addChild(_loc8_);
         _loc8_.y = _loc4_;
         _loc9_ = _loc8_.y + _loc8_.height + 2 * _loc6_;
         _loc10_ = new Label();
         _loc10_.size = _loc7_;
         _loc10_.text = param1;
         _loc10_.y = _loc9_;
         addChild(_loc10_);
         width = _loc10_.textWidth;
         _loc9_ += _loc10_.height + _loc6_;
         _loc11_ = new Label();
         _loc11_.size = _loc7_;
         _loc11_.text = param2;
         _loc11_.y = _loc9_;
         addChild(_loc11_);
         if(width < _loc11_.textWidth)
         {
            width = _loc11_.textWidth;
         }
         _loc9_ += _loc11_.height + _loc6_;
         this.timelLabel = new Label();
         this.timelLabel.size = _loc7_;
         this.timelLabel.autoSize = TextFieldAutoSize.LEFT;
         this.timelLabel.text = param3 + " 99:99";
         this.timelLabel.y = _loc9_;
         addChild(this.timelLabel);
         if(width < this.timelLabel.textWidth)
         {
            width = this.timelLabel.textWidth;
         }
         width += 2 * _loc5_;
         _loc8_.x = width - _loc8_.width >> 1;
         _loc10_.x = width - _loc10_.width >> 1;
         _loc11_.x = width - _loc11_.width >> 1;
         height = _loc9_ + this.timelLabel.height + _loc4_ - 5;
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
         this.timelLabel.text = this.battleLeaveText.replace(TIME_REPLACE_PATTERN,_loc2_ + ":" + _loc3_);
         this.timelLabel.x = width - this.timelLabel.width >> 1;
      }
   }
}

