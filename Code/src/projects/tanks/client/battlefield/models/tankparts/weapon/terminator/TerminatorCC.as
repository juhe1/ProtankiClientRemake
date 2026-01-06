package projects.tanks.client.battlefield.models.tankparts.weapon.terminator
{
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
   
   public class TerminatorCC
   {
      
      private var _primaryCC:RailgunCC;
      
      private var _secondaryCC:RocketLauncherCC;
      
      private var _secondaryKickback:Number;
      
      public function TerminatorCC(param1:RailgunCC = null, param2:RocketLauncherCC = null, param3:Number = 0)
      {
         super();
         this._primaryCC = param1;
         this._secondaryCC = param2;
         this._secondaryKickback = param3;
      }
      
      public function get primaryCC() : RailgunCC
      {
         return this._primaryCC;
      }
      
      public function set primaryCC(param1:RailgunCC) : void
      {
         this._primaryCC = param1;
      }
      
      public function get secondaryCC() : RocketLauncherCC
      {
         return this._secondaryCC;
      }
      
      public function set secondaryCC(param1:RocketLauncherCC) : void
      {
         this._secondaryCC = param1;
      }
      
      public function get secondaryKickback() : Number
      {
         return this._secondaryKickback;
      }
      
      public function set secondaryKickback(param1:Number) : void
      {
         this._secondaryKickback = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TerminatorCC [";
         _loc1_ += "primaryCC = " + this.primaryCC + " ";
         _loc1_ += "secondaryCC = " + this.secondaryCC + " ";
         _loc1_ += "secondaryKickback = " + this.secondaryKickback + " ";
         return _loc1_ + "]";
      }
   }
}

