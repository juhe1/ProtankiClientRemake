package alternativa.tanks.gui.tankpreview
{
   import alternativa.engine3d.containers.BSPContainer;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.MipMapping;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.core.View;
   import alternativa.engine3d.core.Wrapper;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.service.garage.GarageService;
   import controls.TankWindowInner;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import flash.utils.Timer;
   import forms.TankWindowWithHeader;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.flash.resources.tanks.Tank3D;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.disposeBitmapsData;
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class TankPreviewHoliday extends TankWindowWithHeader
   {
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var garageService:GarageService;
      
      private static const ENTER_FRAME_PRIORITY:Number = -1;
      
      private static const INITIAL_CAMERA_DIRECTION:Number = -150;
      
      private static const WINDOW_MARGIN:int = 11;
      
      private static const SHADOW_ALPHA:Number = 0.7;
      
      private static const SHADOW_BLUR:Number = 13;
      
      private static const SHADOW_RESOLUTION:Number = 2.5;
      
      private static const SHADOW_DIRECTION:Vector3D = new Vector3D(0,0,-1);
      
      private var innerBevel:TankWindowInner;
      
      private var backgroundEraser:Shape;
      
      private var rootContainer:Object3DContainer;
      
      private var hangarContainer:Object3DContainer;
      
      private var cameraContainer:Object3DContainer;
      
      private var camera:Camera3D;
      
      private var stateMachine:TankPreviewStateMachine;
      
      private var tank:Tank3D;
      
      private var loadedPartsCounter:int = 0;
      
      private var backgroundEraserTimer:Timer;
      
      private var shadow:Mesh;
      
      private var _hullMesh:Mesh;
      
      private var bitmapsData:Array;
      
      public function TankPreviewHoliday(param1:Tanks3DSResource)
      {
         super();
         this.bitmapsData = [];
         setHeaderId(TanksLocale.TEXT_HEADER_YOUR_TANK);
         this.init3D();
         this.createWindowInnerBevel();
         this.addGarageObjectsToScene(param1);
         this.createTank();
         this.resize(400,300);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function init3D() : void
      {
         this.rootContainer = new Object3DContainer();
         this.camera = new Camera3D();
         this.camera.view = new View(100,100,GPUCapabilities.constrained);
         this.camera.view.hideLogo();
         addChild(this.camera.view);
         this.cameraContainer = new Object3DContainer();
         this.rootContainer.addChild(this.cameraContainer);
         this.hangarContainer = new BSPContainer();
         this.rootContainer.addChild(this.hangarContainer);
         this.cameraContainer.addChild(this.camera);
         this.cameraContainer.rotationX = garageService.getCameraPitch() * Math.PI / 180;
         this.camera.y = garageService.getCameraAltitude();
         this.camera.z = garageService.getCameraDistance();
         this.camera.fov = garageService.getCameraFieldOfView();
         this.cameraContainer.rotationZ = INITIAL_CAMERA_DIRECTION * Math.PI / 180;
         if(GPUCapabilities.gpuEnabled)
         {
            this.backgroundEraser = new Shape();
            this.backgroundEraser.blendMode = BlendMode.ERASE;
         }
      }
      
      private function createWindowInnerBevel() : void
      {
         this.innerBevel = new TankWindowInner(0,0,TankWindowInner.TRANSPARENT);
         addChild(this.innerBevel);
         this.innerBevel.mouseEnabled = true;
      }
      
      private function createTank() : void
      {
         this.tank = new Tank3D();
         this.tank.z = 120;
         this.tank.y = -30;
         this.tank.x = 0;
         this.rootContainer.addChild(this.tank);
      }
      
      private function addGarageObjectsToScene(param1:Tanks3DSResource) : void
      {
         var _loc4_:Mesh = null;
         var _loc5_:TextureMaterial = null;
         var _loc6_:BSP = null;
         var _loc2_:int = int(param1.objects.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.objects[_loc3_] as Mesh;
            if(_loc4_ != null)
            {
               _loc5_ = TextureMaterial(_loc4_.faceList.material);
               _loc5_.texture = param1.getTextureForObject(_loc3_);
               _loc4_.setMaterialToAllFaces(_loc5_);
               _loc6_ = new BSP();
               _loc6_.createTree(_loc4_);
               _loc6_.matrix = _loc4_.matrix;
               this.hangarContainer.addChild(_loc6_);
            }
            _loc3_++;
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,ENTER_FRAME_PRIORITY);
         this.initStateMachine();
         if(GPUCapabilities.gpuEnabled)
         {
            this.backgroundEraserTimer = new Timer(1000,1);
            this.backgroundEraserTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
            this.backgroundEraserTimer.start();
         }
      }
      
      private function onBackgroundEraserTimerComplete(param1:TimerEvent) : void
      {
         addChild(this.backgroundEraser);
         this.backgroundEraserTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
         this.backgroundEraserTimer = null;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.stateMachine.updateCurrentState();
         this.camera.render();
      }
      
      private function initStateMachine() : void
      {
         this.stateMachine = new TankPreviewStateMachine();
         var _loc1_:TankPreviewContext = new TankPreviewContext();
         var _loc2_:ManualRotationState = new ManualRotationState(this.stateMachine,stage,_loc1_,this.camera,this.cameraContainer);
         var _loc3_:RotationDecelerationState = new RotationDecelerationState(this.stateMachine,this.innerBevel,_loc1_,this.cameraContainer);
         var _loc4_:IdleState = new IdleState(this.stateMachine,this.innerBevel);
         var _loc5_:AutoRotationState = new AutoRotationState(this.stateMachine,this.innerBevel,this.cameraContainer);
         this.stateMachine.addTransition(TankPreviewEvent.MOUSE_DOWN,_loc3_,_loc2_);
         this.stateMachine.addTransition(TankPreviewEvent.MOUSE_DOWN,_loc4_,_loc2_);
         this.stateMachine.addTransition(TankPreviewEvent.MOUSE_DOWN,_loc5_,_loc2_);
         this.stateMachine.addTransition(TankPreviewEvent.STOP_MANUAL_ROTATION,_loc2_,_loc3_);
         this.stateMachine.addTransition(TankPreviewEvent.ROTATION_STOPPED,_loc3_,_loc4_);
         this.stateMachine.addTransition(TankPreviewEvent.IDLE_STATE_TIMEOUT,_loc4_,_loc5_);
         this.stateMachine.setCurrentState(_loc4_);
      }
      
      public function destroy() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(this.backgroundEraserTimer != null)
         {
            this.backgroundEraserTimer.stop();
            this.backgroundEraserTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
            this.backgroundEraserTimer = null;
         }
         this.innerBevel = null;
         this.rootContainer = null;
         this.cameraContainer = null;
         this.camera.view.clear();
         this.camera = null;
         this.tank.destroy();
         this.tank = null;
         this.shadow = null;
         disposeBitmapsData(this.bitmapsData);
         this.bitmapsData = null;
      }
      
      public function setHull(param1:Tanks3DSResource) : void
      {
         this._hullMesh = Mesh(param1.objects[0]);
         this.tank.setHull(param1);
         this.onTankPartLoaded();
      }
      
      public function setTurret(param1:Tanks3DSResource) : void
      {
         this.tank.setTurret(param1);
         this.onTankPartLoaded();
      }
      
      public function setColorMap(param1:BitmapData) : void
      {
         this.tank.setColorMap(param1);
         this.onTankPartLoaded();
      }
      
      private function onTankPartLoaded() : void
      {
         if(this.loadedPartsCounter < 3)
         {
            ++this.loadedPartsCounter;
         }
         if(this.loadedPartsCounter == 3)
         {
            if(this.shadow != null && Boolean(this.tank.contains(this.shadow)))
            {
               this.tank.removeChild(this.shadow);
            }
            this.shadow = this.createShadow(this._hullMesh,SHADOW_DIRECTION,SHADOW_RESOLUTION,SHADOW_BLUR,SHADOW_ALPHA);
            this.tank.addChildAt(this.shadow,0);
            if(!GPUCapabilities.gpuEnabled)
            {
               this.camera.render();
            }
         }
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         this.width = param1;
         this.height = param2;
         this.adjustInnerBevel(param1,param2);
         this.adjustView3D(param1,param2);
         this.adjustBackgroundEraser();
         if(!GPUCapabilities.gpuEnabled)
         {
            this.camera.render();
         }
      }
      
      private function adjustInnerBevel(param1:Number, param2:Number) : void
      {
         this.innerBevel.width = param1 - WINDOW_MARGIN * 2;
         this.innerBevel.height = param2 - WINDOW_MARGIN * 2;
         this.innerBevel.x = WINDOW_MARGIN;
         this.innerBevel.y = WINDOW_MARGIN;
      }
      
      private function adjustView3D(param1:Number, param2:Number) : void
      {
         this.camera.view.width = param1 - WINDOW_MARGIN * 2 - 2;
         this.camera.view.height = param2 - WINDOW_MARGIN * 2 - 2;
         this.camera.view.x = WINDOW_MARGIN;
         this.camera.view.y = WINDOW_MARGIN;
      }
      
      private function adjustBackgroundEraser() : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            this.backgroundEraser.x = this.camera.view.x;
            this.backgroundEraser.y = this.camera.view.y;
            this.backgroundEraser.graphics.clear();
            this.backgroundEraser.graphics.beginFill(16711680);
            this.backgroundEraser.graphics.drawRect(0,0,this.camera.view.width,this.camera.view.height);
            this.backgroundEraser.graphics.endFill();
         }
      }
      
      private function createShadow(param1:Mesh, param2:Vector3D, param3:Number, param4:int, param5:Number, param6:uint = 0) : Mesh
      {
         var _loc20_:Wrapper = null;
         var _loc21_:Vertex = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Decal = null;
         param2 = param2.clone();
         param2.normalize();
         var _loc7_:Number = 1e+22;
         var _loc8_:Number = 1e+22;
         var _loc9_:Number = -1e+22;
         var _loc10_:Number = -1e+22;
         var _loc11_:Shape = new Shape();
         var _loc12_:Face = param1.faceList;
         while(_loc12_ != null)
         {
            _loc20_ = _loc12_.wrapper;
            while(_loc20_ != null)
            {
               _loc21_ = _loc20_.vertex;
               _loc22_ = -_loc21_.z / param2.z;
               _loc23_ = _loc21_.x + param2.x * _loc22_;
               _loc24_ = _loc21_.y + param2.y * _loc22_;
               if(_loc23_ < _loc7_)
               {
                  _loc7_ = _loc23_;
               }
               if(_loc23_ > _loc9_)
               {
                  _loc9_ = _loc23_;
               }
               if(_loc24_ < _loc8_)
               {
                  _loc8_ = _loc24_;
               }
               if(_loc24_ > _loc10_)
               {
                  _loc10_ = _loc24_;
               }
               if(_loc20_ == _loc12_.wrapper)
               {
                  _loc11_.graphics.beginFill(param6);
                  _loc11_.graphics.moveTo(_loc23_,_loc24_);
               }
               else
               {
                  _loc11_.graphics.lineTo(_loc23_,_loc24_);
               }
               _loc20_ = _loc20_.next;
            }
            _loc12_ = _loc12_.next;
         }
         _loc7_ = (Math.floor(_loc7_ / param3) - param4) * param3;
         _loc8_ = (Math.floor(_loc8_ / param3) - param4) * param3;
         _loc9_ = (Math.ceil(_loc9_ / param3) + param4) * param3;
         _loc10_ = (Math.ceil(_loc10_ / param3) + param4) * param3;
         var _loc13_:BitmapData = new BitmapData(Math.round((_loc9_ - _loc7_) / param3),Math.round((_loc10_ - _loc8_) / param3),true,0);
         this.bitmapsData.push(_loc13_);
         _loc13_.draw(_loc11_,new Matrix(1 / param3,0,0,-1 / param3,-_loc7_ / param3,_loc10_ / param3));
         _loc13_.applyFilter(_loc13_,_loc13_.rect,new Point(),new BlurFilter(param4,param4,BitmapFilterQuality.MEDIUM));
         var _loc14_:TextureMaterial = new TextureMaterial(_loc13_,false,true,MipMapping.PER_PIXEL,param3);
         var _loc15_:Mesh = new Mesh();
         var _loc16_:Vertex = _loc15_.addVertex(_loc7_,_loc10_,0,0,0);
         var _loc17_:Vertex = _loc15_.addVertex(_loc7_,_loc8_,0,0,1);
         var _loc18_:Vertex = _loc15_.addVertex(_loc9_,_loc8_,0,1,1);
         var _loc19_:Vertex = _loc15_.addVertex(_loc9_,_loc10_,0,1,0);
         _loc15_.addQuadFace(_loc16_,_loc17_,_loc18_,_loc19_,_loc14_);
         _loc15_.calculateFacesNormals();
         _loc15_.calculateBounds();
         _loc15_.alpha = param5;
         if(GPUCapabilities.gpuEnabled)
         {
            _loc25_ = new Decal();
            _loc25_.createGeometry(_loc15_,true);
            _loc25_.x = _loc15_.x;
            _loc25_.y = _loc15_.y;
            _loc25_.z = _loc15_.z;
            _loc25_.alpha = _loc15_.alpha;
            return _loc25_;
         }
         return _loc15_;
      }
   }
}

