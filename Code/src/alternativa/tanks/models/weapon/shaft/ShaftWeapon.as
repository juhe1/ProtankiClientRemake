package alternativa.tanks.models.weapon.shaft
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.objects.tank.LocalWeapon;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.objects.tank.controllers.LocalShaftController;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingMode;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.battle.scene3d.CameraFovCalculator;
   import alternativa.tanks.battle.scene3d.Object3DNames;
   import alternativa.tanks.camera.DummyCameraController;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
   import alternativa.tanks.models.weapon.laser.LaserPointer;
   import alternativa.tanks.models.weapon.shaft.cameracontrollers.ShaftMouseAimCameraController;
   import alternativa.tanks.models.weapon.shaft.cameracontrollers.TargetingCameraController;
   import alternativa.tanks.models.weapon.shaft.sfx.Indicator;
   import alternativa.tanks.models.weapon.shaft.states.IShaftState;
   import alternativa.tanks.models.weapon.shaft.states.ITransitionHandler;
   import alternativa.tanks.models.weapon.shaft.states.IdleState;
   import alternativa.tanks.models.weapon.shaft.states.ManualTargetingActivationState;
   import alternativa.tanks.models.weapon.shaft.states.ManualTargetingContext;
   import alternativa.tanks.models.weapon.shaft.states.ManualTargetingState;
   import alternativa.tanks.models.weapon.shaft.states.ReadyToShootState;
   import alternativa.tanks.models.weapon.shaft.states.ShaftTargetPoint;
   import alternativa.tanks.models.weapon.shaft.states.Transition;
   import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.ManualTargetingActivationStopHandler;
   import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.ManualTargetingActivationTriggerReleaseHandler;
   import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.ManualTargetingStopHandler;
   import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.QuickShotHandler;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.services.targeting.TargetingModeService;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   import alternativa.tanks.utils.MathUtils;
   import alternativa.tanks.utils.SetControllerForTemporaryItems;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   import alternativa.tanks.models.weapon.railgun.RailgunShotResult;
   
   public class ShaftWeapon extends BattleRunnerProvider implements Weapon, LocalWeapon, LogicUnit, IShaftWeapon
   {
      
      [Inject]
      public static var targetingModeService:TargetingModeService;
      
      [Inject]
      public static var display:IDisplay;
      
      private static const Cross:Class = ShaftWeapon_Cross;
      
      private static const CrossBitmap:BitmapData = new Cross().bitmapData;
      
      private static const SWITCH_INTERVAL:int = 200;
      
      private static const INDICATOR_SHIFT:Number = 9;
      
      private static const _origin:Vector3 = new Vector3();
      
      private static const _direction:Vector3 = new Vector3();
      
      private static const _m:Matrix4 = new Matrix4();
      
      private static const _p:Vector3 = new Vector3();
      
      private static const _barrelOrigin:Vector3 = new Vector3();
      
      private static const _closestBarrelOrigin:Vector3 = new Vector3();
      
      private static const thousand:EncryptedInt = new EncryptedIntImpl(1000);
      
      private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const INDICATOR_OFFSET:int = 75;
      
      private var battleService:BattleService;
      
      private var battleEventDispatcher:BattleEventDispatcher;
      
      private var laser:LaserPointer;
      
      private var callback:IShaftWeaponCallback;
      
      private var effects:ShaftEffects;
      
      private var targetingSystem:TargetingSystem;
      
      private var shaftData:ShaftCC;
      
      private var weaponForces:WeaponForces;
      
      private var cameraController:TargetingCameraController;
      
      private var weaponController:SimpleWeaponController;
      
      private var object3DToTank:Dictionary = new Dictionary();
      
      private var weaponPlatform:WeaponPlatform;
      
      private var states:Dictionary;
      
      private var currentState:IShaftState;
      
      private var transitions:Vector.<Transition>;
      
      private var energyBaseTime:EncryptedInt = new EncryptedIntImpl();
      
      private var energyAdditive:EncryptedNumber = new EncryptedNumberImpl();
      
      private var energySpeed:EncryptedNumber = new EncryptedNumberImpl();
      
      private var energyMode:ShaftEnergyMode = ShaftEnergyMode.RECHARGE;
      
      private var deactivationTask:ShaftDeactivationTask;
      
      private var enabled:Boolean;
      
      private var turretController:LocalShaftController;
      
      private var reloadTimeMS:int;
      
      private var reloadFinishTime:int;
      
      private var team:BattleTeam;
      
      private var exclusionSetController:SetControllerForTemporaryItems;
      
      private var exclusionSet:Dictionary;
      
      private var mouseAimCameraController:ShaftMouseAimCameraController;
      
      private var speedCharacteristics:SpeedCharacteristics;
      
      private var weakening:DistanceWeakening;
      
      private var reticleDisplay:ReticleDisplay;
      
      private var indicator:Indicator = new Indicator();
      
      private var cross:Bitmap = new Bitmap(CrossBitmap);
      
      private var shaftObject:ShaftObject;
      
      public function ShaftWeapon(param1:ShaftObject, param2:BattleService, param3:BattleEventDispatcher, param4:IShaftWeaponCallback, param5:ShaftCC, param6:WeaponForces, param7:SimpleWeaponController, param8:Dictionary, param9:LocalShaftController, param10:IGameObject, param11:TargetingSystem, param12:DistanceWeakening)
      {
         super();
         this.shaftObject = param1;
         this.laser = param1.laser();
         this.reloadTimeMS = param1.getReloadTimeMS();
         this.battleService = param2;
         this.battleEventDispatcher = param3;
         this.callback = param4;
         this.effects = param1.getEffects();
         var _loc13_:VerticalAutoAiming = param1.verticalAutoAiming();
         this.targetingSystem = param11;
         this.shaftData = param5;
         this.weaponForces = param6;
         this.cameraController = new TargetingCameraController(_loc13_.getElevationAngleUp(),-_loc13_.getElevationAngleDown(),param5.verticalTargetingSpeed,param5.horizontalTargetingSpeed);
         this.weaponController = param7;
         this.object3DToTank = param8;
         this.turretController = param9;
         this.speedCharacteristics = SpeedCharacteristics(param10.adapt(SpeedCharacteristics));
         this.weakening = param12;
         var _loc14_:BattleScene3D = param2.getBattleScene3D();
         this.deactivationTask = new ShaftDeactivationTask(_loc14_.getCamera());
         this.exclusionSet = _loc14_.getShaftRaycastExcludedObjects();
         this.exclusionSetController = new SetControllerForTemporaryItems(this.exclusionSet);
         this.mouseAimCameraController = new ShaftMouseAimCameraController(_loc13_);
         this.reticleDisplay = param9.getReticleDisplay();
      }
      
      private static function getClosestBarrelOrigin(param1:Vector3, param2:Vector.<Vector3>, param3:Vector3) : void
      {
         var _loc6_:Number = NaN;
         _barrelOrigin.copy(param2[0]);
         _barrelOrigin.y = 0;
         param3.copy(_barrelOrigin);
         var _loc4_:Number = param1.distanceToSquared(_barrelOrigin);
         var _loc5_:int = 1;
         while(_loc5_ < param2.length)
         {
            _barrelOrigin.copy(param2[_loc5_]);
            _barrelOrigin.y = 0;
            _loc6_ = param1.distanceToSquared(_barrelOrigin);
            if(_loc6_ < _loc4_)
            {
               _loc4_ = _loc6_;
               param3.copy(_barrelOrigin);
            }
            _loc5_++;
         }
      }
      
      private static function centerDisplayObject(param1:DisplayObject) : void
      {
         param1.x = display.stage.stageWidth - param1.width >> 1;
         param1.y = display.stage.stageHeight - param1.height >> 1;
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
         this.weaponController.setWeapon(this);
         this.weaponController.init();
         this.deactivationTask.setSkin(param1.getSkin());
         this.cameraController.setAnchorObject(param1.getTurret3D());
         this.team = this.getTank().teamType;
         this.initStateMachine();
         this.reset();
      }
      
      public function destroy() : void
      {
         this.shaftObject = null;
         this.laser = null;
         this.battleService = null;
         this.battleEventDispatcher = null;
         this.callback = null;
         this.effects = null;
         this.targetingSystem = null;
         this.shaftData = null;
         this.weaponForces = null;
         this.cameraController = null;
         this.object3DToTank = null;
         this.turretController = null;
         this.speedCharacteristics = null;
         this.weakening = null;
         this.currentState.exit();
         this.weaponController.destroy();
         this.deactivationTask.stop();
      }
      
      public function activate() : void
      {
         getBattleRunner().addLogicUnit(this);
      }
      
      public function deactivate() : void
      {
         getBattleRunner().removeLogicUnit(this);
      }
      
      public function enable() : void
      {
         if(!this.enabled)
         {
            this.enabled = true;
            this.currentState.enter(this.battleService.getPhysicsTime());
         }
      }
      
      public function disable(param1:Boolean) : void
      {
         if(this.enabled)
         {
            this.enabled = false;
            this.processEvent(ShaftEventType.STOP,param1);
         }
      }
      
      public function reset() : void
      {
         var _loc1_:int = int(this.battleService.getPhysicsTime());
         if(this.currentState != this.states[ShaftState.IDLE])
         {
            this.currentState.exit();
            this.currentState = this.states[ShaftState.IDLE];
         }
         var _loc2_:BattleTeam = this.getTank().teamType;
         if(this.team != _loc2_)
         {
            this.team = _loc2_;
            this.reticleDisplay.changeLaserSpotColor(this.getColorForTeam(this.team));
         }
         this.currentState.enter(_loc1_);
         this.doSetEnergyMode(ShaftEnergyMode.RECHARGE,this.shaftData.maxEnergy,_loc1_);
      }
      
      private function getTank() : Tank
      {
         return this.weaponPlatform.getBody().tank;
      }
      
      public function getStatus() : Number
      {
         return this.getEnergy(getTimer()) / this.shaftData.maxEnergy;
      }
      
      public function pullTrigger() : void
      {
         if(this.enabled)
         {
            this.currentState.processEvent(ShaftEventType.TRIGGER_PULL,null);
         }
      }
      
      public function releaseTrigger() : void
      {
         if(this.enabled)
         {
            this.currentState.processEvent(ShaftEventType.TRIGGER_RELEASE,null);
         }
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(this.enabled)
         {
            this.currentState.update(param1,param2);
         }
      }
      
      public function isTriggerPulled() : Boolean
      {
         return this.weaponController.isTriggerPulled();
      }
      
      public function setEnergyMode(param1:ShaftEnergyMode) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(param1 != this.energyMode)
         {
            _loc2_ = int(this.battleService.getPhysicsTime());
            _loc3_ = this.getEnergy(_loc2_);
            this.doSetEnergyMode(param1,_loc3_,_loc2_);
         }
      }
      
      public function processEvent(param1:ShaftEventType, param2:* = undefined) : void
      {
         var _loc3_:Transition = null;
         for each(_loc3_ in this.transitions)
         {
            if(_loc3_.eventType == param1 && _loc3_.state == this.currentState)
            {
               this.currentState.exit();
               if(_loc3_.handler != null)
               {
                  _loc3_.handler.execute(param2);
               }
               this.currentState = _loc3_.newState;
               if(this.currentState is IdleState)
               {
                  this.turretController.finishAim();
               }
               this.currentState.enter(this.battleService.getPhysicsTime());
               return;
            }
         }
         throw new TransitionNotFoundError(this.currentState,param1);
      }
      
      public function getEnergy(param1:int) : Number
      {
         var _loc2_:Number = this.energyAdditive.getNumber() + (param1 - this.energyBaseTime.getInt()) * this.energySpeed.getNumber() / thousand.getInt();
         return MathUtils.clamp(_loc2_,0,this.shaftData.maxEnergy);
      }
      
      public function disableFollowCamera() : void
      {
         this.battleService.setCameraController(DummyCameraController.INSTANCE);
      }
      
      public function setIndicatorPosition(param1:int, param2:int) : void
      {
         this.indicator.x = param1 + INDICATOR_SHIFT;
         this.indicator.y = param2;
      }
      
      private function getColorForTeam(param1:BattleTeam) : uint
      {
         switch(param1)
         {
            case BattleTeam.BLUE:
               return this.shaftObject.laser().getLaserPointerBlueColor();
            case BattleTeam.RED:
               return this.shaftObject.laser().getLaserPointerRedColor();
            default:
               return this.shaftObject.laser().getLaserPointerRedColor();
         }
      }
      
      public function startManualTargeting() : void
      {
         this.deactivationTask.stop();
         this.weaponPlatform.stopMovement();
         this.weaponPlatform.lockMovement(true);
         this.weaponPlatform.enableTurretSound(false);
         this.weaponPlatform.getBarrelOrigin(BattleUtils.tmpVector);
         this.cameraController.setLocalPosition(BattleUtils.tmpVector);
         this.cameraController.elevation = 0;
         this.cameraController.elevationDirection = 0;
         if(this.isMouseLookTargetingMode())
         {
            this.mouseAimCameraController.activate();
            this.battleService.setCameraController(this.mouseAimCameraController);
         }
         else
         {
            this.battleService.setCameraController(this.cameraController);
         }
         this.effects.createManualModeEffects(this.weaponPlatform.getTurret3D());
         this.callback.onManualTargetingStart();
         this.callback.enteredInManualMode();
         var _loc1_:BattleScene3D = this.battleService.getBattleScene3D();
         _loc1_.enableObjectHiding();
         _loc1_.hidableGraphicObjects.setCenterAndRadius(this.weaponPlatform.getBody().state.position,0);
      }
      
      private function isMouseLookTargetingMode() : Boolean
      {
         return targetingModeService.getCurrentMode() == TargetingMode.MOUSE_LOOK;
      }
      
      public function stopManualTargeting() : void
      {
         if(this.reticleDisplay.parent != null)
         {
            this.reticleDisplay.parent.removeChild(this.reticleDisplay);
            this.indicator.parent.removeChild(this.indicator);
            if(this.cross.parent != null)
            {
               this.cross.parent.removeChild(this.cross);
            }
         }
         this.weaponPlatform.lockMovement(false);
         this.weaponPlatform.enableTurretSound(true);
         this.battleService.setFollowCamera();
         this.battleService.resetFollowCamera();
         this.mouseAimCameraController.deactivate();
         this.battleService.getBattleScene3D().disableObjectHiding();
         this.weaponPlatform.showTitle();
         var _loc1_:Number = Number(this.battleService.getBattleView().getWidth());
         var _loc2_:Number = Number(this.battleService.getBattleView().getHeight());
         this.deactivationTask.setTargetFov(CameraFovCalculator.getCameraFov(_loc1_,_loc2_));
         this.deactivationTask.start();
      }
      
      public function isKeyDown(param1:uint) : Boolean
      {
         return this.weaponController.isKeyPressed(param1);
      }
      
      public function hasIntersection() : Boolean
      {
         var _loc3_:Object3D = null;
         this.weaponPlatform.getAllGunParams(allGunParams);
         var _loc1_:Vector3 = this.weaponPlatform.getBody().state.position;
         _direction.diff(allGunParams.barrelOrigin,_loc1_);
         var _loc2_:RayIntersectionData = this.battleService.getBattleScene3D().raycast(_loc1_,_direction,this.battleService.getExcludedObjects3D());
         if(_loc2_ != null && _loc2_.time <= 1)
         {
            _loc3_ = _loc2_.object;
            return _loc3_.name == Object3DNames.STATIC;
         }
         return false;
      }
      
      public function fadeChargingEffect() : void
      {
         this.effects.fadeChargingEffect();
      }
      
      public function getMaxEnergy() : Number
      {
         return this.shaftData.maxEnergy;
      }
      
      public function hideObjectsInRange(param1:Number) : void
      {
         var _loc2_:BattleScene3D = this.battleService.getBattleScene3D();
         _loc2_.hidableGraphicObjects.setCenterAndRadius(this.weaponPlatform.getBody().state.position,param1);
      }
      
      public function performAimedShot(param1:Number) : void
      {
         var _loc2_:int = int(this.battleService.getPhysicsTime());
         this.effects.stopManualTargetingEffects();
         this.weaponPlatform.getAllGunParams(allGunParams);
         var _loc3_:AimedShotResult = this.getAimedShotTargets();
         this.cameraController.readCameraDirection(_direction);
         var _loc4_:Number = param1 - this.getEnergy(_loc2_);
         this.effects.createHitMark(allGunParams.barrelOrigin,_loc3_.staticHitPoint);
         this.createShotEffects(_loc3_.staticHitPoint,_loc3_.targetHitPoints,_direction);
         this.applyImpactForceToTarget(_loc3_.targets,_loc3_.targetHitPoints,this.getAimedShotImpactForce(_loc4_),_direction);
         this.reloadFinishTime = this.battleService.getPhysicsTime() + this.reloadTimeMS;
         this.callback.onAimedShot(_loc2_,_loc3_.staticHitPoint,_loc3_.targets,_loc3_.targetHitPoints);
         this.doSetEnergyMode(ShaftEnergyMode.RECHARGE,Math.min(this.getEnergy(_loc2_),this.shaftData.maxEnergy - this.shaftData.minAimedShotEnergy),_loc2_);
      }
      
      private function getAimedShotTargets() : AimedShotResult
      {
         var _loc2_:RayIntersectionData = null;
         var _loc3_:Object3D = null;
         var _loc4_:Vector3 = null;
         var _loc5_:Tank = null;
         var _loc1_:AimedShotResult = new AimedShotResult();
         this.cameraController.readCameraPosition(_origin);
         this.turretController.getAimDirection(_direction);
         this.addTankSkinToExclusionSet(this.weaponPlatform.getSkin());
         while(true)
         {
            _loc2_ = this.battleService.getBattleScene3D().raycast(_origin,_direction,this.exclusionSet);
            if(_loc2_ == null)
            {
               break;
            }
            _loc3_ = _loc2_.object;
            _loc4_ = _origin.clone().addScaled(_loc2_.time + 0.1,_direction);
            if(_loc3_.name == Object3DNames.STATIC)
            {
               _loc1_.setStaticHitPoint(_loc4_);
               break;
            }
            if(_loc3_.name == Object3DNames.TANK_PART)
            {
               _loc5_ = this.object3DToTank[_loc3_];
               if(this.isValidHit(_loc5_,_loc3_,_loc4_))
               {
                  _loc1_.addTarget(_loc5_.getBody(),_loc4_);
                  break;
               }
               this.addTankSkinToExclusionSet(_loc5_.getSkin());
            }
            else
            {
               this.exclusionSetController.addTemporaryItem(_loc3_);
            }
            _origin.copy(_loc4_);
         }
         this.exclusionSetController.deleteAllTemporaryItems();
         return _loc1_;
      }
      
      private function isValidHit(param1:Tank, param2:Object3D, param3:Vector3) : Boolean
      {
         var _loc4_:TankSkin = param1.getSkin();
         if(_loc4_.getTurret3D() == param2)
         {
            _m.setMatrix(param2.x,param2.y,param2.z,param2.rotationX,param2.rotationY,param2.rotationZ);
            _m.transformVectorInverse(param3,_p);
            getClosestBarrelOrigin(_p,_loc4_.getTurretDescriptor().muzzles,_closestBarrelOrigin);
            _m.transformVector(_closestBarrelOrigin,_p);
            _p.subtract(param3);
            if(getBattleRunner().getCollisionDetector().hasStaticHit(param3,_p,CollisionGroup.STATIC,1))
            {
               return false;
            }
         }
         return _loc4_.getHullAlpha() == 1;
      }
      
      public function performQuickShot(param1:Number) : void
      {
         var _loc4_:RailgunShotResult = null;
         var _loc5_:Body = null;
         var _loc6_:Vector3 = null;
         var _loc7_:Vector3 = null;
         var _loc8_:Number = NaN;
         var _loc2_:int = int(this.battleService.getPhysicsTime());
         var _loc3_:Number = param1 < 0 ? this.getEnergy(_loc2_) : param1;
         if(_loc3_ >= this.shaftData.fastShotEnergy)
         {
            _loc3_ -= this.shaftData.fastShotEnergy;
            _loc4_ = new RailgunShotResult();
            if(!this.hasIntersection())
            {
               this.weaponPlatform.getAllGunParams(allGunParams);
               _loc4_.setFromTargetingResult(this.targetingSystem.target(allGunParams));
               this.createShotEffects(_loc4_.getStaticHitPoint(),_loc4_.hitPoints,_loc4_.shotDirection);
               this.applyImpactForceToTarget(_loc4_.targets,_loc4_.hitPoints,this.shaftData.weakeningCoeff,_loc4_.shotDirection);
               this.effects.createHitMark(allGunParams.barrelOrigin,_loc4_.getStaticHitPoint());
            }
            this.effects.createMuzzleFlashEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
            this.reloadFinishTime = this.battleService.getPhysicsTime() + this.reloadTimeMS;
            this.callback.onQuickShot(_loc2_,_loc4_.getStaticHitPoint(),_loc4_.targets,_loc4_.hitPoints);
         }
         this.doSetEnergyMode(ShaftEnergyMode.RECHARGE,_loc3_,_loc2_);
      }
      
      public function canShoot() : Boolean
      {
         return this.battleService.getPhysicsTime() >= this.reloadFinishTime;
      }
      
      public function onTargetingModeStop() : void
      {
         this.callback.onManualTargetingStop(this.battleService.getPhysicsTime());
      }
      
      private function addTankSkinToExclusionSet(param1:TankSkin) : void
      {
         this.exclusionSetController.addTemporaryItem(param1.getHullMesh());
         this.exclusionSetController.addTemporaryItem(param1.getTurret3D());
      }
      
      private function initStateMachine() : void
      {
         var _loc1_:Vector3 = this.weaponPlatform.getLaserLocalPosition().clone();
         this.states = new Dictionary();
         this.states[ShaftState.IDLE] = new IdleState(this);
         this.states[ShaftState.READY_TO_SHOOT] = new ReadyToShootState(this,SWITCH_INTERVAL);
         var _loc2_:ManualTargetingContext = new ManualTargetingContext();
         this.states[ShaftState.MANUAL_TARGETING_ACTIVATION] = new ManualTargetingActivationState(_loc2_,this,this.shaftData.targetingTransitionTime,this.shaftData.initialFOV,_loc1_,this.battleService.getBattleScene3D().getCamera(),this.weaponPlatform.getSkin(),this.weaponPlatform,this.turretController,this.shaftData,this.speedCharacteristics);
         this.states[ShaftState.MANUAL_TARGETING] = new ManualTargetingState(_loc2_,this,this.cameraController,this.shaftData,this.turretController,this.effects,this.speedCharacteristics);
         this.currentState = this.states[ShaftState.IDLE];
         this.transitions = Vector.<Transition>([this.createTransition(ShaftState.IDLE,ShaftEventType.READY_TO_SHOOT,ShaftState.READY_TO_SHOOT,null),this.createTransition(ShaftState.IDLE,ShaftEventType.STOP,ShaftState.IDLE,null),this.createTransition(ShaftState.READY_TO_SHOOT,ShaftEventType.TRIGGER_RELEASE,ShaftState.IDLE,new QuickShotHandler(this)),this.createTransition(ShaftState.READY_TO_SHOOT,ShaftEventType.SWITCH,ShaftState.MANUAL_TARGETING_ACTIVATION,null),this.createTransition(ShaftState.READY_TO_SHOOT,ShaftEventType.STOP,ShaftState.IDLE,null),this.createTransition(ShaftState.MANUAL_TARGETING_ACTIVATION,ShaftEventType.SWITCH,ShaftState.MANUAL_TARGETING,null),this.createTransition(ShaftState.MANUAL_TARGETING_ACTIVATION,ShaftEventType.TRIGGER_RELEASE,ShaftState.IDLE,new ManualTargetingActivationTriggerReleaseHandler(this)),this.createTransition(ShaftState.MANUAL_TARGETING_ACTIVATION,ShaftEventType.STOP,ShaftState.IDLE,new ManualTargetingActivationStopHandler(this)),this.createTransition(ShaftState
         .MANUAL_TARGETING,ShaftEventType.EXIT,ShaftState.IDLE,null),this.createTransition(ShaftState.MANUAL_TARGETING,ShaftEventType.STOP,ShaftState.IDLE,new ManualTargetingStopHandler(this))]);
      }
      
      private function createTransition(param1:ShaftState, param2:ShaftEventType, param3:ShaftState, param4:ITransitionHandler) : Transition
      {
         return new Transition(param2,this.states[param1],this.states[param3],param4);
      }
      
      private function doSetEnergyMode(param1:ShaftEnergyMode, param2:Number, param3:int) : void
      {
         this.energyMode = param1;
         switch(param1)
         {
            case ShaftEnergyMode.RECHARGE:
               this.energyAdditive.setNumber(0);
               this.energySpeed.setNumber(this.shaftData.chargeRate);
               this.energyBaseTime.setInt(param3 - param2 / this.energySpeed.getNumber() * thousand.getInt());
               break;
            case ShaftEnergyMode.DRAIN:
               this.energyAdditive.setNumber(this.shaftData.maxEnergy);
               this.energySpeed.setNumber(-this.shaftData.dischargeRate);
               this.energyBaseTime.setInt(param3 + (this.shaftData.maxEnergy - param2) / this.energySpeed.getNumber() * thousand.getInt());
               this.callback.onBeginEnergyDrain(param3);
         }
      }
      
      private function createShotEffects(param1:Vector3, param2:Vector.<Vector3>, param3:Vector3) : void
      {
         this.effects.createShotSoundEffect(allGunParams.muzzlePosition);
         this.effects.createHitPointsGraphicEffects(param1,param2,allGunParams.muzzlePosition,allGunParams.direction,param3);
         this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
      }
      
      private function applyImpactForceToTarget(param1:Vector.<Body>, param2:Vector.<Vector3>, param3:Number, param4:Vector3) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Body = null;
         var _loc9_:Tank = null;
         if(param1 != null)
         {
            _loc5_ = 1;
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc7_ = _loc5_ * param3;
               _loc8_ = param1[_loc6_];
               _loc9_ = _loc8_.tank;
               _loc9_.applyWeaponHit(param2[_loc6_],param4,_loc7_);
               _loc5_ *= this.shaftData.weakeningCoeff;
               _loc6_++;
            }
         }
      }
      
      private function getAimedShotImpactForce(param1:Number) : Number
      {
         var _loc2_:Number = this.shaftObject.commonData().getImpactForce();
         return _loc2_ + (this.weaponForces.getImpactForce() - _loc2_) * param1 / this.shaftData.maxEnergy;
      }
      
      public function setLaserPointerScale(param1:Number) : void
      {
         this.reticleDisplay.setLaserPointerScale(param1);
      }
      
      public function calculateTargetPoint(param1:Vector3, param2:ShaftTargetPoint) : Boolean
      {
         var _loc3_:RayIntersectionData = null;
         var _loc4_:Object3D = null;
         var _loc5_:Tank = null;
         this.cameraController.readCameraPosition(_origin);
         _direction.copy(param1);
         this.addTankSkinToExclusionSet(this.weaponPlatform.getSkin());
         param2.reset();
         while(true)
         {
            _loc3_ = this.battleService.getBattleScene3D().raycast(_origin,param1,this.exclusionSet);
            if(_loc3_ == null)
            {
               break;
            }
            _loc4_ = _loc3_.object;
            if(_loc4_.name == Object3DNames.STATIC)
            {
               _origin.addScaled(_loc3_.time,param1);
               param2.setTargetPoint(_origin);
               this.exclusionSetController.deleteAllTemporaryItems();
               return true;
            }
            if(_loc4_.name == Object3DNames.TANK_PART)
            {
               _origin.addScaled(_loc3_.time,param1);
               _loc5_ = this.object3DToTank[_loc4_];
               if(this.isValidHit(_loc5_,_loc4_,_origin))
               {
                  param2.setTargetPoint(_origin,_loc5_);
                  this.exclusionSetController.deleteAllTemporaryItems();
                  return true;
               }
            }
            this.exclusionSetController.addTemporaryItem(_loc3_.object);
         }
         this.exclusionSetController.deleteAllTemporaryItems();
         return false;
      }
      
      public function initReticleDisplay(param1:Point, param2:Point) : void
      {
         var _loc3_:DisplayObjectContainer = this.battleService.getBattleView().getParentDisplayContainer();
         _loc3_.addChild(this.reticleDisplay);
         centerDisplayObject(this.reticleDisplay);
         var _loc4_:Tank = this.getTank();
         _loc4_.hideTitle();
         var _loc5_:BitmapData = _loc4_.getTitleTexture();
         this.indicator.bitmapData = _loc5_;
         _loc3_.addChild(this.indicator);
         if(targetingModeService.getCurrentMode() == TargetingMode.MOUSE_LOOK)
         {
            _loc3_.addChild(this.cross);
         }
         var _loc6_:GameCamera = this.battleService.getBattleScene3D().getCamera();
         var _loc7_:Vector3D = new Vector3D();
         _loc4_.readTitlePosition(_loc7_);
         _loc7_ = _loc6_.projectGlobal(_loc7_);
         param1.x = _loc7_.x + this.battleService.getBattleView().getX();
         param1.y = _loc7_.y + this.battleService.getBattleView().getY() - _loc5_.height;
         this.indicator.x = param1.x;
         this.indicator.y = param1.y;
         this.updateCrossPosition();
         param2.x = display.stage.stageWidth >> 1;
         param2.y = (display.stage.stageHeight >> 1) + INDICATOR_OFFSET;
      }
      
      private function updateCrossPosition() : void
      {
         this.cross.x = display.stage.stageWidth - this.cross.width >> 1;
         this.cross.y = display.stage.stageHeight - this.cross.height >> 1;
      }
      
      public function setReticleAlpha(param1:Number) : void
      {
         this.reticleDisplay.reticle.alpha = param1;
         this.indicator.alpha = param1;
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.SHAFT_RESISTANCE;
      }
      
      public function getLaser() : LaserPointer
      {
         return this.laser;
      }
   }
}

