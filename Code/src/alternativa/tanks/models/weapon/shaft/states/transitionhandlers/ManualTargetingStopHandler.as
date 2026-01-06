package alternativa.tanks.models.weapon.shaft.states.transitionhandlers
{
   import alternativa.tanks.models.weapon.shaft.IShaftWeapon;
   import alternativa.tanks.models.weapon.shaft.states.ITransitionHandler;
   
   public class ManualTargetingStopHandler implements ITransitionHandler
   {
      
      private var weapon:IShaftWeapon;
      
      public function ManualTargetingStopHandler(param1:IShaftWeapon)
      {
         super();
         this.weapon = param1;
      }
      
      public function execute(param1:*) : void
      {
         if(param1)
         {
            this.weapon.onTargetingModeStop();
         }
      }
   }
}

