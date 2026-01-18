package alternativa.tanks.models.tank.speedcharacteristics
{
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.LocalTankParams;
   import projects.tanks.client.battlefield.models.user.speedcharacteristics.ISpeedCharacteristicsModelBase;
   import projects.tanks.client.battlefield.models.user.speedcharacteristics.SpeedCharacteristicsModelBase;
   
   [ModelInfo]
   public class SpeedCharacteristicsModel extends SpeedCharacteristicsModelBase implements ISpeedCharacteristicsModelBase, SpeedCharacteristics
   {
      
      public function SpeedCharacteristicsModel()
      {
         super();
      }
      
      public function getMaxTurretTurnSpeed() : Number
      {
         var _loc1_:CurrentSpeedValues = this.getCurrentValues();
         return _loc1_.turretRotationSpeed;
      }
      
      public function getMaxHullTurnSpeed() : Number
      {
         var _loc1_:CurrentSpeedValues = this.getCurrentValues();
         return _loc1_.turnSpeed;
      }
      
      public function getTurretRotationCoefficient() : Number
      {
         var _loc1_:CurrentSpeedValues = this.getCurrentValues();
         if(getInitParam().baseTurretRotationSpeed == 0)
         {
            return 0;
         }
         return _loc1_.turretRotationSpeed / getInitParam().baseTurretRotationSpeed;
      }
      
      public function setInitialTankState() : void
      {
         var _loc1_:ITankModel = ITankModel(object.adapt(ITankModel));
         var _loc2_:Tank = _loc1_.getTank();
         _loc2_.setReverseAcceleration(BattleUtils.toClientScale(getInitParam().reverseAcceleration));
         _loc2_.setSideAcceleration(BattleUtils.toClientScale(getInitParam().sideAcceleration));
         _loc2_.setTurnAcceleration(getInitParam().turnAcceleration);
         _loc2_.setReverseTurnAcceleration(getInitParam().reverseTurnAcceleration);
         this.setTankSpec(_loc1_,getInitParam().currentSpeed,getInitParam().currentTurnSpeed,getInitParam().currentTurretRotationSpeed,getInitParam().currentAcceleration,true);
      }
      
      [Obfuscation(rename="false")]
      public function setSpecification(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : void
      {
         var _loc6_:ITankModel = ITankModel(object.adapt(ITankModel));
         this.setTankSpec(_loc6_,param1,param2,param3,param4,false);
         if(_loc6_.isLocal())
         {
            LocalTankParams.setSpecificationId(param5);
         }
      }
      
      private function setTankSpec(param1:ITankModel, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean) : void
      {
         var _loc7_:CurrentSpeedValues = new CurrentSpeedValues();
         _loc7_.speed = param2;
         _loc7_.turnSpeed = param3;
         _loc7_.turretRotationSpeed = param4;
         _loc7_.acceleration = param5;
         putData(CurrentSpeedValues,_loc7_);
         var _loc8_:Tank = param1.getTank();
         _loc8_.setMaxSpeed(BattleUtils.toClientScale(param2),param6);
         _loc8_.setMaxTurnSpeed(param3,param6);
         _loc8_.setAcceleration(BattleUtils.toClientScale(param5));
         param1.getTurretController().setMaxTurnSpeed(param4,param6);
      }
      
      private function getCurrentValues() : CurrentSpeedValues
      {
         return CurrentSpeedValues(getData(CurrentSpeedValues));
      }
   }
}

class CurrentSpeedValues
{
   
   public var speed:Number;
   
   public var turnSpeed:Number;
   
   public var turretRotationSpeed:Number;
   
   public var acceleration:Number;
   
   public function CurrentSpeedValues()
   {
      super();
   }
}
