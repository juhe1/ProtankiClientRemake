package controls.timer
{
   import alternativa.osgi.service.logging.LogService;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class CountDownTimer implements AutoClosable
   {
      
      [Inject] // added
      public static var logService:LogService;
      
      private static var intervalId:int;
      
      private static var allTimers:Vector.<CountDownTimer> = new Vector.<CountDownTimer>();
      
      private static var EMPTY_VECTOR:Vector.<Object> = new Vector.<Object>(0,true);
      
      private var endTime:Number;
      
      private var remainingTimeInSeconds:int;
      
      private var allListeners:Object = {};
      
      public function CountDownTimer()
      {
         super();
      }
      
      public static function resetAllTimers() : void
      {
         if(allTimers.length != 0)
         {
            clearInterval(intervalId);
            allTimers.length = 0;
         }
      }
      
      private static function onAllTimersTick() : void
      {
         var _loc3_:CountDownTimer = null;
         var _loc1_:int = getTimer();
         var _loc2_:int = allTimers.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = allTimers[_loc2_];
            _loc3_.onTick(_loc1_);
            _loc2_--;
         }
      }
      
      public function addListener(param1:Class, param2:Object) : void
      {
         var _loc3_:Vector.<Object> = this.allListeners[param1];
         if(_loc3_ == null)
         {
            this.allListeners[param1] = _loc3_ = new Vector.<Object>();
         }
         _loc3_.push(param2);
      }
      
      public function removeListener(param1:Class, param2:Object) : void
      {
         var _loc3_:Vector.<Object> = this.allListeners[param1];
         if(_loc3_ != null)
         {
            _loc3_.splice(_loc3_.indexOf(param2),1);
         }
      }
      
      public function start(param1:Number) : void
      {
         this.endTime = param1;
         this.addTimer();
         this.remainingTimeInSeconds = Math.ceil((param1 - getTimer()) / 1000);
      }
      
      public function destroy() : void
      {
         this.removeTimer();
         this.allListeners = {};
      }
      
      public function stop() : void
      {
         this._stop(true);
      }
      
      private function _stop(param1:Boolean) : void
      {
         var _loc2_:CountDownTimerOnCompleteBefore = null;
         var _loc3_:CountDownTimerOnCompleteAfter = null;
         this.removeTimer();
         this.remainingTimeInSeconds = 0;
         for each(_loc2_ in this.getListeners(CountDownTimerOnCompleteBefore).concat())
         {
            _loc2_.onCompleteBefore(this,param1);
         }
         for each(_loc3_ in this.getListeners(CountDownTimerOnCompleteAfter).concat())
         {
            _loc3_.onCompleteAfter(this,param1);
         }
         this.allListeners = {};
      }
      
      public function getRemainingSeconds() : int
      {
         return this.remainingTimeInSeconds;
      }
      
      public function getEndTime() : uint
      {
         return this.endTime;
      }
      
      private function onTick(param1:int) : void
      {
         var _loc2_:CountDownTimerOnTick = null;
         this.remainingTimeInSeconds = Math.ceil((this.endTime - param1) / 1000);
         if(this.remainingTimeInSeconds <= 0)
         {
            this._stop(false);
         }
         else
         {
            for each(_loc2_ in this.getListeners(CountDownTimerOnTick))
            {
               _loc2_.onTick(this);
            }
         }
      }
      
      private function getListeners(param1:Class) : Vector.<Object>
      {
         var _loc2_:Vector.<Object> = this.allListeners[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         return EMPTY_VECTOR;
      }
      
      private function addTimer() : void
      {
         if(allTimers.length == 0)
         {
            intervalId = setInterval(onAllTimersTick,1000);
         }
         allTimers.push(this);
      }
      
      private function removeTimer() : void
      {
         var _loc1_:Number = Number(allTimers.indexOf(this));
         if(_loc1_ == -1)
         {
            return;
         }
         allTimers.splice(_loc1_,1);
         if(allTimers.length == 0)
         {
            clearInterval(intervalId);
         }
      }
      
      public function close() : void
      {
         this.destroy();
      }
   }
}

