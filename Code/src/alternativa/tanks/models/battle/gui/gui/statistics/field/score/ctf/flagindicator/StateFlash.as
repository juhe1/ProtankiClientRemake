package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator
{
   public class StateFlash implements IFlagIndicatorState
   {
      
      private static const STATE_FADE_IN:int = 1;
      
      private static const STATE_WAIT:int = 2;
      
      private static const STATE_FADE_OUT:int = 3;
      
      private var type:int;
      
      private var indicator:FlagIndicator;
      
      private var waitTime:int;
      
      private var time:int;
      
      private var fadeInSpeed:Number = 0.01;
      
      private var fadeOutSpeed:Number = 0.001;
      
      private var state:int;
      
      public function StateFlash(param1:int, param2:FlagIndicator, param3:Number, param4:Number, param5:int)
      {
         super();
         this.type = param1;
         this.indicator = param2;
         this.fadeInSpeed = param3;
         this.fadeOutSpeed = param4;
         this.waitTime = param5;
      }
      
      public function getType() : int
      {
         return this.type;
      }
      
      public function start() : void
      {
         this.indicator.normalBitmap.visible = true;
         this.indicator.normalBitmap.alpha = 1;
         this.indicator.lostBitmap.visible = false;
         this.indicator.flashBitmap.visible = true;
         this.indicator.flashBitmap.alpha = 0;
         this.state = STATE_FADE_IN;
      }
      
      public function stop() : void
      {
      }
      
      public function update(param1:int, param2:int) : void
      {
         var _loc3_:Number = this.indicator.normalBitmap.alpha;
         switch(this.state)
         {
            case STATE_FADE_IN:
               _loc3_ -= this.fadeInSpeed * param2;
               if(_loc3_ <= 0)
               {
                  _loc3_ = 0;
                  this.state = STATE_WAIT;
                  this.time = this.waitTime;
               }
               break;
            case STATE_WAIT:
               this.time -= param2;
               if(this.time <= 0)
               {
                  this.state = STATE_FADE_OUT;
               }
               break;
            case STATE_FADE_OUT:
               _loc3_ += this.fadeOutSpeed * param2;
               if(_loc3_ >= 1)
               {
                  this.indicator.setState(FlagIndicator.STATE_DEFAULT);
               }
         }
         this.indicator.normalBitmap.alpha = _loc3_;
         this.indicator.flashBitmap.alpha = 1 - _loc3_;
      }
   }
}

