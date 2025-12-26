package projects.tanks.clients.fp10.libraries.tanksservices.service
{
   import alternativa.osgi.service.logging.LogService;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class TimeOutTruncateConsumers
   {
      
      [Inject]
      public static var logService:LogService;
      
      private const TRUNCATE_PERIOD:int = 300000;
      
      private var _intervalId:uint;
      
      private var _consumersLastAccessTime:Dictionary = new Dictionary();
      
      private var _consumers:Dictionary;
      
      private var _truncateFunction:Function;
      
      public function TimeOutTruncateConsumers()
      {
         super();
         this._intervalId = setInterval(this.truncateOutdatedConsumers,this.TRUNCATE_PERIOD);
      }
      
      public function get truncateFunction() : Function
      {
         return this._truncateFunction;
      }
      
      public function set truncateFunction(param1:Function) : void
      {
         this._truncateFunction = param1;
      }
      
      private function truncateOutdatedConsumers() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:IInfoLabelUpdater = null;
         if(this.truncateFunction == null)
         {
            return;
         }
         var _loc1_:Vector.<Long> = new Vector.<Long>();
         var _loc2_:Number = new Date().time - this.TRUNCATE_PERIOD;
         for(_loc3_ in this._consumers)
         {
            _loc4_ = this._consumers[_loc3_];
            if(_loc4_.lastAccessTime < _loc2_ && _loc4_.visibleLabelsCounter == 0)
            {
               _loc1_.push(_loc3_);
            }
         }
         if(_loc1_.length > 0)
         {
            this.truncateFunction(_loc1_);
         }
      }
      
      public function updateLastAccessTime(param1:Long) : void
      {
         this._consumersLastAccessTime[param1] = new Date().time;
      }
      
      public function set consumers(param1:Dictionary) : void
      {
         this._consumers = param1;
      }
      
      public function stop() : void
      {
         clearInterval(this._intervalId);
      }
   }
}

