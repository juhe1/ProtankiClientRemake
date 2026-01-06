package projects.tanks.client.battlefield.models.battle.jgr.killstreak
{
   import platform.client.fp10.core.resource.types.SoundResource;
   
   public class KillStreakItem
   {
      
      private var _count:int;
      
      private var _messageToBoss:String;
      
      private var _messageToVictims:String;
      
      private var _sound:SoundResource;
      
      public function KillStreakItem(param1:int = 0, param2:String = null, param3:String = null, param4:SoundResource = null)
      {
         super();
         this._count = param1;
         this._messageToBoss = param2;
         this._messageToVictims = param3;
         this._sound = param4;
      }
      
      public function get count() : int
      {
         return this._count;
      }
      
      public function set count(param1:int) : void
      {
         this._count = param1;
      }
      
      public function get messageToBoss() : String
      {
         return this._messageToBoss;
      }
      
      public function set messageToBoss(param1:String) : void
      {
         this._messageToBoss = param1;
      }
      
      public function get messageToVictims() : String
      {
         return this._messageToVictims;
      }
      
      public function set messageToVictims(param1:String) : void
      {
         this._messageToVictims = param1;
      }
      
      public function get sound() : SoundResource
      {
         return this._sound;
      }
      
      public function set sound(param1:SoundResource) : void
      {
         this._sound = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "KillStreakItem [";
         _loc1_ += "count = " + this.count + " ";
         _loc1_ += "messageToBoss = " + this.messageToBoss + " ";
         _loc1_ += "messageToVictims = " + this.messageToVictims + " ";
         _loc1_ += "sound = " + this.sound + " ";
         return _loc1_ + "]";
      }
   }
}

