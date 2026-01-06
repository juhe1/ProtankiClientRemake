package projects.tanks.client.battlefield.models.tankparts.weapon.common
{
   import platform.client.fp10.core.resource.types.SoundResource;
   
   public class WeaponCommonCC
   {
      
      private var _highlightingDistance:Number;
      
      private var _impactForce:Number;
      
      private var _kickback:Number;
      
      private var _turretRotationAcceleration:Number;
      
      private var _turretRotationSound:SoundResource;
      
      private var _turretRotationSpeed:Number;
      
      public function WeaponCommonCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:SoundResource = null, param6:Number = 0)
      {
         super();
         this._highlightingDistance = param1;
         this._impactForce = param2;
         this._kickback = param3;
         this._turretRotationAcceleration = param4;
         this._turretRotationSound = param5;
         this._turretRotationSpeed = param6;
      }
      
      public function get highlightingDistance() : Number
      {
         return this._highlightingDistance;
      }
      
      public function set highlightingDistance(param1:Number) : void
      {
         this._highlightingDistance = param1;
      }
      
      public function get impactForce() : Number
      {
         return this._impactForce;
      }
      
      public function set impactForce(param1:Number) : void
      {
         this._impactForce = param1;
      }
      
      public function get kickback() : Number
      {
         return this._kickback;
      }
      
      public function set kickback(param1:Number) : void
      {
         this._kickback = param1;
      }
      
      public function get turretRotationAcceleration() : Number
      {
         return this._turretRotationAcceleration;
      }
      
      public function set turretRotationAcceleration(param1:Number) : void
      {
         this._turretRotationAcceleration = param1;
      }
      
      public function get turretRotationSound() : SoundResource
      {
         return this._turretRotationSound;
      }
      
      public function set turretRotationSound(param1:SoundResource) : void
      {
         this._turretRotationSound = param1;
      }
      
      public function get turretRotationSpeed() : Number
      {
         return this._turretRotationSpeed;
      }
      
      public function set turretRotationSpeed(param1:Number) : void
      {
         this._turretRotationSpeed = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "WeaponCommonCC [";
         _loc1_ += "highlightingDistance = " + this.highlightingDistance + " ";
         _loc1_ += "impactForce = " + this.impactForce + " ";
         _loc1_ += "kickback = " + this.kickback + " ";
         _loc1_ += "turretRotationAcceleration = " + this.turretRotationAcceleration + " ";
         _loc1_ += "turretRotationSound = " + this.turretRotationSound + " ";
         _loc1_ += "turretRotationSpeed = " + this.turretRotationSpeed + " ";
         return _loc1_ + "]";
      }
   }
}

