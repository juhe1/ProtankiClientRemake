package projects.tanks.client.battlefield.models.battle.jgr.killstreak
{
   public class KillStreakCC
   {
      
      private var _items:Vector.<KillStreakItem>;
      
      public function KillStreakCC(param1:Vector.<KillStreakItem> = null)
      {
         super();
         this._items = param1;
      }
      
      public function get items() : Vector.<KillStreakItem>
      {
         return this._items;
      }
      
      public function set items(param1:Vector.<KillStreakItem>) : void
      {
         this._items = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "KillStreakCC [";
         _loc1_ += "items = " + this.items + " ";
         return _loc1_ + "]";
      }
   }
}

