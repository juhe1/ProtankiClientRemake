package alternativa.tanks.models.weapon.artillery.turretcontroller
{
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.battle.objects.tank.controllers.targetingstates.MouseTargetingState;
   
   public class ArtilleryMouseTargetingState extends MouseTargetingState
   {
      
      public function ArtilleryMouseTargetingState(param1:TurretController)
      {
         super(param1);
      }
      
      override protected function setTargetDirection() : void
      {
         turretController.setTargetDirection(turretController.getDirection());
      }
      
      override protected function getTurretZRotation() : Number
      {
         return 0;
      }
   }
}

