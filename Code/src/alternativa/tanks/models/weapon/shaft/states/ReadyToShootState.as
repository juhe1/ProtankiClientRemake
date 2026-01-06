package alternativa.tanks.models.weapon.shaft.states
{
   import alternativa.tanks.models.weapon.shaft.IShaftWeapon;
   import alternativa.tanks.models.weapon.shaft.ShaftEventType;
   
   public class ReadyToShootState implements IShaftState
   {
      
      private var weapon:IShaftWeapon;
      
      private var timeThreshold:int;
      
      private var switchTime:int;
      
      public function ReadyToShootState(param1:IShaftWeapon, param2:int)
      {
         super();
         this.weapon = param1;
         this.timeThreshold = param2;
      }
      
      public function enter(param1:int) : void
      {
         this.switchTime = param1 + this.timeThreshold;
      }
      
      public function update(param1:int, param2:int) : void
      {
         if(this.weapon.hasIntersection())
         {
            this.weapon.processEvent(ShaftEventType.STOP);
         }
         else if(param1 >= this.switchTime && this.weapon.getEnergy(param1) == this.weapon.getMaxEnergy())
         {
            this.weapon.processEvent(ShaftEventType.SWITCH);
         }
      }
      
      public function exit() : void
      {
      }
      
      public function processEvent(param1:ShaftEventType, param2:*) : void
      {
         switch(param1)
         {
            case ShaftEventType.TRIGGER_RELEASE:
               this.weapon.processEvent(ShaftEventType.TRIGGER_RELEASE);
         }
      }
   }
}

