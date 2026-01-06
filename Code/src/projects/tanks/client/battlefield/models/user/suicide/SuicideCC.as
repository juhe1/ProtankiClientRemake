package projects.tanks.client.battlefield.models.user.suicide
{
   public class SuicideCC
   {
      
      private var _suicideDelayMS:int;
      
      public function SuicideCC(param1:int = 0)
      {
         super();
         this._suicideDelayMS = param1;
      }
      
      public function get suicideDelayMS() : int
      {
         return this._suicideDelayMS;
      }
      
      public function set suicideDelayMS(param1:int) : void
      {
         this._suicideDelayMS = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "SuicideCC [";
         _loc1_ += "suicideDelayMS = " + this.suicideDelayMS + " ";
         return _loc1_ + "]";
      }
   }
}

