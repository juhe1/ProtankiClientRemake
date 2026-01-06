package projects.tanks.client.battlefield.models.battle.battlefield.types
{
   public class HitTraceData
   {
      
      private var _armorPreEffectDamage:Number;
      
      private var _colorResistDamage:Number;
      
      private var _hullResistDamage:Number;
      
      private var _killerTurretName:String;
      
      private var _origDamage:Number;
      
      private var _postHealth:Number;
      
      private var _targetHealth:Number;
      
      private var _targetHullName:String;
      
      private var _weaponEffectsDamage:Number;
      
      public function HitTraceData(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:String = null, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:String = null, param9:Number = 0)
      {
         super();
         this._armorPreEffectDamage = param1;
         this._colorResistDamage = param2;
         this._hullResistDamage = param3;
         this._killerTurretName = param4;
         this._origDamage = param5;
         this._postHealth = param6;
         this._targetHealth = param7;
         this._targetHullName = param8;
         this._weaponEffectsDamage = param9;
      }
      
      public function get armorPreEffectDamage() : Number
      {
         return this._armorPreEffectDamage;
      }
      
      public function set armorPreEffectDamage(param1:Number) : void
      {
         this._armorPreEffectDamage = param1;
      }
      
      public function get colorResistDamage() : Number
      {
         return this._colorResistDamage;
      }
      
      public function set colorResistDamage(param1:Number) : void
      {
         this._colorResistDamage = param1;
      }
      
      public function get hullResistDamage() : Number
      {
         return this._hullResistDamage;
      }
      
      public function set hullResistDamage(param1:Number) : void
      {
         this._hullResistDamage = param1;
      }
      
      public function get killerTurretName() : String
      {
         return this._killerTurretName;
      }
      
      public function set killerTurretName(param1:String) : void
      {
         this._killerTurretName = param1;
      }
      
      public function get origDamage() : Number
      {
         return this._origDamage;
      }
      
      public function set origDamage(param1:Number) : void
      {
         this._origDamage = param1;
      }
      
      public function get postHealth() : Number
      {
         return this._postHealth;
      }
      
      public function set postHealth(param1:Number) : void
      {
         this._postHealth = param1;
      }
      
      public function get targetHealth() : Number
      {
         return this._targetHealth;
      }
      
      public function set targetHealth(param1:Number) : void
      {
         this._targetHealth = param1;
      }
      
      public function get targetHullName() : String
      {
         return this._targetHullName;
      }
      
      public function set targetHullName(param1:String) : void
      {
         this._targetHullName = param1;
      }
      
      public function get weaponEffectsDamage() : Number
      {
         return this._weaponEffectsDamage;
      }
      
      public function set weaponEffectsDamage(param1:Number) : void
      {
         this._weaponEffectsDamage = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "HitTraceData [";
         _loc1_ += "armorPreEffectDamage = " + this.armorPreEffectDamage + " ";
         _loc1_ += "colorResistDamage = " + this.colorResistDamage + " ";
         _loc1_ += "hullResistDamage = " + this.hullResistDamage + " ";
         _loc1_ += "killerTurretName = " + this.killerTurretName + " ";
         _loc1_ += "origDamage = " + this.origDamage + " ";
         _loc1_ += "postHealth = " + this.postHealth + " ";
         _loc1_ += "targetHealth = " + this.targetHealth + " ";
         _loc1_ += "targetHullName = " + this.targetHullName + " ";
         _loc1_ += "weaponEffectsDamage = " + this.weaponEffectsDamage + " ";
         return _loc1_ + "]";
      }
   }
}

