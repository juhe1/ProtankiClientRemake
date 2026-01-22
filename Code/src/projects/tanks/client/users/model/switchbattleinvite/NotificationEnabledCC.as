package projects.tanks.client.users.model.switchbattleinvite
{
   public class NotificationEnabledCC
   {
      
      private var _receiveBattleInvite:Boolean;
      
      public function NotificationEnabledCC(param1:Boolean = false)
      {
         super();
         this._receiveBattleInvite = param1;
      }
      
      public function get receiveBattleInvite() : Boolean
      {
         return this._receiveBattleInvite;
      }
      
      public function set receiveBattleInvite(param1:Boolean) : void
      {
         this._receiveBattleInvite = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "NotificationEnabledCC [";
         _loc1_ += "receiveBattleInvite = " + this.receiveBattleInvite + " ";
         return _loc1_ + "]";
      }
   }
}

