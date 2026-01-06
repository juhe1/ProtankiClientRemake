package alternativa.tanks.models.weapon.shaft.states.transitionhandlers
{
   import alternativa.tanks.models.weapon.shaft.IShaftWeapon;
   import alternativa.tanks.models.weapon.shaft.states.ITransitionHandler;
   
   public class QuickShotHandler implements ITransitionHandler
   {
      
      private var weapon:IShaftWeapon;
      
      public function QuickShotHandler(param1:IShaftWeapon)
      {
         super();
         this.weapon = param1;
      }
      
      public function execute(param1:*) : void
      {
         this.weapon.performQuickShot(-1);
      }
   }
}

