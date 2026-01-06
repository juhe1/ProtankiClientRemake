package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf
{
   public class CTFScoreIndicatorBlinker
   {
      
      public var values:Vector.<Number>;
      
      private var maxValue:Number;
      
      private var minValue:Number;
      
      private var intervals:Vector.<int>;
      
      private var speedCoeffs:Vector.<Number>;
      
      private var numValues:int;
      
      private var speeds:Vector.<Number>;
      
      private var switchTimes:Vector.<int>;
      
      private var valueDelta:Number;
      
      private var runCount:int = 0;
      
      public function CTFScoreIndicatorBlinker(param1:Number, param2:Number, param3:Vector.<int>, param4:Vector.<Number>)
      {
         super();
         this.minValue = param1;
         this.maxValue = param2;
         this.intervals = param3;
         this.speedCoeffs = param4;
         this.valueDelta = param2 - param1;
         this.numValues = param3.length;
         this.speeds = new Vector.<Number>(this.numValues);
         this.switchTimes = new Vector.<int>(this.numValues);
         this.values = new Vector.<Number>(this.numValues);
      }
      
      public function start(param1:int) : void
      {
         if(this.runCount == 0)
         {
            this.init(param1);
         }
         ++this.runCount;
      }
      
      public function stop() : void
      {
         --this.runCount;
      }
      
      public function update(param1:int, param2:int) : void
      {
         if(this.runCount <= 0)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.numValues)
         {
            this.values[_loc3_] += this.speeds[_loc3_] * param2;
            if(this.values[_loc3_] > this.maxValue)
            {
               this.values[_loc3_] = this.maxValue;
            }
            if(this.values[_loc3_] < this.minValue)
            {
               this.values[_loc3_] = this.minValue;
            }
            if(param1 >= this.switchTimes[_loc3_])
            {
               this.switchTimes[_loc3_] += this.intervals[_loc3_];
               if(this.speeds[_loc3_] < 0)
               {
                  this.speeds[_loc3_] = this.getSpeed(1,this.speedCoeffs[_loc3_],this.intervals[_loc3_]);
               }
               else
               {
                  this.speeds[_loc3_] = this.getSpeed(-1,this.speedCoeffs[_loc3_],this.intervals[_loc3_]);
               }
            }
            _loc3_++;
         }
      }
      
      private function init(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.numValues)
         {
            this.speeds[_loc2_] = this.getSpeed(-1,this.speedCoeffs[_loc2_],this.intervals[_loc2_]);
            this.values[_loc2_] = this.maxValue;
            this.switchTimes[_loc2_] = param1 + this.intervals[_loc2_];
            _loc2_++;
         }
      }
      
      private function getSpeed(param1:Number, param2:Number, param3:int) : Number
      {
         return param1 * param2 * this.valueDelta / param3;
      }
   }
}

