package alternativa.tanks.animations
{
   public class KeyFrameAnimation
   {
      
      private var track:AnimationTrack;
      
      private var currentFrame:int;
      
      private var time:Number;
      
      private var animatedValue:AnimatedValue;
      
      public function KeyFrameAnimation(param1:AnimationTrack, param2:AnimatedValue)
      {
         super();
         this.track = param1;
         this.animatedValue = param2;
      }
      
      public function start() : void
      {
         this.time = this.track.getMinTime();
         this.currentFrame = 0;
      }
      
      public function isComplete() : Boolean
      {
         return this.currentFrame == this.track.getNumFrames() - 1;
      }
      
      public function update(param1:Number) : void
      {
         if(!this.isComplete())
         {
            this.time += param1;
            while(this.time > this.track.getFrameTime(this.currentFrame + 1))
            {
               ++this.currentFrame;
               if(this.isComplete())
               {
                  this.time = this.track.getMaxTime();
                  break;
               }
            }
            this.animatedValue.setAnimatedValue(this.getValue());
         }
      }
      
      private function getValue() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.isComplete())
         {
            return this.track.getFrameTime(this.currentFrame);
         }
         _loc1_ = this.track.getFrameTime(this.currentFrame);
         _loc2_ = this.track.getFrameTime(this.currentFrame + 1);
         _loc3_ = this.track.getFrameValue(this.currentFrame);
         _loc4_ = this.track.getFrameValue(this.currentFrame + 1);
         return _loc3_ + (_loc4_ - _loc3_) * (this.time - _loc1_) / (_loc2_ - _loc1_);
      }
   }
}

