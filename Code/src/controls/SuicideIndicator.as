package controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol590")]
   public class SuicideIndicator extends Sprite
   {
      
      public var che:MovieClip;
      
      private var _che:MovieClip;
      
      private var endTime:int;
      
      private var nextTime:int;
      
      private const RATIO:int = 10;
      
      public function SuicideIndicator()
      {
         super();
         this._che = getChildByName("che") as MovieClip;
         visible = false;
      }
      
      public function show(param1:int) : void
      {
         var _loc2_:int = getTimer();
         this.endTime = _loc2_ + param1;
         this.nextTime = _loc2_ + (this.endTime - _loc2_) / this.RATIO;
         visible = true;
         this._che.visible = true;
         addEventListener(Event.ENTER_FRAME,this.triggerCherep);
      }
      
      private function triggerCherep(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ >= this.nextTime)
         {
            this._che.visible = !this._che.visible;
            this.nextTime += (this.endTime - _loc2_) / this.RATIO;
         }
         if(_loc2_ >= this.endTime)
         {
            visible = false;
            removeEventListener(Event.ENTER_FRAME,this.triggerCherep);
         }
      }
   }
}

