package alternativa.tanks.models.weapon.shaft.cameracontrollers
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.camera.CameraController;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.utils.MathUtils;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ShaftMouseAimCameraController implements CameraController
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var dispay:IDisplay;
      
      [Inject]
      public static var localTankInfoService:LocalTankInfoService;
      
      [Inject]
      public static var settings:ISettingsService;
      
      private static const ALLOWED_DIFFERENCE_ANGLE:Number = 15;
      
      private static const ALLOWED_DIFFERENCE:Number = ALLOWED_DIFFERENCE_ANGLE * Math.PI / 180;
      
      private static var _muzzlePosition:Vector3 = new Vector3();
      
      private static var _cameraMatrix:Matrix4 = new Matrix4();
      
      private static var _turretMatrix:Matrix4 = new Matrix4();
      
      private static var _axisAngle:Vector3 = new Vector3();
      
      private var stage:Stage;
      
      private var mousePoint:Point = new Point();
      
      private var mouseLook:Boolean = false;
      
      private var camera:GameCamera;
      
      private var maxPitch:Number;
      
      private var minPitch:Number;
      
      private var movementX:Number;
      
      private var movementY:Number;
      
      private var rotationX:Number;
      
      private var rotationZ:Number;
      
      private var turretDirectionSnapshot:Number;
      
      public function ShaftMouseAimCameraController(param1:VerticalAutoAiming)
      {
         super();
         this.maxPitch = param1.getElevationAngleUp();
         this.minPitch = -param1.getElevationAngleDown();
         this.stage = dispay.stage;
      }
      
      public function activate() : void
      {
         this.camera = battleService.getBattleScene3D().getCamera();
         this.movementX = 0;
         this.movementY = 0;
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.startMouseLook();
         this.turretDirectionSnapshot = localTankInfoService.getLocalTank().getTurretDirection();
         this.rotationX = 0;
         this.rotationZ = 0;
      }
      
      public function deactivate() : void
      {
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.stopMouseLook();
      }
      
      private function startMouseLook() : void
      {
         this.mousePoint.x = this.stage.mouseX;
         this.mousePoint.y = this.stage.mouseY;
         this.mouseLook = true;
      }
      
      public function stopMouseLook(param1:Event = null) : void
      {
         this.mouseLook = false;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         this.movementX += param1["movementX"];
         this.movementY += param1["movementY"] * this.getMouseMoveMultiplier();
      }
      
      private function angleDiff(param1:Number, param2:Number) : Number
      {
         return Math.atan2(Math.sin(param1 - param2),Math.cos(param1 - param2));
      }
      
      public function update(param1:int, param2:int) : void
      {
         var _loc3_:Tank = null;
         var _loc4_:Object3D = null;
         var _loc5_:Mesh = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         if(this.mouseLook)
         {
            _loc3_ = localTankInfoService.getLocalTank();
            if(this.movementX != 0 || this.movementY != 0)
            {
               this.mousePoint.x = this.stage.mouseX;
               this.mousePoint.y = this.stage.mouseY;
               _loc6_ = this.getCameraVerticalFov();
               _loc7_ = -this.movementY * _loc6_ / this.stage.stageHeight;
               this.rotationX = MathUtils.clamp(MathUtils.clampAngle(this.rotationX + _loc7_),this.minPitch,this.maxPitch);
               _loc8_ = this.getCameraHorizontalFov();
               _loc9_ = _loc3_.getTurretDirection();
               _loc10_ = this.rotationZ - this.movementX * _loc8_ / this.stage.stageWidth;
               _loc11_ = _loc10_ + this.turretDirectionSnapshot;
               _loc12_ = this.angleDiff(_loc11_,_loc9_);
               _loc12_ = MathUtils.clamp(_loc12_,-ALLOWED_DIFFERENCE,ALLOWED_DIFFERENCE);
               _loc13_ = _loc9_ + _loc12_;
               _loc14_ = _loc13_ - this.turretDirectionSnapshot;
               this.rotationZ = _loc14_;
               this.movementX = 0;
               this.movementY = 0;
            }
            _muzzlePosition.copy(_loc3_.getLocalMuzzlePosition());
            _muzzlePosition.y = 0;
            _cameraMatrix.setPosition(_muzzlePosition);
            _loc4_ = _loc3_.getTurret3D();
            _turretMatrix.setMatrix(_loc4_.x,_loc4_.y,_loc4_.z,_loc4_.rotationX,_loc4_.rotationY,_loc4_.rotationZ);
            _cameraMatrix.append(_turretMatrix);
            this.camera.x = _cameraMatrix.m03;
            this.camera.y = _cameraMatrix.m13;
            this.camera.z = _cameraMatrix.m23;
            _loc5_ = _loc3_.getSkin().getHullMesh();
            _cameraMatrix.setMatrix(0,0,0,-Math.PI / 2 + this.rotationX,0,this.rotationZ + this.turretDirectionSnapshot);
            _turretMatrix.setMatrix(0,0,0,_loc5_.rotationX,_loc5_.rotationY,_loc5_.rotationZ);
            _cameraMatrix.append(_turretMatrix);
            _cameraMatrix.getEulerAngles(_axisAngle);
            this.camera.rotationX = MathUtils.clampAngle(_axisAngle.x);
            this.camera.rotationY = MathUtils.clampAngle(_axisAngle.y);
            this.camera.rotationZ = MathUtils.clampAngle(_axisAngle.z);
         }
      }
      
      private function getCameraVerticalFov() : Number
      {
         return 2 * Math.atan(this.stage.stageHeight / (2 * this.getCameraFocalLen()));
      }
      
      private function getCameraHorizontalFov() : Number
      {
         return 2 * Math.atan(this.stage.stageWidth / (2 * this.getCameraFocalLen()));
      }
      
      private function getCameraFocalLen() : Number
      {
         return Math.sqrt(this.stage.stageWidth * this.stage.stageWidth + this.stage.stageHeight * this.stage.stageHeight) / (2 * Math.tan(this.camera.fov * 0.5));
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
      }
      
      private function getMouseMoveMultiplier() : int
      {
         return settings.mouseYInverseShaftAim ? -1 : 1;
      }
   }
}

