package projects.tanks.client.panel.model.battleinvite
{
   import projects.tanks.client.battleservice.BattleMode;
   
   public class BattleInviteMessage
   {
      private var newname_10662__END:Boolean;
      
      private var newname_10663__END:Boolean;
      
      private var newname_3288__END:String;
      
      private var newname_8705__END:String;
      
      private var newname_6975__END:String;
      
      private var newname_6976__END:BattleMode;
      
      private var newname_3290__END:Boolean;
      
      private var newname_3260__END:Boolean;
      
      private var newname_6978__END:Boolean;
      
      private var newname_6979__END:int;
      
      private var newname_10664__END:String;
      
      public function BattleInviteMessage(param1:Boolean = false, param2:Boolean = false, param3:String = null, param4:String = null, param5:String = null, param6:BattleMode = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:int = 0, param11:String = null)
      {
         super();
         this.newname_10662__END = param1;
         this.newname_10663__END = param2;
         this.newname_3288__END = param3;
         this.newname_8705__END = param4;
         this.newname_6975__END = param5;
         this.newname_6976__END = param6;
         this.newname_3290__END = param7;
         this.newname_3260__END = param8;
         this.newname_6978__END = param9;
         this.newname_6979__END = param10;
         this.newname_10664__END = param11;
      }
      
      public function get availableRank() : Boolean
      {
         return this.newname_10662__END;
      }
      
      public function set availableRank(param1:Boolean) : void
      {
         this.newname_10662__END = param1;
      }
      
      public function get availableSlot() : Boolean
      {
         return this.newname_10663__END;
      }
      
      public function set availableSlot(param1:Boolean) : void
      {
         this.newname_10663__END = param1;
      }
      
      public function get battleId() : String
      {
         return this.newname_3288__END;
      }
      
      public function set battleId(param1:String) : void
      {
         this.newname_3288__END = param1;
      }
      
      public function get gameHost() : String
      {
         return this.newname_8705__END;
      }
      
      public function set gameHost(param1:String) : void
      {
         this.newname_8705__END = param1;
      }
      
      public function get mapName() : String
      {
         return this.newname_6975__END;
      }
      
      public function set mapName(param1:String) : void
      {
         this.newname_6975__END = param1;
      }
      
      public function get mode() : BattleMode
      {
         return this.newname_6976__END;
      }
      
      public function set mode(param1:BattleMode) : void
      {
         this.newname_6976__END = param1;
      }
      
      public function get noSuppliesBattle() : Boolean
      {
         return this.newname_3290__END;
      }
      
      public function set noSuppliesBattle(param1:Boolean) : void
      {
         this.newname_3290__END = param1;
      }
      
      public function get privateBattle() : Boolean
      {
         return this.newname_3260__END;
      }
      
      public function set privateBattle(param1:Boolean) : void
      {
         this.newname_3260__END = param1;
      }
      
      public function get remote() : Boolean
      {
         return this.newname_6978__END;
      }
      
      public function set remote(param1:Boolean) : void
      {
         this.newname_6978__END = param1;
      }
      
      public function get serverNumber() : int
      {
         return this.newname_6979__END;
      }
      
      public function set serverNumber(param1:int) : void
      {
         this.newname_6979__END = param1;
      }
      
      public function get url() : String
      {
         return this.newname_10664__END;
      }
      
      public function set url(param1:String) : void
      {
         this.newname_10664__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleInviteMessage [";
         _loc1_ += "availableRank = " + this.newname_10662__END + " ";
         _loc1_ += "availableSlot = " + this.newname_10663__END + " ";
         _loc1_ += "battleId = " + this.newname_3288__END + " ";
         _loc1_ += "gameHost = " + this.newname_8705__END + " ";
         _loc1_ += "mapName = " + this.newname_6975__END + " ";
         _loc1_ += "mode = " + this.newname_6976__END + " ";
         _loc1_ += "noSuppliesBattle = " + this.newname_3290__END + " ";
         _loc1_ += "privateBattle = " + this.newname_3260__END + " ";
         _loc1_ += "remote = " + this.newname_6978__END + " ";
         _loc1_ += "serverNumber = " + this.newname_6979__END + " ";
         _loc1_ += "url = " + this.newname_10664__END + " ";
         return _loc1_ + "]";
      }
   }
}

