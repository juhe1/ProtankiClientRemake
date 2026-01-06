package alternativa.tanks.battle
{
   import flash.utils.getTimer;
   
   public class FPSCounter
   {
      
      private var framesToAverage:int;
      
      private var lastTime:int;
      
      private var frameCounter:int;
      
      private var fps:Number = 0;
      
      public function FPSCounter(param1:int)
      {
         super();
         this.framesToAverage = param1;
         this.lastTime = getTimer();
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(++this.frameCounter >= this.framesToAverage)
         {
            _loc1_ = getTimer();
            _loc2_ = _loc1_ - this.lastTime;
            this.lastTime = _loc1_;
            this.fps = 1000 * this.frameCounter / _loc2_;
            this.frameCounter = 0;
         }
      }
      
      public function getFPS() : Number
      {
         return this.fps;
      }
   }
}

