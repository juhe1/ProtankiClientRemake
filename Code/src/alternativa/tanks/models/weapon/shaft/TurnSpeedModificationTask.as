package alternativa.tanks.models.weapon.shaft
{
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
   
   public class TurnSpeedModificationTask extends BattleRunnerProvider implements LogicUnit
   {
      
      private var shaftCC:ShaftCC;
      
      private var time:int;
      
      private var killed:Boolean;
      
      private var turretController:TurretController;
      
      private var savedTurnAcceleration:Number;
      
      private var speedCharacteristic:SpeedCharacteristics;
      
      public function TurnSpeedModificationTask(param1:ShaftCC, param2:TurretController, param3:SpeedCharacteristics)
      {
         super();
         this.shaftCC = param1;
         this.turretController = param2;
         this.speedCharacteristic = param3;
         this.killed = false;
         this.time = 0;
      }
      
      public function start() : void
      {
         getBattleRunner().addLogicUnit(this);
         this.savedTurnAcceleration = this.turretController.getTurnAcceleration();
      }
      
      public function stop() : void
      {
         getBattleRunner().removeLogicUnit(this);
         this.killed = true;
         this.turretController.setMaxTurnSpeed(this.speedCharacteristic.getMaxTurretTurnSpeed(),true);
         this.turretController.setTurnAcceleration(this.savedTurnAcceleration);
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         if(!this.killed)
         {
            this.time += param2;
            _loc3_ = this.shaftCC.dischargeRate * (this.time + this.shaftCC.targetingTransitionTime) / 1000 / this.shaftCC.maxEnergy;
            if(_loc3_ > 1)
            {
               _loc3_ = 1;
            }
            this.turretController.setMaxTurnSpeed(this.getSpeedFactor(_loc3_) * this.shaftCC.horizontalTargetingSpeed * this.speedCharacteristic.getTurretRotationCoefficient(),false);
            this.turretController.setTurnAcceleration(this.shaftCC.targetingAcceleration);
         }
      }
      
      private function getSpeedFactor(param1:Number) : Number
      {
         var _loc2_:Number = this.shaftCC.rotationCoeffT1;
         if(param1 < _loc2_)
         {
            return 1;
         }
         var _loc3_:Number = this.shaftCC.rotationCoeffT2;
         var _loc4_:Number = this.shaftCC.rotationCoeffKmin;
         if(param1 < _loc3_)
         {
            return 1 - (1 - _loc4_) * (param1 - _loc2_) / (_loc3_ - _loc2_);
         }
         return _loc4_;
      }
   }
}

