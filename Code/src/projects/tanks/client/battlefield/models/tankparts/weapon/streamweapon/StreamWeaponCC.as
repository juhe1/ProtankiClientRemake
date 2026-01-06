package projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon
{
   public class StreamWeaponCC
   {
      
      private var _energyCapacity:Number;
      
      private var _energyDischargeSpeed:Number;
      
      private var _energyRechargeSpeed:Number;
      
      private var _weaponTickIntervalMsec:Number;
      
      public function StreamWeaponCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         super();
         this._energyCapacity = param1;
         this._energyDischargeSpeed = param2;
         this._energyRechargeSpeed = param3;
         this._weaponTickIntervalMsec = param4;
      }
      
      public function get energyCapacity() : Number
      {
         return this._energyCapacity;
      }
      
      public function set energyCapacity(param1:Number) : void
      {
         this._energyCapacity = param1;
      }
      
      public function get energyDischargeSpeed() : Number
      {
         return this._energyDischargeSpeed;
      }
      
      public function set energyDischargeSpeed(param1:Number) : void
      {
         this._energyDischargeSpeed = param1;
      }
      
      public function get energyRechargeSpeed() : Number
      {
         return this._energyRechargeSpeed;
      }
      
      public function set energyRechargeSpeed(param1:Number) : void
      {
         this._energyRechargeSpeed = param1;
      }
      
      public function get weaponTickIntervalMsec() : Number
      {
         return this._weaponTickIntervalMsec;
      }
      
      public function set weaponTickIntervalMsec(param1:Number) : void
      {
         this._weaponTickIntervalMsec = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "StreamWeaponCC [";
         _loc1_ += "energyCapacity = " + this.energyCapacity + " ";
         _loc1_ += "energyDischargeSpeed = " + this.energyDischargeSpeed + " ";
         _loc1_ += "energyRechargeSpeed = " + this.energyRechargeSpeed + " ";
         _loc1_ += "weaponTickIntervalMsec = " + this.weaponTickIntervalMsec + " ";
         return _loc1_ + "]";
      }
   }
}

