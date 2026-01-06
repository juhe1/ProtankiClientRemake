package alternativa.tanks.battle.scene3d
{
   import alternativa.engine3d.containers.KDContainer;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.engine3d.core.Shadow;
   import alternativa.engine3d.core.View;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.*;
   import alternativa.tanks.battle.hidablegraphicobjects.HidableGraphicObjects;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Object3DContainerProxy;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.battle.utils.Queue;
   import alternativa.tanks.camera.CameraController;
   import alternativa.tanks.camera.DummyCameraController;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.battle.battlefield.map.Billboards;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import projects.tanks.client.battlefield.models.map.DustParams;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   
   public class BattleScene3D
   {
      
      private static const MAX_TEMPORARY_DECALS:int = 10;
      
      private static const DECAL_FADING_TIME_MS:int = 20000;
      
      private static const _origin3D:Vector3D = new Vector3D();
      
      private static const _direction3D:Vector3D = new Vector3D();
      
      private var rootContainer:Object3DContainer;
      
      private var skyboxContainer:Object3DContainer;
      
      private var mainContainer:Object3DContainer;
      
      private var frontContainer:Object3DContainer;
      
      private var mapContainer:Object3DContainer;
      
      private var mapContainerProxy:Object3DContainerProxy = new Object3DContainerProxy();
      
      private var frontContainerProxy:Object3DContainerProxy;
      
      private const excludedObjects:Dictionary = new Dictionary();
      
      private const shaftRaycastExcludedObjects:Dictionary = new Dictionary();
      
      private var camera:GameCamera;
      
      private var renderGroups:Vector.<RenderGroup> = Vector.<RenderGroup>([new RenderGroup(),new RenderGroup()]);
      
      private var cameraController:CameraController = DummyCameraController.INSTANCE;
      
      private var effects:Vector.<GraphicEffect> = new Vector.<GraphicEffect>();
      
      private var numEffects:int;
      
      private var userTitleRenderer:UserTitleRenderer;
      
      private const temporaryDecals:Queue = new Queue();
      
      private const allDecals:Dictionary = new Dictionary();
      
      private var fadingDecalRenderer:FadingDecalsRenderer;
      
      private const fpsCounter:FPSCounter = new FPSCounter(100);
      
      private var decalFactory:DecalFactory;
      
      private var fog:Fog;
      
      private var ambientShadows:AmbientShadows;
      
      private var lighting:Lighting;
      
      private var performanceController:PerformanceControllerWithThrottling;
      
      public const hidableGraphicObjects:HidableGraphicObjects = new HidableGraphicObjects();
      
      private var stage:Stage;
      
      private var dustEngine:Dust;
      
      private var billboards:Billboards;
      
      private var materialRegistry:TextureMaterialRegistry;
      
      private var shadowMapCorrectionFactor:Number;
      
      private var debugCommands:BattleScene3DDebugCommands;
      
      private var renderingEnabled:Boolean;
      
      private var tanks:Vector.<Tank> = new Vector.<Tank>();
      
      public function BattleScene3D(param1:Stage, param2:TextureMaterialRegistry, param3:Number)
      {
         super();
         this.materialRegistry = param2;
         this.stage = param1;
         this.shadowMapCorrectionFactor = param3;
         this.initContainers();
         this.createCamera();
         this.createFadingDecalsRenderer();
         this.billboards = new Billboards();
         this.fog = new Fog(this.camera);
         this.ambientShadows = new AmbientShadows(this.camera);
         this.lighting = new Lighting(this.camera);
      }
      
      public function getFrontContainer() : Scene3DContainer
      {
         return this.frontContainerProxy;
      }
      
      public function getMapContainer() : Scene3DContainer
      {
         return this.mapContainerProxy;
      }
      
      public function setCameraView(param1:View) : void
      {
         this.camera.view = param1;
      }
      
      public function addMarker(param1:Number, param2:uint, param3:Number, param4:Number, param5:Number) : void
      {
      }
      
      public function enableObjectHiding() : void
      {
         this.addRenderer(this.hidableGraphicObjects,0);
      }
      
      public function initDustEngine(param1:BattleService, param2:DustParams) : void
      {
         this.dustEngine = new Dust(param1);
         this.dustEngine.init(param2.dustParticle,this.materialRegistry,param2.dustFarDistance,param2.dustNearDistance,param2.dustSize,param2.alpha,param2.density);
      }
      
      public function getDustEngine() : Dust
      {
         return this.dustEngine;
      }
      
      public function disableObjectHiding() : void
      {
         this.removeRenderer(this.hidableGraphicObjects,0);
         this.hidableGraphicObjects.restore();
      }
      
      public function enableAutoQuality(param1:Boolean, param2:String) : void
      {
         if(param1)
         {
            if(this.performanceController == null)
            {
               this.enableAmbientShadows(true);
               this.enableDynamicShadows(true);
               this.enableFog(true);
               this.enableSoftTransparency(true);
               this.enableDust(true);
               this.enableSSAO(true);
               this.enableLighting(true);
               this.enableDynamicLighting(true);
               this.enableAntialiasing(true);
               this.performanceController = new PerformanceControllerWithThrottling();
               this.performanceController.start1(this.stage,this.camera,param2);
            }
         }
         else if(this.performanceController != null)
         {
            this.performanceController.stop();
            this.performanceController = null;
         }
      }
      
      public function setupFog(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         this.fog.setup(param1,param2,param3,param4);
      }
      
      public function setupDynamicShadows(param1:int, param2:int, param3:Number, param4:Number) : void
      {
         this.lighting.setup(param1,param2,param3,param4);
      }
      
      public function enableAmbientShadows(param1:Boolean) : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            if(param1)
            {
               this.ambientShadows.enable();
            }
            else
            {
               this.ambientShadows.disable();
            }
         }
      }
      
      public function enableDynamicShadows(param1:Boolean) : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            if(param1)
            {
               this.lighting.enableShadows();
            }
            else
            {
               this.lighting.disableShadows();
            }
         }
      }
      
      public function enableFog(param1:Boolean) : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            if(param1)
            {
               this.fog.enable();
            }
            else
            {
               this.fog.disable();
            }
         }
      }
      
      public function toggleFog() : void
      {
         this.enableFog(this.camera.fogAlpha == 0);
      }
      
      public function setDecalFactory(param1:DecalFactory) : void
      {
         this.decalFactory = param1;
      }
      
      public function addDecalsToExclusionSet(param1:Dictionary) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.allDecals)
         {
            param1[_loc2_] = true;
         }
      }
      
      public function addObjectToExclusion(param1:Object3D) : void
      {
         this.excludedObjects[param1] = true;
      }
      
      public function removeObjectFromExclusion(param1:Object3D) : void
      {
         delete this.excludedObjects[param1];
      }
      
      public function getExcludedObjects() : Dictionary
      {
         return this.excludedObjects;
      }
      
      public function getShaftRaycastExcludedObjects() : Dictionary
      {
         return this.shaftRaycastExcludedObjects;
      }
      
      private function initContainers() : void
      {
         this.rootContainer = new Object3DContainer();
         this.rootContainer.addChild(this.skyboxContainer = new Object3DContainer());
         this.rootContainer.addChild(this.mainContainer = new Object3DContainer());
         this.rootContainer.addChild(this.frontContainer = new Object3DContainer());
         this.frontContainerProxy = new Object3DContainerProxy(this.frontContainer);
      }
      
      private function createCamera() : void
      {
         this.camera = new GameCamera();
         this.camera.ssaoRadius = 400;
         this.camera.ssaoRange = 1200;
         this.camera.ssaoColor = 0;
         this.camera.ssaoAlpha = 1.4;
         this.camera.addToDebug(Debug.BOUNDS,Object3D);
         this.camera.addToDebug(Debug.EDGES,Object3D);
         this.rootContainer.addChild(this.camera);
      }
      
      public function setSSAOColor(param1:uint) : void
      {
         this.camera.ssaoColor = param1;
      }
      
      private function createFadingDecalsRenderer() : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            this.fadingDecalRenderer = new FadingDecalsRenderer(DECAL_FADING_TIME_MS);
            this.addRenderer(this.fadingDecalRenderer,0);
         }
      }
      
      public function addAmbientShadow(param1:Shadow) : void
      {
         this.ambientShadows.add(param1);
      }
      
      public function removeAmbientShadow(param1:Shadow) : void
      {
         this.ambientShadows.remove(param1);
      }
      
      public function addTurret(param1:TurretSkin) : void
      {
         this.addObject(param1.getTurret3D());
      }
      
      public function removeTurret(param1:TurretSkin) : void
      {
         this.removeObject(param1.getTurret3D());
      }
      
      public function setDebug(param1:Boolean) : void
      {
         this.camera.debug = param1;
      }
      
      public function isDebug() : Boolean
      {
         return this.camera.debug;
      }
      
      public function enableRendering() : void
      {
         this.renderingEnabled = true;
      }
      
      public function disableRendering() : void
      {
         this.renderingEnabled = false;
      }
      
      public function setUserTitleRenderer(param1:UserTitleRenderer) : void
      {
         this.userTitleRenderer = param1;
      }
      
      public function addTank(param1:Tank) : void
      {
         this.tanks.push(param1);
      }
      
      public function removeTank(param1:Tank) : void
      {
         var _loc2_:int = int(this.tanks.indexOf(param1));
         if(_loc2_ != -1)
         {
            this.tanks.splice(_loc2_,1);
         }
      }
      
      public function addRenderer(param1:Renderer, param2:int = 0) : void
      {
         var _loc3_:RenderGroup = this.renderGroups[param2];
         _loc3_.addRenderer(param1);
      }
      
      public function removeRenderer(param1:Renderer, param2:int = 0) : void
      {
         var _loc3_:RenderGroup = this.renderGroups[param2];
         _loc3_.removeRenderer(param1);
      }
      
      public function addGraphicEffect(param1:GraphicEffect) : void
      {
         if(param1 == null)
         {
            throw new ArgumentError();
         }
         this.effects[this.numEffects++] = param1;
         param1.addedToScene(this.mapContainerProxy);
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         if(this.renderingEnabled)
         {
            this.fpsCounter.update();
            this.ambientShadows.adjustDistances(this.fpsCounter.getFPS());
            this.dustEngine.update();
            this.renderTanks(param1,param2);
            this.cameraController.update(param1,param2);
            this.camera.calculateAdditionalData();
            this.runRenderers(param1,param2);
            this.updateEffects(param2);
            if(this.userTitleRenderer != null)
            {
               this.userTitleRenderer.renderUserTitles();
            }
            _loc3_ = this.camera.shadowMap != null ? Number(this.camera.shadowMapStrength) : 0;
            if(this.camera.directionalLight != null)
            {
               this.camera.directionalLight.intensity = this.shadowMapCorrectionFactor + _loc3_ * (1 - this.shadowMapCorrectionFactor);
            }
            this.camera.render();
         }
      }
      
      private function renderTanks(param1:int, param2:int) : void
      {
         var _loc3_:Tank = null;
         for each(_loc3_ in this.tanks)
         {
            _loc3_.render(param1,param2);
         }
      }
      
      private function updateEffects(param1:int) : void
      {
         var _loc3_:GraphicEffect = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.numEffects)
         {
            _loc3_ = this.effects[_loc2_];
            if(!_loc3_.play(param1,this.camera))
            {
               _loc3_.destroy();
               this.effects[_loc2_--] = this.effects[--this.numEffects];
               this.effects[this.numEffects] = null;
            }
            _loc2_++;
         }
      }
      
      public function getCamera() : GameCamera
      {
         return this.camera;
      }
      
      public function setSkyBox(param1:Object3D) : void
      {
         if(this.skyboxContainer.numChildren > 0)
         {
            this.skyboxContainer.removeChildAt(0);
         }
         this.skyboxContainer.addChild(param1);
      }
      
      public function enableSSAO(param1:Boolean) : void
      {
         this.camera.ssao = param1;
      }
      
      public function setMapContainer(param1:Object3DContainer) : void
      {
         if(this.mapContainer != null)
         {
            this.mainContainer.removeChild(this.mapContainer);
            this.mapContainer = null;
         }
         this.mapContainerProxy.setContainer(param1);
         this.mapContainer = param1;
         if(this.mapContainer != null)
         {
            this.mainContainer.addChild(this.mapContainer);
            this.camera.farClipping = 1.5 * this.getBoundSphereDiameter(this.mapContainer);
         }
      }
      
      public function getBoundSphereDiameter(param1:Object3D) : Number
      {
         var _loc2_:Number = param1.boundMaxX - param1.boundMinX;
         var _loc3_:Number = param1.boundMaxY - param1.boundMinY;
         var _loc4_:Number = param1.boundMaxZ - param1.boundMinZ;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      public function addObject(param1:Object3D) : void
      {
         this.mapContainerProxy.addChild(param1);
         if(param1.name != Object3DNames.STATIC && param1.name != Object3DNames.TANK_PART)
         {
            this.shaftRaycastExcludedObjects[param1] = true;
         }
      }
      
      public function removeObject(param1:Object3D) : void
      {
         this.mapContainerProxy.removeChild(param1);
         if(param1.name != Object3DNames.STATIC && param1.name != Object3DNames.TANK_PART)
         {
            delete this.shaftRaycastExcludedObjects[param1];
         }
      }
      
      public function raycast(param1:Vector3, param2:Vector3, param3:Dictionary, param4:Camera3D = null) : RayIntersectionData
      {
         var _loc6_:Object3D = null;
         BattleUtils.copyToVector3D(param1,_origin3D);
         BattleUtils.copyToVector3D(param2,_direction3D);
         var _loc5_:RayIntersectionData = this.mapContainer.intersectRay(_origin3D,_direction3D,param3,param4);
         if(Boolean(_loc5_))
         {
            _loc6_ = _loc5_.object;
            while(_loc6_ != null && !_loc6_.mouseEnabled)
            {
               _loc6_ = _loc6_.parent;
            }
            _loc5_.object = _loc6_;
         }
         return _loc5_;
      }
      
      public function setSkyBoxVisible(param1:Boolean) : void
      {
         var _loc2_:Object3D = this.getSkyBox();
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function isSkyBoxVisible() : Boolean
      {
         var _loc1_:Object3D = this.getSkyBox();
         if(_loc1_ != null)
         {
            return _loc1_.visible;
         }
         return false;
      }
      
      public function addDecal(param1:Vector3, param2:Vector3, param3:Number, param4:TextureMaterial, param5:RotationState = null) : void
      {
         var _loc6_:Decal = this.createDecal(param1,param2,param3,param4,param5);
         if(_loc6_ != null)
         {
            this.temporaryDecals.put(_loc6_);
            if(this.temporaryDecals.getSize() > MAX_TEMPORARY_DECALS)
            {
               this.fadingDecalRenderer.add(this.temporaryDecals.pop());
            }
         }
      }
      
      public function addPermanentDecal(param1:Vector3, param2:Vector3, param3:Number, param4:TextureMaterial) : Decal
      {
         return this.createDecal(param1,param2,param3,param4);
      }
      
      private function createDecal(param1:Vector3, param2:Vector3, param3:Number, param4:TextureMaterial, param5:RotationState = null) : Decal
      {
         var _loc6_:Decal = null;
         if(param5 == null)
         {
            param5 = RotationState.USE_RANDOM_ROTATION;
         }
         if(Boolean(GPUCapabilities.gpuEnabled) && this.mapContainer is KDContainer)
         {
            _loc6_ = this.decalFactory.createDecal(param1,param2,param3,param4,KDContainer(this.mapContainer),param5);
            this.mapContainerProxy.addChildAt(_loc6_,0);
            this.allDecals[_loc6_] = true;
            this.addObjectToExclusion(_loc6_);
            this.shaftRaycastExcludedObjects[_loc6_] = true;
            return _loc6_;
         }
         return null;
      }
      
      public function removeDecal(param1:Decal) : void
      {
         if(param1 != null && Boolean(GPUCapabilities.gpuEnabled))
         {
            this.mapContainerProxy.removeChild(param1);
            this.removeObjectFromExclusion(param1);
            delete this.shaftRaycastExcludedObjects[param1];
            delete this.allDecals[param1];
         }
      }
      
      public function setCameraController(param1:CameraController) : void
      {
         this.cameraController = param1 == null ? DummyCameraController.INSTANCE : param1;
      }
      
      public function getCameraController() : CameraController
      {
         return this.cameraController;
      }
      
      private function getSkyBox() : Object3D
      {
         if(this.skyboxContainer.numChildren == 0)
         {
            return null;
         }
         return this.skyboxContainer.getChildAt(0);
      }
      
      private function runRenderers(param1:int, param2:int) : void
      {
         var _loc3_:RenderGroup = null;
         for each(_loc3_ in this.renderGroups)
         {
            _loc3_.render(param1,param2);
         }
      }
      
      public function shutdown() : void
      {
         if(this.cameraController != null)
         {
            this.cameraController.deactivate();
         }
         this.enableAutoQuality(false,"");
         this.clearContainer(this.skyboxContainer);
         this.clearContainer(this.mainContainer);
         this.clearContainer(this.frontContainer);
         this.clearContainer(this.rootContainer);
         this.hidableGraphicObjects.clear();
      }
      
      private function clearContainer(param1:Object3DContainer) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      public function enableSoftTransparency(param1:Boolean) : void
      {
         this.camera.softTransparency = param1;
      }
      
      public function enableDust(param1:Boolean) : void
      {
         this.getDustEngine().enabled = param1;
      }
      
      public function toggleDynamicShadows() : void
      {
         this.lighting.toggle();
      }
      
      public function addBillboard(param1:Mesh) : void
      {
         this.billboards.add(param1);
      }
      
      public function setBillboardImage(param1:BitmapData) : void
      {
         this.billboards.setImage(param1);
      }
      
      public function enableLighting(param1:Boolean) : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            if(param1)
            {
               this.lighting.enableLighting();
            }
            else
            {
               this.lighting.disableLighting();
            }
         }
      }
      
      public function enableDynamicLighting(param1:Boolean) : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            this.camera.deferredLighting = param1;
         }
      }
      
      public function enableAntialiasing(param1:Boolean) : void
      {
         if(GPUCapabilities.gpuEnabled)
         {
            this.camera.view.antiAliasEnabled = param1;
         }
      }
      
      public function getMapMinZ() : Number
      {
         return this.mapContainer == null ? 0 : Number(this.mapContainer.boundMinZ);
      }
   }
}

