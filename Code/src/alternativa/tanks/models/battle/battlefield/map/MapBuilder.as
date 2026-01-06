package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.engine3d.containers.KDContainer;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.primitives.CollisionRect;
   import alternativa.physics.collision.primitives.CollisionTriangle;
   import alternativa.physics.collision.types.AABB;
   import alternativa.proplib.PropLibRegistry;
   import alternativa.tanks.battle.BattleRunner;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.hidablegraphicobjects.HidableObject3DWrapper;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.sfx.christmas.ChristmasTreeToyEffect;
   import alternativa.tanks.utils.DataValidator;
   import alternativa.tanks.utils.StaticCollisionBoxValidator;
   import alternativa.tanks.utils.StaticCollisionTriangleValidator;
   import alternativa.tanks.utils.StaticCollisoinRectValidator;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class MapBuilder implements AutoClosable
   {
      
      [Inject]
      public static var dataValidator:DataValidator;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var commandService:CommandService;
      
      private static const conMapDelay:ConsoleVarInt = new ConsoleVarInt("map_delay",0,0,600);
      
      private static const KDTREE_THRESHOLD:Number = 0.1;
      
      private static const TEXTURE_BUILDER_BATCH_SIZE:int = 20;
      
      private var materialRegistry:TextureMaterialRegistry;
      
      private var propLibRegistry:PropLibRegistry;
      
      private var texturesBuilder:MapTexturesBuilder;
      
      private var mapContainer:KDContainer;
      
      private var buildCompleteCallback:Function;
      
      private var mapBounds:AABB;
      
      private var textures:Vector.<BitmapData>;
      
      private var mapGeometryParser:MapGeometryParser;
      
      private var completeTimeoutId:uint;
      
      private var texturesReady:Boolean;
      
      private var isComplete:Boolean;
      
      public function MapBuilder(param1:TextureMaterialRegistry, param2:PropLibRegistry)
      {
         super();
         this.materialRegistry = param1;
         this.propLibRegistry = param2;
      }
      
      private function forceComplete(param1:FormattedOutput) : void
      {
      }
      
      public function getMapContainer() : Object3DContainer
      {
         return this.mapContainer;
      }
      
      public function build(param1:XML, param2:Function) : void
      {
         this.buildCompleteCallback = param2;
         this.initPhysicsGeometry(param1);
         this.parseMapGeometry(param1);
         this.buildTextures();
      }
      
      private function initPhysicsGeometry(param1:XML) : void
      {
         var _loc2_:Vector.<CollisionShape> = CollisionGeometryParser.parse(param1);
         var _loc3_:BattleRunner = battleService.getBattleRunner();
         _loc3_.initStaticGeometry(_loc2_);
         this.addMapValidators(_loc2_);
      }
      
      private function addMapValidators(param1:Vector.<CollisionShape>) : void
      {
         var _loc2_:CollisionShape = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_ is CollisionBox)
            {
               dataValidator.addValidator(new StaticCollisionBoxValidator(CollisionBox(_loc2_)));
            }
            else if(_loc2_ is CollisionRect)
            {
               dataValidator.addValidator(new StaticCollisoinRectValidator(CollisionRect(_loc2_)));
            }
            else if(_loc2_ is CollisionTriangle)
            {
               dataValidator.addValidator(new StaticCollisionTriangleValidator(CollisionTriangle(_loc2_)));
            }
         }
      }
      
      private function parseMapGeometry(param1:XML) : void
      {
         this.mapGeometryParser = new MapGeometryParser(this.propLibRegistry);
         this.mapGeometryParser.parse(param1);
         this.mapBounds = this.mapGeometryParser.getMapBounds();
      }
      
      private function buildTextures() : void
      {
         this.texturesBuilder = new MapTexturesBuilder(this.materialRegistry,TEXTURE_BUILDER_BATCH_SIZE);
         this.texturesBuilder.addEventListener(Event.COMPLETE,this.onTexturesReady);
         this.texturesBuilder.run(this.mapGeometryParser.getTexturedPropsCollections());
      }
      
      private function onTexturesReady(param1:Event) : void
      {
         var _loc2_:int = 0;
         this.texturesReady = true;
         this.texturesBuilder.removeEventListener(Event.COMPLETE,this.onTexturesReady);
         this.completeTimeoutId = setTimeout(this.complete,_loc2_);
      }
      
      private function complete() : void
      {
         this.isComplete = true;
         clearTimeout(this.completeTimeoutId);
         this.textures = this.texturesBuilder.getTextures();
         this.setupChristmasTree();
         this.createMap();
         this.setupBillboards();
         this.setupChristmasTreeToys();
         this.mapGeometryParser.clear();
         this.mapGeometryParser = null;
         this.texturesBuilder = null;
         this.materialRegistry = null;
         this.propLibRegistry = null;
         this.buildCompleteCallback();
      }
      
      private function setupChristmasTree() : void
      {
         if(this.mapGeometryParser.getChristmasTree() == null)
         {
            return;
         }
         (this.mapGeometryParser.getChristmasTree() as BSP).faces[0].material.alphaTestThreshold = 0.5;
      }
      
      private function setupChristmasTreeToys() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object3D = null;
         var _loc6_:Vector3 = null;
         var _loc7_:Vector3 = null;
         var _loc8_:StaticObject3DPositionProvider = null;
         var _loc9_:ChristmasTreeToyEffect = null;
         if(this.mapGeometryParser.getChristmasTree() == null)
         {
            return;
         }
         var _loc3_:Vector.<Object3D> = this.mapGeometryParser.getChristmasTreeToys();
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:ObjectPool = battleService.getObjectPool();
         _loc6_ = new Vector3();
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc1_];
            _loc6_.x += _loc2_.x;
            _loc6_.y += _loc2_.y;
            _loc6_.z += _loc2_.z;
            _loc1_++;
         }
         _loc6_.x /= _loc4_;
         _loc6_.y /= _loc4_;
         _loc6_.z /= _loc4_;
         _loc7_ = new Vector3();
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc1_];
            _loc7_.x = _loc2_.x;
            _loc7_.y = _loc2_.y;
            _loc7_.z = _loc2_.z;
            _loc8_ = StaticObject3DPositionProvider(_loc5_.getObject(StaticObject3DPositionProvider));
            _loc8_.init(_loc7_,150);
            _loc9_ = ChristmasTreeToyEffect(_loc5_.getObject(ChristmasTreeToyEffect));
            _loc9_.init(_loc2_ as Sprite3D,_loc8_,_loc6_);
            battleService.getBattleScene3D().addGraphicEffect(_loc9_);
            _loc1_++;
         }
      }
      
      private function createMap() : void
      {
         var _loc3_:Object3D = null;
         this.mapContainer = new KDContainer();
         this.mapContainer.threshold = KDTREE_THRESHOLD;
         this.mapContainer.ignoreChildrenInCollider = true;
         var _loc1_:Vector.<Object3D> = this.mapGeometryParser.getObjects();
         _loc1_.push(new HelperMesh());
         this.mapContainer.createTree(_loc1_,this.mapGeometryParser.getOccluders());
         var _loc2_:BattleScene3D = battleService.getBattleScene3D();
         for each(_loc3_ in this.mapGeometryParser.getSprites())
         {
            this.mapContainer.addChild(_loc3_);
            _loc2_.hidableGraphicObjects.add(new HidableObject3DWrapper(_loc3_));
         }
         this.mapContainer.calculateBounds();
         _loc2_.setMapContainer(this.mapContainer);
      }
      
      private function setupBillboards() : void
      {
         var _loc3_:Mesh = null;
         var _loc1_:Vector.<Mesh> = this.mapGeometryParser.getBillboards();
         var _loc2_:BattleScene3D = battleService.getBattleScene3D();
         for each(_loc3_ in _loc1_)
         {
            _loc2_.addBillboard(_loc3_);
         }
      }
      
      public function getMapBounds() : AABB
      {
         return this.mapBounds;
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         clearTimeout(this.completeTimeoutId);
         if(this.mapContainer != null)
         {
            this.mapContainer.destroyTree();
            this.mapContainer = null;
         }
         if(this.texturesBuilder != null)
         {
            this.texturesBuilder.removeEventListener(Event.COMPLETE,this.onTexturesReady);
            this.texturesBuilder.destroy();
            this.texturesBuilder = null;
         }
         if(this.mapGeometryParser != null)
         {
            this.mapGeometryParser.clear();
            this.mapGeometryParser = null;
         }
         this.buildCompleteCallback = null;
         this.disposeTextures();
      }
      
      private function disposeTextures() : void
      {
         var _loc2_:BitmapData = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.textures)
         {
            _loc2_.dispose();
            _loc1_++;
         }
         this.textures = null;
      }
   }
}

