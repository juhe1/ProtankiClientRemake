package alternativa.tanks.models.weapon.shaft.states
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix4;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.objects.tank.controllers.LocalShaftController;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
   import alternativa.tanks.models.weapon.shaft.IShaftWeapon;
   import alternativa.tanks.models.weapon.shaft.LinearInterpolator;
   import alternativa.tanks.models.weapon.shaft.ShaftEnergyMode;
   import alternativa.tanks.models.weapon.shaft.ShaftEventType;
   import flash.events.FullScreenEvent;
   import flash.geom.Point;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
   
   public class ManualTargetingActivationState implements IShaftState
   {
      
      [Inject]
      public static var display:IDisplay;
      
      private var context:ManualTargetingContext;
      
      private var weapon:IShaftWeapon;
      
      private var stateDuration:int;
      
      private var targetFOV:Number;
      
      private var targetCameraPosition:Vector3;
      
      private var camera:GameCamera;
      
      private var skin:TankSkin;
      
      private var timeLeft:int;
      
      private var alphaInterpolator:LinearInterpolator = new LinearInterpolator();
      
      private var fovInterpolator:LinearInterpolator = new LinearInterpolator();
      
      private var reticleAlphaInterpolator:LinearInterpolator = new LinearInterpolator();
      
      private var indicatorInterpolatorX:LinearInterpolator = new LinearInterpolator();
      
      private var indicatorInterpolatorY:LinearInterpolator = new LinearInterpolator();
      
      private var initialCameraOrientation:Quaternion;
      
      private var targetCameraOrientation:Quaternion;
      
      private var cameraOrientation:Quaternion;
      
      private var initialCameraPosition:Vector3;
      
      private var cameraPosition:Vector3;
      
      private var cameraMatrix:Matrix4 = new Matrix4();
      
      private var turretMatrix:Matrix4 = new Matrix4();
      
      private var cameraAngles:Vector3 = new Vector3();
      
      private var shaftCC:ShaftCC;
      
      private var turretController:LocalShaftController;
      
      private var savedTurnAcceleration:Number;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var speedCharacteristics:SpeedCharacteristics;
      
      public function ManualTargetingActivationState(param1:ManualTargetingContext, param2:IShaftWeapon, param3:int, param4:Number, param5:Vector3, param6:GameCamera, param7:TankSkin, param8:WeaponPlatform, param9:LocalShaftController, param10:ShaftCC, param11:SpeedCharacteristics)
      {
         super();
         this.context = param1;
         this.weapon = param2;
         this.stateDuration = param3;
         this.targetFOV = param4;
         this.targetCameraPosition = param5.clone();
         this.camera = param6;
         this.skin = param7;
         this.initialCameraOrientation = new Quaternion();
         this.targetCameraOrientation = Quaternion.createFromAxisAngle(Vector3.X_AXIS,-Math.PI / 2);
         this.initialCameraPosition = new Vector3();
         this.cameraPosition = new Vector3();
         this.cameraOrientation = new Quaternion();
         this.reticleAlphaInterpolator.setInterval(0,1);
         this.turretController = param9;
         this.shaftCC = param10;
         this.weaponPlatform = param8;
         this.speedCharacteristics = param11;
      }
      
      public function enter(param1:int) : void
      {
         this.weaponPlatform.stopMovement();
         this.weaponPlatform.lockMovement(true);
         this.savedTurnAcceleration = TurretController(this.turretController.getTurretController()).getTurnAcceleration();
         TurretController(this.turretController.getTurretController()).setTurnAcceleration(this.shaftCC.targetingAcceleration);
         TurretController(this.turretController.getTurretController()).setMaxTurnSpeed(this.shaftCC.horizontalTargetingSpeed * this.speedCharacteristics.getTurretRotationCoefficient(),false);
         this.context.initialEnergy = this.weapon.getEnergy(param1);
         this.timeLeft = this.stateDuration;
         this.alphaInterpolator.setInterval(this.skin.getHullMesh().alpha,0);
         this.fovInterpolator.setInterval(this.camera.fov,this.targetFOV);
         var _loc2_:Point = new Point();
         var _loc3_:Point = new Point();
         this.weapon.initReticleDisplay(_loc2_,_loc3_);
         this.indicatorInterpolatorX.setInterval(_loc2_.x,_loc3_.x);
         this.indicatorInterpolatorY.setInterval(_loc2_.y,_loc3_.y);
         this.weapon.setReticleAlpha(0);
         this.weapon.disableFollowCamera();
         this.weapon.setEnergyMode(ShaftEnergyMode.DRAIN);
         this.calculateCameraInitialValues();
         this.turretController.startAim();
         display.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
      }
      
      private function calculateCameraInitialValues() : void
      {
         var _loc1_:Object3D = this.skin.getTurret3D();
         this.turretMatrix.setMatrix(_loc1_.x,_loc1_.y,_loc1_.z,_loc1_.rotationX,_loc1_.rotationY,_loc1_.rotationZ);
         this.cameraMatrix.setMatrix(this.camera.x,this.camera.y,this.camera.z,this.camera.rotationX,this.camera.rotationY,this.camera.rotationZ);
         this.turretMatrix.invert();
         this.cameraMatrix.append(this.turretMatrix);
         this.cameraMatrix.getEulerAngles(this.cameraAngles);
         this.initialCameraOrientation.setFromEulerAnglesXYZ(this.cameraAngles.x,this.cameraAngles.y,this.cameraAngles.z);
         this.cameraMatrix.getAxis(3,this.initialCameraPosition);
      }
      
      public function exit() : void
      {
         this.weaponPlatform.lockMovement(false);
         TurretController(this.turretController.getTurretController()).setMaxTurnSpeed(this.speedCharacteristics.getMaxTurretTurnSpeed(),true);
         TurretController(this.turretController.getTurretController()).setTurnAcceleration(this.savedTurnAcceleration);
         this.turretController.stopAim();
         display.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
      }
      
      private function onFullScreen(param1:FullScreenEvent) : void
      {
         this.weapon.processEvent(ShaftEventType.EXIT);
      }
      
      public function update(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.timeLeft <= 0)
         {
            this.weapon.processEvent(ShaftEventType.SWITCH);
         }
         else
         {
            this.timeLeft -= param2;
            _loc3_ = 1 - this.timeLeft / this.stateDuration;
            if(_loc3_ > 1)
            {
               _loc3_ = 1;
            }
            this.weapon.setIndicatorPosition(this.indicatorInterpolatorX.interpolate(_loc3_),this.indicatorInterpolatorY.interpolate(_loc3_));
            this.weapon.setReticleAlpha(this.reticleAlphaInterpolator.interpolate(_loc3_));
            this.camera.fov = this.fovInterpolator.interpolate(_loc3_);
            _loc4_ = this.alphaInterpolator.interpolate(_loc3_);
            this.skin.setAlpha(_loc4_);
            this.updateCamera(_loc3_);
         }
      }
      
      private function updateCamera(param1:Number) : void
      {
         this.cameraPosition.interpolate(param1,this.initialCameraPosition,this.targetCameraPosition);
         this.cameraOrientation.slerp(this.initialCameraOrientation,this.targetCameraOrientation,param1);
         this.cameraOrientation.toMatrix4(this.cameraMatrix);
         this.cameraMatrix.setPosition(this.cameraPosition);
         var _loc2_:Object3D = this.skin.getTurret3D();
         this.turretMatrix.setMatrix(_loc2_.x,_loc2_.y,_loc2_.z,_loc2_.rotationX,_loc2_.rotationY,_loc2_.rotationZ);
         this.cameraMatrix.append(this.turretMatrix);
         this.cameraMatrix.getEulerAngles(this.cameraAngles);
         this.camera.x = this.cameraMatrix.m03;
         this.camera.y = this.cameraMatrix.m13;
         this.camera.z = this.cameraMatrix.m23;
         this.camera.rotationX = this.cameraAngles.x;
         this.camera.rotationY = this.cameraAngles.y;
         this.camera.rotationZ = this.cameraAngles.z;
      }
      
      public function processEvent(param1:ShaftEventType, param2:*) : void
      {
         switch(param1)
         {
            case ShaftEventType.TRIGGER_RELEASE:
               this.weapon.processEvent(ShaftEventType.TRIGGER_RELEASE,this.context.initialEnergy);
         }
      }
   }
}

