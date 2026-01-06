package alternativa.tanks.models.weapon.shaft.states
{
   import alternativa.tanks.models.weapon.shaft.IShaftWeapon;
   import alternativa.tanks.models.weapon.shaft.ShaftEnergyMode;
   import alternativa.tanks.models.weapon.shaft.ShaftEventType;
   
   public class IdleState implements IShaftState
   {
      
      private var weapon:IShaftWeapon;
      
      private var triggerPulled:Boolean;
      
      public function IdleState(param1:IShaftWeapon)
      {
         super();
         this.weapon = param1;
      }
      
      public function enter(param1:int) : void
      {
         this.triggerPulled = this.weapon.isTriggerPulled();
         this.weapon.setEnergyMode(ShaftEnergyMode.RECHARGE);
      }
      
      public function update(param1:int, param2:int) : void
      {
         if(this.triggerPulled)
         {
            this.readyToShoot();
         }
      }
      
      public function exit() : void
      {
      }
      
      public function processEvent(param1:ShaftEventType, param2:*) : void
      {
         switch(param1)
         {
            case ShaftEventType.TRIGGER_PULL:
               this.onTiggerPull();
               break;
            case ShaftEventType.TRIGGER_RELEASE:
               this.onTiggerRelease();
         }
      }
      
      private function onTiggerPull() : void
      {
         if(!this.triggerPulled)
         {
            this.triggerPulled = true;
            this.readyToShoot();
         }
      }
      
      private function onTiggerRelease() : void
      {
         this.triggerPulled = false;
      }
      
      private function readyToShoot() : void
      {
         if(this.weapon.canShoot())
         {
            this.weapon.processEvent(ShaftEventType.READY_TO_SHOOT);
            this.triggerPulled = false;
         }
      }
   }
}

