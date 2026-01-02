package projects.tanks.client.garage.models.item.temporary
{
   public class TemporaryItemCC
   {
      
      private var _infinityLifetimeItem:Boolean;
      
      private var _lifeTimeInSec:int;
      
      private var _remainingTimeInSec:int;
      
      public function TemporaryItemCC(param1:Boolean = false, param2:int = 0, param3:int = 0)
      {
         super();
         this._infinityLifetimeItem = param1;
         this._lifeTimeInSec = param2;
         this._remainingTimeInSec = param3;
      }
      
      public function get infinityLifetimeItem() : Boolean
      {
         return this._infinityLifetimeItem;
      }
      
      public function set infinityLifetimeItem(param1:Boolean) : void
      {
         this._infinityLifetimeItem = param1;
      }
      
      public function get lifeTimeInSec() : int
      {
         return this._lifeTimeInSec;
      }
      
      public function set lifeTimeInSec(param1:int) : void
      {
         this._lifeTimeInSec = param1;
      }
      
      public function get remainingTimeInSec() : int
      {
         return this._remainingTimeInSec;
      }
      
      public function set remainingTimeInSec(param1:int) : void
      {
         this._remainingTimeInSec = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TemporaryItemCC [";
         _loc1_ += "infinityLifetimeItem = " + this.infinityLifetimeItem + " ";
         _loc1_ += "lifeTimeInSec = " + this.lifeTimeInSec + " ";
         _loc1_ += "remainingTimeInSec = " + this.remainingTimeInSec + " ";
         return _loc1_ + "]";
      }
   }
}

