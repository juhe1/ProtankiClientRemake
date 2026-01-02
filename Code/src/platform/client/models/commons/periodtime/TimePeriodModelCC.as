package platform.client.models.commons.periodtime
{
   public class TimePeriodModelCC
   {
      
      private var _isEnabled:Boolean;
      
      private var _isTimeless:Boolean;
      
      private var _timeLeftInSeconds:int;
      
      private var _timeToStartInSeconds:int;
      
      public function TimePeriodModelCC(param1:Boolean = false, param2:Boolean = false, param3:int = 0, param4:int = 0)
      {
         super();
         this._isEnabled = param1;
         this._isTimeless = param2;
         this._timeLeftInSeconds = param3;
         this._timeToStartInSeconds = param4;
      }
      
      public function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         this._isEnabled = param1;
      }
      
      public function get isTimeless() : Boolean
      {
         return this._isTimeless;
      }
      
      public function set isTimeless(param1:Boolean) : void
      {
         this._isTimeless = param1;
      }
      
      public function get timeLeftInSeconds() : int
      {
         return this._timeLeftInSeconds;
      }
      
      public function set timeLeftInSeconds(param1:int) : void
      {
         this._timeLeftInSeconds = param1;
      }
      
      public function get timeToStartInSeconds() : int
      {
         return this._timeToStartInSeconds;
      }
      
      public function set timeToStartInSeconds(param1:int) : void
      {
         this._timeToStartInSeconds = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TimePeriodModelCC [";
         _loc1_ += "isEnabled = " + this.isEnabled + " ";
         _loc1_ += "isTimeless = " + this.isTimeless + " ";
         _loc1_ += "timeLeftInSeconds = " + this.timeLeftInSeconds + " ";
         _loc1_ += "timeToStartInSeconds = " + this.timeToStartInSeconds + " ";
         return _loc1_ + "]";
      }
   }
}

