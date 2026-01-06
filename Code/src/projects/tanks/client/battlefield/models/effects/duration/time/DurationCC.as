package projects.tanks.client.battlefield.models.effects.duration.time
{
   public class DurationCC
   {
      
      private var _durationTimeInMs:int;
      
      private var _infinite:Boolean;
      
      public function DurationCC(param1:int = 0, param2:Boolean = false)
      {
         super();
         this._durationTimeInMs = param1;
         this._infinite = param2;
      }
      
      public function get durationTimeInMs() : int
      {
         return this._durationTimeInMs;
      }
      
      public function set durationTimeInMs(param1:int) : void
      {
         this._durationTimeInMs = param1;
      }
      
      public function get infinite() : Boolean
      {
         return this._infinite;
      }
      
      public function set infinite(param1:Boolean) : void
      {
         this._infinite = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DurationCC [";
         _loc1_ += "durationTimeInMs = " + this.durationTimeInMs + " ";
         _loc1_ += "infinite = " + this.infinite + " ";
         return _loc1_ + "]";
      }
   }
}

