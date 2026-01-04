package alternativa.tanks.gui.tankpreview
{
   import alternativa.engine3d.containers.KDContainer;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.MipMapping;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.core.View;
   import alternativa.engine3d.core.Wrapper;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.SkyBox;
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
   import alternativa.engine3d.alternativa3d;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   
   use namespace alternativa3d;
   
   public class TankPreviewWindow extends TankWindowWithHeader
   {
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var garageService:GarageService;
      
      //[Inject]
      //public static var batteryService:BatteriesService;
      
      private static const ENTER_FRAME_PRIORITY:Number = -1;
      
      private static const INITIAL_CAMERA_DIRECTION:Number = -150;
      
      private static const WINDOW_MARGIN:int = 11;
      
      private static const SHADOW_ALPHA:Number = 0.7;
      
      private static const SHADOW_BLUR:Number = 13;
      
      private static const SHADOW_RESOLUTION:Number = 2.5;
      
      private static const SHADOW_DIRECTION:Vector3D = new Vector3D(0,0,-1);
      
      protected var innerBevel:TankWindowInner;
      
      protected var backgroundEraser:Shape;
      
      protected var rootContainer:Object3DContainer;
      
      protected var hangarContainer:Object3DContainer;
      
      protected var cameraContainer:Object3DContainer;
      
      protected var camera:Camera3D;
      
      protected var stateMachine:TankPreviewStateMachine;
      
      protected var tank:Tank3D;
      
      //protected var drone:Drone3D;
      
      private var loadedPartsCounter:int = 0;
      
      protected var backgroundEraserTimer:Timer;
      
      protected var shadow:Mesh;
      
      private var shadowMaterial:TextureMaterial;
      
      private var cams:Array;
      
      private var tower:Object3D;
      
      private var tree1:Object3D;
      
      private var tree2:Object3D;
      
      private var tree3:Object3D;
      
      private var bg2:Object3D;
      
      private var tree4:Object3D;
      
      private var tree5:Object3D;
      
      private var bg:Object3D;
      
      private var window1:Object3D;
      
      private var window2:Object3D;
      
      private var window3:Object3D;
      
      private var walls:Array;
      
      private var floor:Object3D;
      
      private var ventilator1:Object3D;
      
      private var ventilator2:Object3D;
      
      private var ventfix:Object3D;
      
      private var firepanel:Object3D;
      
      private var electropanel:Object3D;
      
      private var hullMesh:Mesh;
      
      private var girders:Object3D;
      
      private var balkl:Object3D;
      
      private var balk2:Object3D;
      
      private var lamps:Array;
      
      private var tops:Object3D;
      
      private var pandus1:Object3D;
      
      private var pandus2:Object3D;
      
      private var others:Array;
      
      private var ladder1_part1:Mesh;
      
      private var ladder1_part2:Mesh;
      
      private var ladder2_part1:Mesh;
      
      private var ladder2_part2:Mesh;
      
      private var garageBoxResource:Tanks3DSResource;
      
      private var skyBox:SkyBox;
      
      protected var kdTree:KDContainer;
      
      public function TankPreviewWindow()
      {
         super();
      }
      
      public function init(param1:Tanks3DSResource, param2:SkyBox) : void
      {
         this.garageBoxResource = param1;
         this.skyBox = param2;
         setHeaderId(TanksLocale.TEXT_HEADER_YOUR_TANK);
         this.init3D();
         this.createWindowInnerBevel();
         this.addGarageObjectsToScene(param1);
         this.createScene();
         this.resize(400,300);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      protected function init3D() : void
      {
         this.rootContainer = new Object3DContainer();
         this.cams = new Array();
         this.walls = new Array();
         this.lamps = new Array();
         this.others = new Array();
         if(this.skyBox != null)
         {
            this.rootContainer.addChild(this.skyBox);
         }
         this.camera = new Camera3D();
         this.camera.view = new View(100,100,GPUCapabilities.constrained);
         this.camera.view.hideLogo();
         addChild(this.camera.view);
         this.cameraContainer = new Object3DContainer();
         this.rootContainer.addChild(this.cameraContainer);
         this.hangarContainer = new Object3DContainer();
         this.rootContainer.addChild(this.hangarContainer);
         this.cameraContainer.addChild(this.camera);
         this.cameraContainer.rotationX = garageService.getCameraPitch() * Math.PI / 180;
         this.camera.y = garageService.getCameraAltitude();
         this.camera.z = garageService.getCameraDistance();
         this.camera.fov = garageService.getCameraFieldOfView();
         this.camera.x = -20;
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
         this.tank.x = -5;
      }
      
      protected function createDrone(param1:Vector3D) : void
      {
         var basePosition:Vector3D = param1;
         //this.drone = new Drone3D(this.tank,this.camera,basePosition,function():*
         //{
         //   return batteryService.hasBatteries();
         //});
      }
      
      private function classifyObject(param1:Mesh, param2:int) : void
      {
         var _loc3_:TextureMaterial = null;
         if(param1.faceList.material is TextureMaterial)
         {
            _loc3_ = TextureMaterial(param1.faceList.material);
            _loc3_.texture = this.garageBoxResource.getTextureForObject(param2);
            param1.setMaterialToAllFaces(_loc3_);
         }
         else
         {
            param1.setMaterialToAllFaces(param1.faceList.material);
         }
         if(param1.name.indexOf("cam") >= 0)
         {
            this.cams.push(param1);
         }
         else if(param1.name == "Tower")
         {
            this.tower = param1;
         }
         else if(param1.name == "tree1")
         {
            this.tree1 = param1;
         }
         else if(param1.name == "tree2")
         {
            this.tree2 = param1;
         }
         else if(param1.name == "tree3")
         {
            this.tree3 = param1;
         }
         else if(param1.name == "bg2")
         {
            this.bg2 = param1;
         }
         else if(param1.name == "tree4")
         {
            this.tree4 = param1;
         }
         else if(param1.name == "tree5")
         {
            this.tree5 = param1;
         }
         else if(param1.name == "bg")
         {
            this.bg = param1;
         }
         else if(param1.name == "wall_10")
         {
            this.window1 = param1;
         }
         else if(param1.name == "wall_12")
         {
            this.window2 = param1;
         }
         else if(param1.name == "wall_13")
         {
            this.window3 = param1;
         }
         else if(param1.name.indexOf("wall") >= 0)
         {
            this.walls.push(param1);
         }
         else if(param1.name == "Object06")
         {
            this.floor = param1;
         }
         else if(param1.name == "vent_1")
         {
            this.ventilator1 = param1;
         }
         else if(param1.name == "vent_2")
         {
            this.ventilator2 = param1;
         }
         else if(param1.name == "Object39")
         {
            this.ventfix = param1;
         }
         else if(param1.name == "Object15")
         {
            this.firepanel = param1;
         }
         else if(param1.name == "Object20")
         {
            this.electropanel = param1;
         }
         else if(param1.name == "girders")
         {
            this.girders = param1;
         }
         else if(param1.name == "Object27")
         {
            this.balkl = param1;
         }
         else if(param1.name == "Object08")
         {
            this.balk2 = param1;
         }
         else if(param1.name.indexOf("lamp") >= 0)
         {
            this.lamps.push(param1);
         }
         else if(param1.name == "Object133")
         {
            this.tops = param1;
         }
         else if(param1.name == "Object23")
         {
            this.ladder1_part1 = param1;
         }
         else if(param1.name == "Object02")
         {
            this.ladder1_part2 = param1;
         }
         else if(param1.name == "Object24")
         {
            this.ladder2_part1 = param1;
         }
         else if(param1.name == "Object96")
         {
            this.ladder2_part2 = param1;
         }
         else if(param1.name == "pandus_1")
         {
            this.pandus1 = param1;
         }
         else if(param1.name == "pandus_2")
         {
            this.pandus2 = param1;
         }
         else if(param1.name == "Object92")
         {
            this.others.push(param1);
         }
         else
         {
            this.others.push(param1);
         }
      }
      
      protected function addGarageObjectsToScene(param1:Tanks3DSResource) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Mesh = null;
         _loc2_ = 0;
         while(_loc2_ < param1.objects.length)
         {
            _loc3_ = param1.objects[_loc2_] as Mesh;
            if(_loc3_ != null)
            {
               if(_loc3_.name != "stuff15")
               {
                  this.classifyObject(_loc3_,_loc2_);
               }
            }
            _loc2_++;
         }
         this.others.push(this.ladder1_part1);
         this.others.push(this.ladder1_part2);
         this.others.push(this.ladder2_part1);
         this.others.push(this.ladder2_part2);
         this.tower = this.toBSP(this.tower);
         this.bg = this.toBSP(this.bg);
         _loc2_ = 0;
         while(_loc2_ < this.walls.length)
         {
            this.walls[_loc2_] = this.toBSP(this.walls[_loc2_]);
            _loc2_++;
         }
         this.firepanel = this.toBSP(this.firepanel);
         this.electropanel = this.toBSP(this.electropanel);
         this.girders = this.toBSP(this.girders);
         this.balkl = this.toBSP(this.balkl);
         _loc2_ = 0;
         while(_loc2_ < this.lamps.length)
         {
            this.lamps[_loc2_] = this.toBSP(this.lamps[_loc2_]);
            _loc2_++;
         }
         this.tops = this.toBSP(this.tops);
         this.pandus1 = this.toBSP(this.pandus1);
         this.pandus2 = this.toBSP(this.pandus2);
         _loc2_ = 0;
         while(_loc2_ < this.others.length)
         {
            this.others[_loc2_] = this.toBSP(this.others[_loc2_]);
            _loc2_++;
         }
         this.ventilator1.y += 10;
         this.ventilator2.y += 10;
      }
      
      private function toBSP(param1:Object3D) : BSP
      {
         var _loc2_:BSP = new BSP();
         _loc2_.createTree(param1 as Mesh,false);
         _loc2_.name = param1.name;
         _loc2_.matrix = param1.matrix;
         _loc2_.useLight = param1.useLight;
         _loc2_.useShadowMap = param1.useShadowMap;
         _loc2_.shadowMapAlphaThreshold = param1.shadowMapAlphaThreshold;
         _loc2_.boundMinX = param1.boundMinX;
         _loc2_.boundMinY = param1.boundMinY;
         _loc2_.boundMinZ = param1.boundMinZ;
         _loc2_.boundMaxX = param1.boundMaxX;
         _loc2_.boundMaxY = param1.boundMaxY;
         _loc2_.boundMaxZ = param1.boundMaxZ;
         return _loc2_;
      }
      
      private function addChild1(param1:Object3D) : void
      {
         if(param1 != null)
         {
            this.hangarContainer.addChild(param1);
         }
      }
      
      protected function createScene() : void
      {
         var _loc1_:Object3D = null;
         var _loc2_:Vector.<Object3D> = null;
         var _loc3_:Object3D = null;
         this.addChild1(this.tower);
         this.addChild1(this.tree1);
         this.addChild1(this.tree2);
         this.addChild1(this.tree3);
         this.addChild1(this.bg2);
         this.addChild1(this.tree4);
         this.addChild1(this.tree5);
         this.addChild1(this.bg);
         this.addChild1(this.window1);
         this.addChild1(this.window2);
         this.addChild1(this.window3);
         for each(_loc3_ in this.walls)
         {
            this.addChild1(_loc3_);
         }
         this.addChild1(this.floor);
         this.addChild1(this.ventilator1);
         this.addChild1(this.ventilator2);
         this.addChild1(this.ventfix);
         this.addChild1(this.firepanel);
         this.addChild1(this.electropanel);
         this.addChild1(this.girders);
         this.addChild1(this.balkl);
         this.addChild1(this.balk2);
         for each(_loc3_ in this.lamps)
         {
            this.addChild1(_loc3_);
         }
         this.addChild1(this.tops);
         this.kdTree = new KDContainer();
         this.kdTree.batched = false;
         this.kdTree.threshold = 5;
         this.addChild1(this.kdTree);
         _loc2_ = new Vector.<Object3D>();
         for each(_loc1_ in this.others)
         {
            _loc2_.push(_loc1_);
         }
         _loc2_.push(this.pandus1);
         _loc2_.push(this.pandus2);
         this.kdTree.createTree(_loc2_);
         this.createTank();
         this.createDrone(new Vector3D(100,-200,300));
         this.kdTree.addChild(this.tank);
         //this.kdTree.addChild(this.drone);
      }
      
      private function attach(param1:Mesh, param2:Mesh) : void
      {
         var _loc3_:Vector.<Face> = param1.faces;
         _loc3_[_loc3_.length - 1].next = param2.faceList;
         param2.faceList = null;
         var _loc4_:Vector.<Vertex> = param1.vertices;
         param1.vertices[_loc4_.length - 1].next = param2.vertexList;
         param2.vertexList = null;
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
         //this.drone.render();
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
         var _loc1_:BitmapData = null;
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(this.backgroundEraserTimer != null)
         {
            this.backgroundEraserTimer.stop();
            this.backgroundEraserTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onBackgroundEraserTimerComplete);
            this.backgroundEraserTimer = null;
         }
         if(this.shadowMaterial != null)
         {
            _loc1_ = this.shadowMaterial.texture;
            this.shadowMaterial.dispose();
            _loc1_.dispose();
         }
         this.hullMesh = null;
         this.innerBevel = null;
         this.rootContainer = null;
         this.cameraContainer = null;
         this.camera.view.clear();
         this.camera = null;
         this.tank.destroy();
         //this.drone.destroy();
         this.tank = null;
         //this.drone = null;
         this.shadow = null;
         if(this.kdTree != null)
         {
            this.kdTree.parent.removeChild(this.kdTree);
            this.kdTree.destroyTree();
         }
      }
      
      public function setHull(param1:Tanks3DSResource) : void
      {
         this.hullMesh = Mesh(param1.objects[0]);
         this.tank.setHull(param1);
         this.onTankPartLoaded();
         //this.drone.onHullChanged();
      }
      
      public function setTurret(param1:Tanks3DSResource) : void
      {
         this.tank.setTurret(param1);
         this.onTankPartLoaded();
      }
      
      public function setColorMap(param1:BitmapData) : void
      {
         this.tank.setColorMap(param1);
         //this.drone.setColorMap(param1);
         this.onTankPartLoaded();
      }
      
      public function setTextureAnimation(param1:MultiframeImageResource) : void
      {
         this.tank.setTextureAnimation(param1);
         //this.drone.setTextureAnimation(param1);
         this.onTankPartLoaded();
      }
      
      public function setDrone(param1:Tanks3DSResource) : void
      {
         //this.drone.set3DResource(param1);
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
            this.shadow = this.createShadow(this.hullMesh,SHADOW_DIRECTION,SHADOW_RESOLUTION,SHADOW_BLUR,SHADOW_ALPHA);
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
         var _loc25_:BitmapData = null;
         var _loc26_:Decal = null;
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
         if(this.shadowMaterial != null)
         {
            _loc25_ = this.shadowMaterial.texture;
            this.shadowMaterial.dispose();
            _loc25_.dispose();
         }
         this.shadowMaterial = _loc14_;
         if(GPUCapabilities.gpuEnabled)
         {
            _loc26_ = new Decal();
            _loc26_.createGeometry(_loc15_,true);
            _loc26_.x = _loc15_.x;
            _loc26_.y = _loc15_.y;
            _loc26_.z = _loc15_.z;
            _loc26_.alpha = _loc15_.alpha;
            return _loc26_;
         }
         return _loc15_;
      }
   }
}

