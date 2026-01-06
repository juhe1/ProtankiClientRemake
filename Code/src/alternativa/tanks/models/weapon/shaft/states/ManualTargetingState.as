package alternativa.tanks.models.weapon.shaft.states
{
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.objects.tank.controllers.LocalShaftController;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
   import alternativa.tanks.models.weapon.shaft.IShaftWeapon;
   import alternativa.tanks.models.weapon.shaft.LinearInterpolator;
   import alternativa.tanks.models.weapon.shaft.ShaftEffects;
   import alternativa.tanks.models.weapon.shaft.ShaftEnergyMode;
   import alternativa.tanks.models.weapon.shaft.ShaftEventType;
   import alternativa.tanks.models.weapon.shaft.cameracontrollers.TargetingCameraController;
   import alternativa.tanks.services.targeting.TargetingModeService;
   import alternativa.tanks.utils.MathUtils;
   import flash.events.FullScreenEvent;
   import flash.utils.getTimer;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
   
   public class ManualTargetingState implements IShaftState
   {
      
      [Inject]
      public static var targetingModeService:TargetingModeService;
      
      [Inject]
      public static var display:IDisplay;
      
      private static const MAX_SPOT_SCALE:Number = 8;
      
      private static const MIN_SPOT_SCALE:Number = 1;
      
      private static const MAX_SPOT_DISTANCE:Number = 5000;
      
      private static const MIN_SPOT_DISTANCE:Number = 50;
      
      private static const SPOT_SCALE_DISTANCE:Number = MAX_SPOT_DISTANCE - MIN_SPOT_DISTANCE;
      
      private static const SPOT_SCALE:Number = MAX_SPOT_SCALE - MIN_SPOT_SCALE;
      
      private static var aimDirection:Vector3 = new Vector3();
      
      private static var targetPoint:ShaftTargetPoint = new ShaftTargetPoint();
      
      private static var cameraPosition:Vector3 = new Vector3();
      
      private var context:ManualTargetingContext;
      
      private var weapon:IShaftWeapon;
      
      private var up:Boolean;
      
      private var down:Boolean;
      
      private var cameraController:TargetingCameraController;
      
      private var shaft2Data:ShaftCC;
      
      private var fovInterpolator:LinearInterpolator = new LinearInterpolator();
      
      private var rangeInterpolator:LinearInterpolator = new LinearInterpolator();
      
      private var exitTime:int;
      
      private var fired:Boolean;
      
      private var chargingEffectActive:Boolean;
      
      private var turretController:LocalShaftController;
      
      private var effects:ShaftEffects;
      
      private var savedTurnAcceleration:Number;
      
      private var speedCharacteristics:SpeedCharacteristics;
      
      public function ManualTargetingState(param1:ManualTargetingContext, param2:IShaftWeapon, param3:TargetingCameraController, param4:ShaftCC, param5:LocalShaftController, param6:ShaftEffects, param7:SpeedCharacteristics)
      {
         super();
         this.context = param1;
         this.weapon = param2;
         this.cameraController = param3;
         this.shaft2Data = param4;
         this.turretController = param5;
         this.effects = param6;
         this.speedCharacteristics = param7;
         this.fovInterpolator.setInterval(param4.initialFOV,param4.minimumFOV);
         this.rangeInterpolator.setInterval(param4.shrubsHidingRadiusMin,param4.shrubsHidingRadiusMax);
      }
      
      public function enter(param1:int) : void
      {
         this.savedTurnAcceleration = TurretController(this.turretController.getTurretController()).getTurnAcceleration();
         TurretController(this.turretController.getTurretController()).setTurnAcceleration(this.shaft2Data.targetingAcceleration);
         this.setTurretSpeedFactor(1);
         this.weapon.setEnergyMode(ShaftEnergyMode.DRAIN);
         this.weapon.startManualTargeting();
         this.up = MathUtils.getBitValue(TurretController(this.turretController.getTurretController()).getControl(),TurretController.BIT_UP) != 0;
         this.down = MathUtils.getBitValue(TurretController(this.turretController.getTurretController()).getControl(),TurretController.BIT_DOWN) != 0;
         this.exitTime = -1;
         this.fired = false;
         this.chargingEffectActive = true;
         this.turretController.startAim();
         display.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
      }
      
      private function setTurretSpeedFactor(param1:Number) : void
      {
         TurretController(this.turretController.getTurretController()).setMaxTurnSpeed(param1 * this.shaft2Data.horizontalTargetingSpeed * this.speedCharacteristics.getTurretRotationCoefficient(),false);
         this.cameraController.setMaxElevationSpeedFactor(param1);
         this.turretController.recalculateSpeed(param1);
      }
      
      public function update(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         this.up = MathUtils.getBitValue(TurretController(this.turretController.getTurretController()).getControl(),TurretController.BIT_UP) != 0;
         this.down = MathUtils.getBitValue(TurretController(this.turretController.getTurretController()).getControl(),TurretController.BIT_DOWN) != 0;
         if(this.exitTime > 0)
         {
            if(param1 >= this.exitTime)
            {
               this.weapon.processEvent(ShaftEventType.EXIT);
            }
         }
         else if(this.weapon.hasIntersection())
         {
            this.weapon.processEvent(ShaftEventType.STOP,true);
         }
         else
         {
            _loc3_ = int(this.up) - int(this.down);
            this.cameraController.elevationDirection = _loc3_;
            this.effects.playTargetingSound(_loc3_ != 0 && !this.cameraController.isMaxElevation() || TurretController(this.turretController.getTurretController()).isRotating());
            _loc4_ = Number(this.weapon.getEnergy(param1));
            if(_loc4_ == 0 && this.chargingEffectActive)
            {
               this.chargingEffectActive = false;
               this.weapon.fadeChargingEffect();
            }
            _loc5_ = this.context.initialEnergy - _loc4_;
            _loc6_ = _loc5_ / this.weapon.getMaxEnergy();
            this.updateLaserPointer();
            this.cameraController.setCameraFov(this.fovInterpolator.interpolate(_loc6_));
            _loc7_ = this.getSpeedFactor(_loc6_);
            this.setTurretSpeedFactor(_loc7_);
            this.weapon.hideObjectsInRange(this.rangeInterpolator.interpolate(_loc6_));
         }
      }
      
      private function updateLaserPointer() : void
      {
         var _loc1_:Number = NaN;
         this.turretController.getAimDirection(aimDirection);
         this.cameraController.readCameraPosition(cameraPosition);
         if(this.weapon.calculateTargetPoint(aimDirection,targetPoint))
         {
            _loc1_ = Vector3.distanceBetween(cameraPosition,targetPoint.getGlobalPoint());
            this.weapon.setLaserPointerScale(this.calculateSpotScale(_loc1_));
         }
         else
         {
            this.weapon.setLaserPointerScale(MIN_SPOT_SCALE);
         }
         if(targetPoint.hasTank())
         {
            this.weapon.getLaser().aimAtTank(targetPoint.getTank(),targetPoint.getLocalPoint());
         }
         else
         {
            this.weapon.getLaser().updateDirection(aimDirection);
         }
      }
      
      private function calculateSpotScale(param1:Number) : Number
      {
         if(param1 < MIN_SPOT_DISTANCE)
         {
            return MAX_SPOT_SCALE;
         }
         if(param1 > MAX_SPOT_DISTANCE)
         {
            return MIN_SPOT_SCALE;
         }
         var _loc2_:Number = param1 - MIN_SPOT_DISTANCE;
         return (1 - _loc2_ / SPOT_SCALE_DISTANCE) * SPOT_SCALE + MIN_SPOT_SCALE;
      }
      
      public function processEvent(param1:ShaftEventType, param2:*) : void
      {
         switch(param1)
         {
            case ShaftEventType.TRIGGER_RELEASE:
               if(!this.fired)
               {
                  this.fired = true;
                  this.weapon.performAimedShot(this.context.initialEnergy);
                  this.weapon.setEnergyMode(ShaftEnergyMode.RECHARGE);
                  this.exitTime = getTimer() + this.shaft2Data.afterShotPause;
               }
         }
      }
      
      public function exit() : void
      {
         this.effects.playTargetingSound(false);
         this.effects.stopManualTargetingEffects();
         TurretController(this.turretController.getTurretController()).setMaxTurnSpeed(this.speedCharacteristics.getMaxTurretTurnSpeed(),true);
         TurretController(this.turretController.getTurretController()).setTurnAcceleration(this.savedTurnAcceleration);
         this.weapon.getLaser().hideLaser();
         this.weapon.stopManualTargeting();
         this.turretController.stopAim();
         display.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
      }
      
      private function onFullScreen(param1:FullScreenEvent) : void
      {
         this.weapon.processEvent(ShaftEventType.EXIT);
      }
      
      private function getSpeedFactor(param1:Number) : Number
      {
         var _loc2_:Number = this.shaft2Data.rotationCoeffT1;
         if(param1 < _loc2_)
         {
            return 1;
         }
         var _loc3_:Number = this.shaft2Data.rotationCoeffT2;
         var _loc4_:Number = this.shaft2Data.rotationCoeffKmin;
         if(param1 < _loc3_)
         {
            return 1 - (1 - _loc4_) * (param1 - _loc2_) / (_loc3_ - _loc2_);
         }
         return _loc4_;
      }
   }
}

