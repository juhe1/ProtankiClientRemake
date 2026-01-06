package alternativa.tanks.models.weapon.artillery.rotation
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.tank.InitTankPart;
   import alternativa.tanks.models.weapon.turret.TurretStateSender;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.ArtilleryElevatingBarrelCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.ArtilleryElevatingBarrelModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.IArtilleryElevatingBarrelModelBase;
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   
   [ModelInfo]
   public class ArtilleryElevatingBarrelModel extends ArtilleryElevatingBarrelModelBase implements IArtilleryElevatingBarrelModelBase, ObjectLoadListener, InitTankPart, TurretStateSender
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      public function ArtilleryElevatingBarrelModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:ArtilleryElevatingBarrelCC = getInitParam();
         var _loc2_:RotateTurretCommand = new RotateTurretCommand(_loc1_.angle,_loc1_.control);
         this.saveState(_loc2_);
      }
      
      public function initTankPart(param1:Tank) : void
      {
         putData(Tank,param1);
      }
      
      public function sendTurretState() : void
      {
         var _loc1_:Tank = this.getTank();
         var _loc2_:TurretController = _loc1_.turretController;
         var _loc3_:RotateTurretCommand = this.getState();
         _loc3_.control = _loc2_.appliedControlState;
         _loc3_.angle = -_loc2_.getDirection();
         var _loc4_:int = int(battleService.getBattleRunner().getPhysicsTime());
         server.update(_loc4_,_loc1_.incarnation,_loc3_);
      }
      
      public function update(param1:RotateTurretCommand) : void
      {
         this.saveState(param1);
         var _loc2_:TurretController = this.getTank().turretController;
         _loc2_.setDirectionImmediate(-param1.angle);
         _loc2_.setControlState(param1.control);
      }
      
      private function getTank() : Tank
      {
         return Tank(getData(Tank));
      }
      
      private function saveState(param1:RotateTurretCommand) : void
      {
         putData(RotateTurretCommand,param1);
      }
      
      private function getState() : RotateTurretCommand
      {
         return RotateTurretCommand(getData(RotateTurretCommand));
      }
   }
}

