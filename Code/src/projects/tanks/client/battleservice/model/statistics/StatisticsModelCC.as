package projects.tanks.client.battleservice.model.statistics
{
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import projects.tanks.client.battleservice.EquipmentConstraintsMode;
   
   public class StatisticsModelCC
   {
      private var newname_3252__END:BattleMode;
      
      private var newname_3253__END:EquipmentConstraintsMode;
      
      private var newname_11730__END:int;
      
      private var newname_3255__END:BattleLimits;
      
      private var newname_6975__END:String;
      
      private var newname_11731__END:Boolean;
      
      private var newname_3257__END:int;
      
      private var newname_11732__END:String;
      
      private var newname_11733__END:int;
      
      private var newname_3258__END:Boolean;
      
      private var newname_11734__END:int;
      
      private var newname_3265__END:Boolean;
      
      private var newname_11735__END:Vector.<String>;
      
      private var newname_11736__END:int;
      
      private var newname_11737__END:Boolean;
      
      public function StatisticsModelCC(param1:BattleMode = null, param2:EquipmentConstraintsMode = null, param3:int = 0, param4:BattleLimits = null, param5:String = null, param6:Boolean = false, param7:int = 0, param8:String = null, param9:int = 0, param10:Boolean = false, param11:int = 0, param12:Boolean = false, param13:Vector.<String> = null, param14:int = 0, param15:Boolean = false)
      {
         super();
         this.newname_3252__END = param1;
         this.newname_3253__END = param2;
         this.newname_11730__END = param3;
         this.newname_3255__END = param4;
         this.newname_6975__END = param5;
         this.newname_11731__END = param6;
         this.newname_3257__END = param7;
         this.newname_11732__END = param8;
         this.newname_11733__END = param9;
         this.newname_3258__END = param10;
         this.newname_11734__END = param11;
         this.newname_3265__END = param12;
         this.newname_11735__END = param13;
         this.newname_11736__END = param14;
         this.newname_11737__END = param15;
      }
      
      public function get battleMode() : BattleMode
      {
         return this.newname_3252__END;
      }
      
      public function set battleMode(param1:BattleMode) : void
      {
         this.newname_3252__END = param1;
      }
      
      public function get equipmentConstraintsMode() : EquipmentConstraintsMode
      {
         return this.newname_3253__END;
      }
      
      public function set equipmentConstraintsMode(param1:EquipmentConstraintsMode) : void
      {
         this.newname_3253__END = param1;
      }
      
      public function get fund() : int
      {
         return this.newname_11730__END;
      }
      
      public function set fund(param1:int) : void
      {
         this.newname_11730__END = param1;
      }
      
      public function get limits() : BattleLimits
      {
         return this.newname_3255__END;
      }
      
      public function set limits(param1:BattleLimits) : void
      {
         this.newname_3255__END = param1;
      }
      
      public function get mapName() : String
      {
         return this.newname_6975__END;
      }
      
      public function set mapName(param1:String) : void
      {
         this.newname_6975__END = param1;
      }
      
      public function get matchBattle() : Boolean
      {
         return this.newname_11731__END;
      }
      
      public function set matchBattle(param1:Boolean) : void
      {
         this.newname_11731__END = param1;
      }
      
      public function get maxPeopleCount() : int
      {
         return this.newname_3257__END;
      }
      
      public function set maxPeopleCount(param1:int) : void
      {
         this.newname_3257__END = param1;
      }
      
      public function get modeName() : String
      {
         return this.newname_11732__END;
      }
      
      public function set modeName(param1:String) : void
      {
         this.newname_11732__END = param1;
      }
      
      public function get newbiesAbonementBonusInPercent() : int
      {
         return this.newname_11733__END;
      }
      
      public function set newbiesAbonementBonusInPercent(param1:int) : void
      {
         this.newname_11733__END = param1;
      }
      
      public function get parkourMode() : Boolean
      {
         return this.newname_3258__END;
      }
      
      public function set parkourMode(param1:Boolean) : void
      {
         this.newname_3258__END = param1;
      }
      
      public function get premiumBonusInPercent() : int
      {
         return this.newname_11734__END;
      }
      
      public function set premiumBonusInPercent(param1:int) : void
      {
         this.newname_11734__END = param1;
      }
      
      public function get spectator() : Boolean
      {
         return this.newname_3265__END;
      }
      
      public function set spectator(param1:Boolean) : void
      {
         this.newname_3265__END = param1;
      }
      
      public function get suspiciousUserIds() : Vector.<String>
      {
         return this.newname_11735__END;
      }
      
      public function set suspiciousUserIds(param1:Vector.<String>) : void
      {
         this.newname_11735__END = param1;
      }
      
      public function get timeLeft() : int
      {
         return this.newname_11736__END;
      }
      
      public function set timeLeft(param1:int) : void
      {
         this.newname_11736__END = param1;
      }
      
      public function get valuableRound() : Boolean
      {
         return this.newname_11737__END;
      }
      
      public function set valuableRound(param1:Boolean) : void
      {
         this.newname_11737__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "StatisticsModelCC [";
         _loc1_ += "battleMode = " + this.newname_3252__END + " ";
         _loc1_ += "equipmentConstraintsMode = " + this.newname_3253__END + " ";
         _loc1_ += "fund = " + this.newname_11730__END + " ";
         _loc1_ += "limits = " + this.newname_3255__END + " ";
         _loc1_ += "mapName = " + this.newname_6975__END + " ";
         _loc1_ += "matchBattle = " + this.newname_11731__END + " ";
         _loc1_ += "maxPeopleCount = " + this.newname_3257__END + " ";
         _loc1_ += "modeName = " + this.newname_11732__END + " ";
         _loc1_ += "newbiesAbonementBonusInPercent = " + this.newname_11733__END + " ";
         _loc1_ += "parkourMode = " + this.newname_3258__END + " ";
         _loc1_ += "premiumBonusInPercent = " + this.newname_11734__END + " ";
         _loc1_ += "spectator = " + this.newname_3265__END + " ";
         _loc1_ += "suspiciousUserIds = " + this.newname_11735__END + " ";
         _loc1_ += "timeLeft = " + this.newname_11736__END + " ";
         _loc1_ += "valuableRound = " + this.newname_11737__END + " ";
         return _loc1_ + "]";
      }
   }
}

