package alternativa.tanks.models.weapon.artillery.turretcontroller
{
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.battle.objects.tank.controllers.targetingstates.MouseTargetingState;
   
   public class ArtilleryLocalTurretController extends LocalTurretController
   {
      
      public function ArtilleryLocalTurretController(param1:TurretController)
      {
         super(param1);
      }
      
      override protected function createMouseTargetingState(param1:TurretController) : MouseTargetingState
      {
         return new ArtilleryMouseTargetingState(param1);
      }
   }
}

