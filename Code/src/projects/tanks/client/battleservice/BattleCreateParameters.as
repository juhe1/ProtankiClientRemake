package projects.tanks.client.battleservice
{
   import projects.tanks.client.battleservice.model.map.params.MapTheme;
   import projects.tanks.client.battleservice.EquipmentConstraintsMode;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   
   public class BattleCreateParameters
   {
      private var newname_6678__END:Boolean;
      
      private var newname_3252__END:BattleMode;
      
      private var newname_3253__END:EquipmentConstraintsMode;
      
      private var newname_6679__END:Boolean;
      
      private var newname_3255__END:BattleLimits;
      
      private var newname_7602__END:String;
      
      private var newname_3257__END:int;
      
      private var newname_3259__END:String;
      
      private var newname_3258__END:Boolean;
      
      private var newname_3260__END:Boolean;
      
      private var newname_3261__END:Boolean;
      
      private var newname_3262__END:Range;
      
      private var newname_9844__END:Boolean;
      
      private var newname_3266__END:MapTheme;
      
      private var newname_3269__END:Boolean;
      
      private var newname_3270__END:Boolean;
      
      private var newname_9845__END:Boolean;
      
      private var newname_3271__END:Boolean;
      
      private var newname_3272__END:Boolean;
      
      private var newname_3273__END:Boolean;
      
      private var newname_3274__END:Boolean;
      
      private var newname_3275__END:Boolean;
      
      private var newname_3276__END:Boolean;
      
      private var newname_3277__END:Boolean;
      
      private var newname_3278__END:Boolean;
      
      private var newname_3279__END:Boolean;
      
      private var newname_3280__END:Boolean;
      
      private var newname_3281__END:Boolean;
      
      public function BattleCreateParameters(param1:Boolean = false, param2:BattleMode = null, param3:EquipmentConstraintsMode = null, param4:Boolean = false, param5:BattleLimits = null, param6:String = null, param7:int = 0, param8:String = null, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Range = null, param13:Boolean = false, param14:MapTheme = null, param15:Boolean = false, param16:Boolean = false, param17:Boolean = false, param18:Boolean = false, param19:Boolean = false, param20:Boolean = false, param21:Boolean = false, param22:Boolean = false, param23:Boolean = false, param24:Boolean = false, param25:Boolean = false, param26:Boolean = false, param27:Boolean = false, param28:Boolean = false)
      {
         super();
         this.newname_6678__END = param1;
         this.newname_3252__END = param2;
         this.newname_3253__END = param3;
         this.newname_6679__END = param4;
         this.newname_3255__END = param5;
         this.newname_7602__END = param6;
         this.newname_3257__END = param7;
         this.newname_3259__END = param8;
         this.newname_3258__END = param9;
         this.newname_3260__END = param10;
         this.newname_3261__END = param11;
         this.newname_3262__END = param12;
         this.newname_9844__END = param13;
         this.newname_3266__END = param14;
         this.newname_3269__END = param15;
         this.newname_3270__END = param16;
         this.newname_9845__END = param17;
         this.newname_3271__END = param18;
         this.newname_3272__END = param19;
         this.newname_3273__END = param20;
         this.newname_3274__END = param21;
         this.newname_3275__END = param22;
         this.newname_3276__END = param23;
         this.newname_3277__END = param24;
         this.newname_3278__END = param25;
         this.newname_3279__END = param26;
         this.newname_3280__END = param27;
         this.newname_3281__END = param28;
      }
      
      public function get autoBalance() : Boolean
      {
         return this.newname_6678__END;
      }
      
      public function set autoBalance(param1:Boolean) : void
      {
         this.newname_6678__END = param1;
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
      
      public function get friendlyFire() : Boolean
      {
         return this.newname_6679__END;
      }
      
      public function set friendlyFire(param1:Boolean) : void
      {
         this.newname_6679__END = param1;
      }
      
      public function get limits() : BattleLimits
      {
         return this.newname_3255__END;
      }
      
      public function set limits(param1:BattleLimits) : void
      {
         this.newname_3255__END = param1;
      }
      
      public function get mapId() : String
      {
         return this.newname_7602__END;
      }
      
      public function set mapId(param1:String) : void
      {
         this.newname_7602__END = param1;
      }
      
      public function get maxPeopleCount() : int
      {
         return this.newname_3257__END;
      }
      
      public function set maxPeopleCount(param1:int) : void
      {
         this.newname_3257__END = param1;
      }
      
      public function get name() : String
      {
         return this.newname_3259__END;
      }
      
      public function set name(param1:String) : void
      {
         this.newname_3259__END = param1;
      }
      
      public function get parkourMode() : Boolean
      {
         return this.newname_3258__END;
      }
      
      public function set parkourMode(param1:Boolean) : void
      {
         this.newname_3258__END = param1;
      }
      
      public function get privateBattle() : Boolean
      {
         return this.newname_3260__END;
      }
      
      public function set privateBattle(param1:Boolean) : void
      {
         this.newname_3260__END = param1;
      }
      
      public function get proBattle() : Boolean
      {
         return this.newname_3261__END;
      }
      
      public function set proBattle(param1:Boolean) : void
      {
         this.newname_3261__END = param1;
      }
      
      public function get rankRange() : Range
      {
         return this.newname_3262__END;
      }
      
      public function set rankRange(param1:Range) : void
      {
         this.newname_3262__END = param1;
      }
      
      public function get reArmorEnabled() : Boolean
      {
         return this.newname_9844__END;
      }
      
      public function set reArmorEnabled(param1:Boolean) : void
      {
         this.newname_9844__END = param1;
      }
      
      public function get theme() : MapTheme
      {
         return this.newname_3266__END;
      }
      
      public function set theme(param1:MapTheme) : void
      {
         this.newname_3266__END = param1;
      }
      
      public function get withoutBonuses() : Boolean
      {
         return this.newname_3269__END;
      }
      
      public function set withoutBonuses(param1:Boolean) : void
      {
         this.newname_3269__END = param1;
      }
      
      public function get withoutCrystals() : Boolean
      {
         return this.newname_3270__END;
      }
      
      public function set withoutCrystals(param1:Boolean) : void
      {
         this.newname_3270__END = param1;
      }
      
      public function get withoutDrones() : Boolean
      {
         return this.newname_9845__END;
      }
      
      public function set withoutDrones(param1:Boolean) : void
      {
         this.newname_9845__END = param1;
      }
      
      public function get withoutSupplies() : Boolean
      {
         return this.newname_3271__END;
      }
      
      public function set withoutSupplies(param1:Boolean) : void
      {
         this.newname_3271__END = param1;
      }
      
      public function get withoutUpgrades() : Boolean
      {
         return this.newname_3272__END;
      }
      
      public function set withoutUpgrades(param1:Boolean) : void
      {
         this.newname_3272__END = param1;
      }
      
      public function get reducedResistances() : Boolean
      {
         return this.newname_3273__END;
      }
      
      public function set reducedResistances(param1:Boolean) : void
      {
         this.newname_3273__END = param1;
      }
      
      public function get esportDropTiming() : Boolean
      {
         return this.newname_3274__END;
      }
      
      public function set esportDropTiming(param1:Boolean) : void
      {
         this.newname_3274__END = param1;
      }
      
      public function get withoutGoldBoxes() : Boolean
      {
         return this.newname_3275__END;
      }
      
      public function set withoutGoldBoxes(param1:Boolean) : void
      {
         this.newname_3275__END = param1;
      }
      
      public function get withoutGoldSiren() : Boolean
      {
         return this.newname_3276__END;
      }
      
      public function set withoutGoldSiren(param1:Boolean) : void
      {
         this.newname_3276__END = param1;
      }
      
      public function get withoutGoldZone() : Boolean
      {
         return this.newname_3277__END;
      }
      
      public function set withoutGoldZone(param1:Boolean) : void
      {
         this.newname_3277__END = param1;
      }
      
      public function get randomGold() : Boolean
      {
         return this.newname_3278__END;
      }
      
      public function set randomGold(param1:Boolean) : void
      {
         this.newname_3278__END = param1;
      }
      
      public function get withoutMedkit() : Boolean
      {
         return this.newname_3279__END;
      }
      
      public function set withoutMedkit(param1:Boolean) : void
      {
         this.newname_3279__END = param1;
      }
      
      public function get withoutMines() : Boolean
      {
         return this.newname_3280__END;
      }
      
      public function set withoutMines(param1:Boolean) : void
      {
         this.newname_3280__END = param1;
      }
      
      public function get dependentCooldownEnabled() : Boolean
      {
         return this.newname_3281__END;
      }
      
      public function set dependentCooldownEnabled(param1:Boolean) : void
      {
         this.newname_3281__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleCreateParameters [";
         _loc1_ += "autoBalance = " + this.newname_6678__END + " ";
         _loc1_ += "battleMode = " + this.newname_3252__END + " ";
         _loc1_ += "equipmentConstraintsMode = " + this.newname_3253__END + " ";
         _loc1_ += "friendlyFire = " + this.newname_6679__END + " ";
         _loc1_ += "limits = " + this.newname_3255__END + " ";
         _loc1_ += "mapId = " + this.newname_7602__END + " ";
         _loc1_ += "maxPeopleCount = " + this.newname_3257__END + " ";
         _loc1_ += "name = " + this.newname_3259__END + " ";
         _loc1_ += "parkourMode = " + this.newname_3258__END + " ";
         _loc1_ += "privateBattle = " + this.newname_3260__END + " ";
         _loc1_ += "proBattle = " + this.newname_3261__END + " ";
         _loc1_ += "rankRange = " + this.newname_3262__END + " ";
         _loc1_ += "reArmorEnabled = " + this.newname_9844__END + " ";
         _loc1_ += "theme = " + this.newname_3266__END + " ";
         _loc1_ += "withoutBonuses = " + this.newname_3269__END + " ";
         _loc1_ += "withoutCrystals = " + this.newname_3270__END + " ";
         _loc1_ += "withoutDrones = " + this.newname_9845__END + " ";
         _loc1_ += "withoutSupplies = " + this.newname_3271__END + " ";
         _loc1_ += "withoutUpgrades = " + this.newname_3272__END + " ";
         _loc1_ += "reducedResistances = " + this.newname_3273__END + " ";
         _loc1_ += "esportDropTiming = " + this.newname_3274__END + " ";
         _loc1_ += "withoutGoldBoxes = " + this.newname_3275__END + " ";
         _loc1_ += "withoutGoldSiren = " + this.newname_3276__END + " ";
         _loc1_ += "withoutGoldZone = " + this.newname_3277__END + " ";
         _loc1_ += "randomGold = " + this.newname_3278__END + " ";
         _loc1_ += "withoutMedkit = " + this.newname_3279__END + " ";
         _loc1_ += "withoutMines = " + this.newname_3280__END + " ";
         _loc1_ += "dependentCooldownEnabled = " + this.newname_3281__END + " ";
         return _loc1_ + "]";
      }
   }
}

