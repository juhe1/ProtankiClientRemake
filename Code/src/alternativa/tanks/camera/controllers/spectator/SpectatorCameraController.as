package alternativa.tanks.camera.controllers.spectator
{
   import alternativa.math.Vector3;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.camera.ActivatedCameraConroller;
   import alternativa.tanks.camera.CameraController;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.utils.MathUtils;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class SpectatorCameraController extends ActivatedCameraConroller implements CameraController
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const conSmooth:ConsoleVarFloat = new ConsoleVarFloat("cam_smooth",0.1,0.001,1);
      
      private static const conSmoothDeceleration:ConsoleVarFloat = new ConsoleVarFloat("cam_smooth_dec",0.025,0.001,1);
      
      private static const conMousePitchSensitivity:ConsoleVarFloat = new ConsoleVarFloat("m_pitch",-0.006,-100,100);
      
      private static const conMouseYawSensitivity:ConsoleVarFloat = new ConsoleVarFloat("m_yaw",-0.006,-100,100);
      
      private static const conSpeed:ConsoleVarFloat = new ConsoleVarFloat("cam_spd",1300,0,10000);
      
      private static const conAcceleration:ConsoleVarFloat = new ConsoleVarFloat("cam_acc",4,0,1000000);
      
      private static const conDeceleration:ConsoleVarFloat = new ConsoleVarFloat("cam_dec",0.33,0.05,2);
      
      private static const conYawSpeed:ConsoleVarFloat = new ConsoleVarFloat("yaw_speed",1,-10,10);
      
      private static const conPitchSpeed:ConsoleVarFloat = new ConsoleVarFloat("pitch_speed",1,-10,10);
      
      private var mouseDown:Boolean;
      
      private var mouseDownX:Number;
      
      private var mouseDownY:Number;
      
      private var startCameraRotationX:Number;
      
      private var startCameraRotationZ:Number;
      
      private var position:Vector3 = new Vector3();
      
      private var rotation:Vector3 = new Vector3();
      
      private var rotationDelta:Vector3 = new Vector3();
      
      private var moveMethods:MovementMethods;
      
      private var keyboardHandlers:Vector.<KeyboardHandler>;
      
      private var userInput:UserInput = new UserInputImpl();
      
      private var playerCamera:PlayerCamera;
      
      private var addedEvents:Boolean = false;
      
      public function SpectatorCameraController()
      {
         super();
         this.playerCamera = new PlayerCamera(this);
         this.keyboardHandlers = Vector.<KeyboardHandler>([new BookmarksHandler(this),this.userInput,this.playerCamera,new SpectatorBonusRegionController()]);
         this.setPositionFromCamera();
         this.moveMethods = new MovementMethods(Vector.<MovementMethod>([new FlightMovement(conSpeed,conAcceleration,conDeceleration),new WalkMovement(conSpeed,conAcceleration,conDeceleration)]));
      }
      
      private static function calculateAngleDelta(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = (param2 - param1) % (2 * Math.PI);
         if(_loc3_ > Math.PI)
         {
            return _loc3_ - 2 * Math.PI;
         }
         if(_loc3_ < -Math.PI)
         {
            return 2 * Math.PI + _loc3_;
         }
         return _loc3_;
      }
      
      internal function setCameraState(param1:Vector3, param2:Vector3) : void
      {
         var _loc3_:GameCamera = null;
         this.playerCamera.unfocus();
         this.position.copy(param1);
         this.rotation.copy(param2);
         _loc3_ = getCamera();
         this.rotationDelta.x = calculateAngleDelta(_loc3_.rotationX,param2.x);
         this.rotationDelta.y = calculateAngleDelta(_loc3_.rotationY,param2.y);
         this.rotationDelta.z = calculateAngleDelta(_loc3_.rotationZ,param2.z);
      }
      
      override public function update(param1:int, param2:int) : void
      {
         if(getCamera() != null)
         {
            this.calculatePosition(param2);
            this.calculateRotation(param2 / 1000);
            this.applyTransformation();
         }
      }
      
      private function calculatePosition(param1:int) : void
      {
         var _loc2_:Vector3 = this.moveMethods.getMethod().getDisplacement(this.userInput,getCamera(),param1 / 1000);
         this.position.x += _loc2_.x;
         this.position.y += _loc2_.y;
         this.position.z += _loc2_.z;
      }
      
      private function calculateRotation(param1:Number) : void
      {
         var _loc2_:GameCamera = null;
         _loc2_ = getCamera();
         if(this.mouseDown)
         {
            this.rotation.x = this.startCameraRotationX + (display.stage.mouseY - this.mouseDownY) * conMousePitchSensitivity.value;
            this.rotation.x = MathUtils.clamp(this.rotation.x,-Math.PI,0);
            this.rotationDelta.x = this.rotation.x - _loc2_.rotationX;
            this.rotation.z = this.startCameraRotationZ + (display.stage.mouseX - this.mouseDownX) * conMouseYawSensitivity.value;
            this.rotationDelta.z = this.rotation.z - _loc2_.rotationZ;
         }
         else if(this.userInput.isRotating())
         {
            this.rotation.x += this.userInput.getPitchDirection() * conPitchSpeed.value * param1;
            this.rotation.x = MathUtils.clamp(this.rotation.x,-Math.PI,0);
            this.rotationDelta.x = this.rotation.x - _loc2_.rotationX;
            this.rotationDelta.z += this.userInput.getYawDirection() * conYawSpeed.value * param1;
         }
      }
      
      private function applyTransformation() : void
      {
         this.applyDisplacement();
         this.applyRotation();
      }
      
      private function applyDisplacement() : void
      {
         var _loc1_:ConsoleVarFloat = this.moveMethods.getMethod().accelerationInverted() ? conSmoothDeceleration : conSmooth;
         var _loc2_:GameCamera = getCamera();
         _loc2_.x += (this.position.x - _loc2_.x) * _loc1_.value;
         _loc2_.y += (this.position.y - _loc2_.y) * _loc1_.value;
         _loc2_.z += (this.position.z - _loc2_.z) * _loc1_.value;
      }
      
      private function applyRotation() : void
      {
         var _loc1_:ConsoleVarFloat = null;
         var _loc2_:GameCamera = null;
         _loc1_ = this.moveMethods.getMethod().accelerationInverted() ? conSmoothDeceleration : conSmooth;
         _loc2_ = getCamera();
         var _loc3_:Number = this.rotationDelta.x * _loc1_.value;
         _loc2_.rotationX += _loc3_;
         this.rotationDelta.x -= _loc3_;
         var _loc4_:Number = this.rotationDelta.y * _loc1_.value;
         _loc2_.rotationY += _loc4_;
         this.rotationDelta.y -= _loc4_;
         var _loc5_:Number = this.rotationDelta.z * _loc1_.value;
         _loc2_.rotationZ += _loc5_;
         this.rotationDelta.z -= _loc5_;
      }
      
      override public function activate() : void
      {
         super.activate();
         this.rotationDelta.reset();
         this.activateInput();
      }
      
      public function setPositionFromCamera() : void
      {
         var _loc1_:GameCamera = null;
         _loc1_ = getCamera();
         this.position.x = _loc1_.x;
         this.position.y = _loc1_.y;
         this.position.z = _loc1_.z;
         this.rotation.x = _loc1_.rotationX;
         this.rotation.y = _loc1_.rotationY;
         this.rotation.z = _loc1_.rotationZ;
      }
      
      override public function deactivate() : void
      {
         this.userInput.reset();
         this.rotationDelta.reset();
         this.deactivateInput();
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this.mouseDown = true;
         this.mouseDownX = param1.stageX;
         this.mouseDownY = param1.stageY;
         var _loc2_:GameCamera = getCamera();
         this.startCameraRotationX = _loc2_.rotationX;
         this.startCameraRotationZ = _loc2_.rotationZ;
         display.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:KeyboardHandler = null;
         for each(_loc2_ in this.keyboardHandlers)
         {
            _loc2_.handleKeyUp(param1);
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:KeyboardHandler = null;
         var _loc3_:Boolean = false;
         if(param1.keyCode == Keyboard.SPACE)
         {
            _loc3_ = Boolean(this.moveMethods.getMethod().accelerationInverted());
            this.moveMethods.selectNextMethod();
            this.moveMethods.getMethod().setAccelerationInverted(_loc3_);
         }
         if(param1.keyCode == Keyboard.I)
         {
            this.moveMethods.getMethod().invertAcceleration();
         }
         for each(_loc2_ in this.keyboardHandlers)
         {
            _loc2_.handleKeyDown(param1);
         }
      }
      
      private function releaseMouse() : void
      {
         if(this.mouseDown)
         {
            display.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            this.mouseDown = false;
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this.releaseMouse();
      }
      
      [Obfuscation(rename="false")]
      override public function close() : void
      {
         this.playerCamera.close();
      }
      
      public function deactivateInput() : void
      {
         var _loc1_:Stage = null;
         this.releaseMouse();
         if(this.addedEvents)
         {
            _loc1_ = display.stage;
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            _loc1_.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            _loc1_.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this.addedEvents = false;
         }
      }
      
      public function activateInput() : void
      {
         var _loc1_:Stage = null;
         if(!this.addedEvents)
         {
            _loc1_ = display.stage;
            _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            _loc1_.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            _loc1_.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this.addedEvents = true;
         }
      }
   }
}

