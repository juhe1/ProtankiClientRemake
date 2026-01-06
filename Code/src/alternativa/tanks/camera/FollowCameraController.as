package alternativa.tanks.camera
{
   import alternativa.engine3d.core.EllipsoidCollider;
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.TargetingModeChangedEvent;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingMode;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.service.settings.SettingEnum;
   import alternativa.tanks.service.settings.SettingsServiceEvent;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.services.targeting.TargetingInputListener;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.utils.MathUtils;
   import flash.display.Stage;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import mx.utils.StringUtil;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   
   public class FollowCameraController extends CameraControllerBase implements IFollowCameraController, TargetingInputListener, BattleEventListener
   {
      
      [Inject]
      public static var settings:ISettingsService;
      
      [Inject]
      public static var storageService:IStorageService;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var inputManager:TargetingInputManager;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var keysBindingService:KeysBindingService;
      
      private static const conVerticalCameraSpeed:ConsoleVarFloat = new ConsoleVarFloat("cam_vspeed",0.7,0,10);
      
      private static const ROTATE_SENS:Number = 0.001;
      
      private static const MIN_CAMERA_ANGLE:Number = 5 * Math.PI / 180;
      
      private static const COLLIDER_RADIUS:Number = 50;
      
      private static const MAX_CAMERA_MOVE_SPEED:Number = 5;
      
      private static const MIN_CAMERA_ROTATE_SPEED:Number = 3;
      
      private static const MAX_CAMERA_ROTATE_SPEED:Number = 9;
      
      private static const collisionPoint:Vector3 = new Vector3();
      
      private static const _v:Vector3 = new Vector3();
      
      private static const rayOrigin3D:Vector3D = new Vector3D();
      
      private static const displacement:Vector3D = new Vector3D();
      
      private static const collisionPoint3D:Vector3D = new Vector3D();
      
      private static const collisionNormal3D:Vector3D = new Vector3D();
      
      private static const rotationMatrix:Matrix3 = new Matrix3();
      
      private static const axis:Vector3 = new Vector3();
      
      private static const rayDirection:Vector3 = new Vector3();
      
      private static var maxCameraMoveSpeed:ConsoleVarFloat = new ConsoleVarFloat("cam_maxmove",MAX_CAMERA_MOVE_SPEED,0,MAX_CAMERA_MOVE_SPEED);
      
      public static var maxPositionError:Number = 10;
      
      public static var maxAngleError:Number = Math.PI / 180;
      
      public static var camSpeedThreshold:Number = 10;
      
      private static const FIXED_PITCH:Number = 10 * Math.PI / 180;
      
      private static const PITCH_CORRECTION_COEFF:Number = 1;
      
      private static const MIN_DISTANCE:Number = 300;
      
      private static const currentPosition:Vector3 = new Vector3();
      
      private static const currentRotation:Vector3 = new Vector3();
      
      private static const rayOrigin:Vector3 = new Vector3();
      
      private static const flatDirection:Vector3 = new Vector3();
      
      private static const positionDelta:Vector3 = new Vector3();
      
      private var pitchCorrectionEnabled:Boolean;
      
      public var inputLocked:Boolean;
      
      private var stage:Stage;
      
      private var distanceFromPivotToCamera:Number = 0;
      
      private var locked:Boolean;
      
      private var keyUpPressed:Boolean;
      
      private var keyDownPressed:Boolean;
      
      private var active:Boolean;
      
      private var target:CameraTarget;
      
      private var position:Vector3 = new Vector3();
      
      private var rotation:Vector3 = new Vector3();
      
      private var targetPosition:Vector3 = new Vector3();
      
      private var targetDirection:Vector3 = new Vector3();
      
      private var linearSpeed:Number = 0;
      
      private var pitchSpeed:Number = 0;
      
      private var yawSpeed:Number = 0;
      
      private var lastMinDistanceTime:int;
      
      private var cameraPositionData:CameraPositionData = new CameraPositionData();
      
      private var baseElevation:Number;
      
      private var _cameraT:Number = 0;
      
      private var cameraPosition:Point = new Point();
      
      private var point0:Point;
      
      private var point1:Point;
      
      private var point2:Point;
      
      private var point3:Point;
      
      private var collider:EllipsoidCollider;
      
      private var collisionObject:Object3D;
      
      private var _mouseWheel:int;
      
      private var mouseLookShift:Number = 0;
      
      private var cameraHeight:Number = 0;
      
      private var targetingMode:int;
      
      public function FollowCameraController()
      {
         super();
         this.stage = display.stage;
         this.point0 = new Point(145,545);
         this.point1 = new Point(930,1395);
         this.point2 = new Point(2245,1565);
         this.point3 = new Point(3105,760);
         this.collider = new EllipsoidCollider(COLLIDER_RADIUS,COLLIDER_RADIUS,COLLIDER_RADIUS);
         settings.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.configAlternateCamera);
         this.configAlternateCamera();
         var _loc1_:Number = Number(storageService.getStorage().data["cameraT"]);
         if(isNaN(_loc1_))
         {
            _loc1_ = 0.2;
         }
         this.setCameraT(_loc1_);
         var _loc2_:CommandService = CommandService(OSGi.getInstance().getService(CommandService));
         _loc2_.registerCommand("followCamera","position","",[],this.showCameraPosition);
      }
      
      private static function vector3To3D(param1:Vector3, param2:Vector3D) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.z = param1.z;
      }
      
      private static function getLinearSpeed(param1:Number) : Number
      {
         return maxCameraMoveSpeed.value * param1;
      }
      
      private static function bezier(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         var _loc6_:Number = 3 * (param3 - param2);
         var _loc7_:Number = 3 * param2 - 6 * param3 + 3 * param4;
         var _loc8_:Number = -param2 + 3 * param3 - 3 * param4 + param5;
         return param2 + param1 * _loc6_ + param1 * param1 * _loc7_ + param1 * param1 * param1 * _loc8_;
      }
      
      private function showCameraPosition(param1:FormattedOutput) : void
      {
         var _loc2_:Vector3 = getCameraPosition();
         param1.addText(StringUtil.substitute("position = ({0}; {1}; {2})",_loc2_.x,_loc2_.y,_loc2_.z));
      }
      
      private function configAlternateCamera(param1:SettingsServiceEvent = null) : void
      {
         if(param1 == null || param1.getSetting() != SettingEnum.ALTERNATE_CAMERA)
         {
            return;
         }
         if(settings.alternateCamera)
         {
            this.setAlternateSettings();
         }
         else
         {
            this.setDefaultSettings();
         }
      }
      
      public function setCollisionObject(param1:Object3D) : void
      {
         this.collisionObject = param1;
      }
      
      public function setDefaultSettings() : void
      {
         this.pitchCorrectionEnabled = true;
      }
      
      public function setAlternateSettings() : void
      {
         this.pitchCorrectionEnabled = false;
      }
      
      public function setTarget(param1:CameraTarget) : void
      {
         this.target = param1;
      }
      
      public function setTargetParams(param1:Vector3, param2:Vector3) : void
      {
         this.targetPosition.copy(param1);
         this.targetDirection.copy(param2);
         this.lastMinDistanceTime = 0;
         this.getCameraPositionData(param1,param2,this.cameraPositionData);
         this.position.copy(this.cameraPositionData.position);
         this.rotation.x = this.getPitchAngle(this.cameraPositionData) - 0.5 * Math.PI;
         this.rotation.y = 0;
         this.rotation.z = Math.atan2(-param2.x,param2.y);
         setPosition(this.position);
         setOrientation(this.rotation);
      }
      
      public function initCameraComponents() : void
      {
         this.position.copy(getCameraPosition());
         this.rotation.reset(getCameraRotationX(),getCameraRotationY(),getCameraRotationZ());
      }
      
      override public function activate() : void
      {
         super.activate();
         this.initCameraComponents();
         if(!this.active)
         {
            this.active = true;
            inputManager.addListener(this);
            battleEventDispatcher.addBattleEventListener(TargetingModeChangedEvent,this);
         }
      }
      
      override public function deactivate() : void
      {
         if(this.active)
         {
            this.active = false;
            inputManager.removeListener(this);
            battleEventDispatcher.removeBattleEventListener(TargetingModeChangedEvent,this);
            this.keyUpPressed = false;
            this.keyDownPressed = false;
         }
      }
      
      override public function update(param1:int, param2:int) : void
      {
         if(this.target == null)
         {
            return;
         }
         var _loc3_:Number = param2 * 0.001;
         if(_loc3_ > 0.1)
         {
            _loc3_ = 0.1;
         }
         this.updateCameraHeight(_loc3_);
         if(!this.locked)
         {
            this.recalculateTargetData();
         }
         this.getCameraPositionData(this.targetPosition,this.targetDirection,this.cameraPositionData);
         positionDelta.diff(this.cameraPositionData.position,this.position);
         var _loc4_:Number = positionDelta.length();
         if(_loc4_ > maxPositionError)
         {
            this.linearSpeed = getLinearSpeed(_loc4_ - maxPositionError);
         }
         var _loc5_:Number = this.linearSpeed * _loc3_;
         if(_loc5_ > _loc4_)
         {
            _loc5_ = _loc4_;
         }
         positionDelta.normalize().scale(_loc5_);
         var _loc6_:Number = this.getPitchAngle(this.cameraPositionData);
         var _loc7_:Number = Math.atan2(-this.targetDirection.x,this.targetDirection.y);
         var _loc8_:Number = MathUtils.clampAngle(this.rotation.x + 0.5 * Math.PI);
         var _loc9_:Number = MathUtils.clampAngle(this.rotation.z);
         var _loc10_:Number = MathUtils.clampAngleFast(_loc6_ - _loc8_);
         this.pitchSpeed = this.getAngularSpeed(_loc10_,this.pitchSpeed);
         var _loc11_:Number = this.pitchSpeed * _loc3_;
         if(_loc10_ > 0 && _loc11_ > _loc10_ || _loc10_ < 0 && _loc11_ < _loc10_)
         {
            _loc11_ = _loc10_;
         }
         var _loc12_:Number = MathUtils.clampAngleFast(_loc7_ - _loc9_);
         this.yawSpeed = this.getAngularSpeed(_loc12_,this.yawSpeed);
         var _loc13_:Number = this.yawSpeed * _loc3_;
         if(_loc12_ > 0 && _loc13_ > _loc12_ || _loc12_ < 0 && _loc13_ < _loc12_)
         {
            _loc13_ = _loc12_;
         }
         this.linearSpeed = MathUtils.snap(this.linearSpeed,0,camSpeedThreshold);
         this.pitchSpeed = MathUtils.snap(this.pitchSpeed,0,camSpeedThreshold);
         this.yawSpeed = MathUtils.snap(this.yawSpeed,0,camSpeedThreshold);
         this.position.add(positionDelta);
         this.rotation.x += _loc11_;
         this.rotation.z += _loc13_;
         currentPosition.copy(this.position);
         currentRotation.copy(this.rotation);
         setPosition(currentPosition);
         setOrientation(currentRotation);
      }
      
      public function setLocked(param1:Boolean) : void
      {
         this.locked = param1;
         if(param1)
         {
            this._mouseWheel = 0;
         }
      }
      
      public function getCameraT() : Number
      {
         return this._cameraT;
      }
      
      public function setCameraT(param1:Number) : void
      {
         this._cameraT = MathUtils.clamp(param1,0,1);
         var _loc2_:Number = MathUtils.clamp(this._cameraT + this.mouseLookShift * 0.1,0,1);
         this.cameraPosition.x = bezier(_loc2_,this.point0.x,this.point1.x,this.point2.x,this.point3.x);
         this.cameraPosition.y = bezier(_loc2_,this.point0.y,this.point1.y,this.point2.y,this.point3.y);
         this.baseElevation = Math.atan2(this.cameraPosition.x,this.cameraPosition.y);
         this.distanceFromPivotToCamera = this.cameraPosition.length;
         this.lastMinDistanceTime = 0;
      }
      
      public function getCameraState(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3) : void
      {
         this.getCameraPositionData(param1,param2,this.cameraPositionData);
         param4.x = this.getPitchAngle(this.cameraPositionData) - 0.5 * Math.PI;
         param4.z = Math.atan2(-param2.x,param2.y);
         param3.copy(this.cameraPositionData.position);
      }
      
      public function recalculateTargetData() : void
      {
         this.target.getCameraParams(this.targetPosition,this.targetDirection);
      }
      
      private function getCameraPositionData(param1:Vector3, param2:Vector3, param3:CameraPositionData) : void
      {
         var _loc7_:Number = NaN;
         var _loc4_:Number = this.baseElevation;
         var _loc5_:Number = Math.sqrt(param2.x * param2.x + param2.y * param2.y);
         if(_loc5_ < 0.00001)
         {
            flatDirection.x = 1;
            flatDirection.y = 0;
         }
         else
         {
            flatDirection.x = param2.x / _loc5_;
            flatDirection.y = param2.y / _loc5_;
         }
         param3.extraPitch = 0;
         param3.t = 1;
         rayOrigin.copy(param1);
         axis.x = flatDirection.y;
         axis.y = -flatDirection.x;
         flatDirection.reverse();
         rotationMatrix.fromAxisAngle(axis,-_loc4_);
         rotationMatrix.transformVector(flatDirection,rayDirection);
         this.getCollisionPoint(rayOrigin,rayDirection,this.distanceFromPivotToCamera,collisionPoint);
         var _loc6_:Number = _v.copy(rayOrigin).subtract(collisionPoint).length();
         param3.t = _loc6_ / this.distanceFromPivotToCamera;
         if(_loc6_ < MIN_DISTANCE)
         {
            rayOrigin.copy(collisionPoint);
            _loc7_ = MIN_DISTANCE - _loc6_;
            this.getCollisionPoint(rayOrigin,Vector3.Z_AXIS,_loc7_,collisionPoint);
         }
         param3.position.copy(collisionPoint);
      }
      
      private function getCollisionPoint(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : void
      {
         var _loc5_:Number = NaN;
         vector3To3D(param1,rayOrigin3D);
         displacement.x = param3 * param2.x;
         displacement.y = param3 * param2.y;
         displacement.z = param3 * param2.z;
         if(this.collider.getCollision(rayOrigin3D,displacement,collisionPoint3D,collisionNormal3D,this.collisionObject))
         {
            _loc5_ = COLLIDER_RADIUS + 0.1;
            param4.x = collisionPoint3D.x + _loc5_ * collisionNormal3D.x;
            param4.y = collisionPoint3D.y + _loc5_ * collisionNormal3D.y;
            param4.z = collisionPoint3D.z + _loc5_ * collisionNormal3D.z;
         }
         else
         {
            param4.copy(param1).addScaled(param3,param2);
         }
      }
      
      private function updateCameraHeight(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(this._mouseWheel < 0)
         {
            this.keyUpPressed = true;
            this.keyDownPressed = false;
            ++this._mouseWheel;
            if(this._mouseWheel == 0)
            {
               this.keyUpPressed = false;
            }
         }
         else if(this._mouseWheel > 0)
         {
            this.keyUpPressed = false;
            this.keyDownPressed = true;
            --this._mouseWheel;
            if(this._mouseWheel == 0)
            {
               this.keyDownPressed = false;
            }
         }
         if(!this.inputLocked && this.keyUpPressed != this.keyDownPressed)
         {
            _loc2_ = this.keyUpPressed ? 1 : -1;
            this.cameraHeight = this.getCameraT() + _loc2_ * conVerticalCameraSpeed.value * param1;
            this.setCameraT(this.cameraHeight);
         }
         else
         {
            this.setCameraT(this._cameraT);
         }
      }
      
      private function getAngularSpeed(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = this.getCameraRotateSpeed();
         if(param1 < -maxAngleError)
         {
            return _loc3_ * (param1 + maxAngleError);
         }
         if(param1 > maxAngleError)
         {
            return _loc3_ * (param1 - maxAngleError);
         }
         return param2;
      }
      
      private function getPitchAngle(param1:CameraPositionData) : Number
      {
         var _loc2_:Number = this.baseElevation - FIXED_PITCH;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         var _loc3_:Number = param1.t;
         if(_loc3_ >= 1 || _loc2_ < MIN_CAMERA_ANGLE || !this.pitchCorrectionEnabled)
         {
            return param1.extraPitch - _loc2_;
         }
         var _loc4_:Number = this.cameraPosition.x;
         return param1.extraPitch - Math.atan2(_loc3_ * _loc4_,PITCH_CORRECTION_COEFF * _loc4_ * (1 / Math.tan(_loc2_) - (1 - _loc3_) / Math.tan(this.baseElevation)));
      }
      
      [Obfuscation(rename="false")]
      override public function close() : void
      {
         var _loc1_:CommandService = CommandService(OSGi.getInstance().getService(CommandService));
         _loc1_.removeCommand("followCamera","position",[]);
         storageService.getStorage().data["cameraT"] = this.getCameraT();
         settings.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.configAlternateCamera);
      }
      
      private function getCameraRotateSpeed() : Number
      {
         return this.targetingMode == TargetingMode.MOUSE_LOOK ? MAX_CAMERA_ROTATE_SPEED : MIN_CAMERA_ROTATE_SPEED;
      }
      
      public function mouseAbsoluteMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseRelativeMovement(param1:Number, param2:Number) : void
      {
         if(!this.locked)
         {
            this.mouseLookShift += param2 * ROTATE_SENS * this.getMouseMoveMultiplier();
            this.mouseLookShift = MathUtils.clamp(this.mouseLookShift,-1,1);
         }
      }
      
      public function mouseLeftButton(param1:Boolean, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function mouseWheel(param1:int) : void
      {
         var _loc2_:Boolean = false;
         param1 *= this.getMouseMoveMultiplier();
         if(!this.locked)
         {
            _loc2_ = false;
            if(param1 > 1)
            {
               if(this._mouseWheel < 0)
               {
                  this._mouseWheel = 0;
               }
               _loc2_ = true;
            }
            if(param1 < 1)
            {
               if(this._mouseWheel > 0)
               {
                  this._mouseWheel = 0;
               }
               _loc2_ = true;
            }
            if(_loc2_)
            {
               this._mouseWheel = param1 * 2;
            }
         }
      }
      
      public function mouseRightButton(param1:Boolean, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function keyboardButton(param1:uint, param2:Boolean) : Boolean
      {
         var _loc3_:GameActionEnum = keysBindingService.getBindingAction(param1);
         switch(_loc3_)
         {
            case GameActionEnum.FOLLOW_CAMERA_UP:
               this.keyUpPressed = param2;
               break;
            case GameActionEnum.FOLLOW_CAMERA_DOWN:
               this.keyDownPressed = param2;
         }
         return true;
      }
      
      public function mouseLocked(param1:Boolean) : void
      {
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:TargetingModeChangedEvent = param1 as TargetingModeChangedEvent;
         if(_loc2_ != null)
         {
            this.targetingMode = _loc2_.targetingMode;
         }
      }
      
      private function getMouseMoveMultiplier() : int
      {
         return settings.mouseYInverse ? -1 : 1;
      }
   }
}

