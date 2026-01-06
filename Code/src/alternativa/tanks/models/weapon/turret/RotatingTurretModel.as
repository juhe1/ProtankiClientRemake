package alternativa.tanks.models.weapon.turret
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.tank.InitTankPart;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.tankparts.weapon.turret.IRotatingTurretModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.turret.RotatingTurretCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.turret.RotatingTurretModelBase;
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   
   [ModelInfo]
   public class RotatingTurretModel extends RotatingTurretModelBase implements IRotatingTurretModelBase, ObjectLoadListener, InitTankPart, TurretStateSender
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      public function RotatingTurretModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:RotatingTurretCC = getInitParam();
         var _loc2_:RotateTurretCommand = new RotateTurretCommand(_loc1_.angle,_loc1_.control);
         this.saveState(_loc2_);
      }
      
      public function initTankPart(param1:Tank) : void
      {
         putData(Tank,param1);
      }
      
      public function rotate(param1:RotateTurretCommand) : void
      {
         this.saveState(param1);
         var _loc2_:TurretController = this.getTank().turretController;
         _loc2_.setDirectionImmediate(param1.angle);
         _loc2_.setControlState(param1.control);
      }
      
      public function sendTurretState() : void
      {
         var _loc1_:Tank = this.getTank();
         var _loc2_:TurretController = _loc1_.turretController;
         var _loc3_:RotateTurretCommand = this.getState();
         _loc3_.control = _loc2_.appliedControlState;
         _loc3_.angle = _loc2_.getDirection();
         var _loc4_:int = int(battleService.getBattleRunner().getPhysicsTime());
         server.rotate(_loc4_,_loc1_.incarnation,_loc3_);
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

