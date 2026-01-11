package alternativa.tanks.models.battle.battlefield.mine
{
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.dump.IDumpService;
   import alternativa.osgi.service.dump.IDumper;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.battle.battlefield.BattleSfx;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.models.weapon.WeaponConst;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.LightAnimation;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.utils.GraphicsUtils;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import alternativa.types.Long;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMine;
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMinesModelBase;
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.IBattleMinesModelBase;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   [ModelInfo]
   public class BattleMinesModel extends BattleMinesModelBase implements IBattleMinesModelBase, ObjectLoadListener, ObjectUnloadListener, IDumper, BattleEventListener, IMineCallback, IBattleMinesModel
   {
      
      [Inject]
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var dumperService:IDumpService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const MAIN_EXPLOSION_ORIGIN_X:Number = 0.5;
      
      private static const MAIN_EXPLOSION_ORIGIN_Y:Number = 0.772;
      
      private static const IDLE_EXPLOSION_ORIGIN_X:Number = 0.5;
      
      private static const IDLE_EXPLOSION_ORIGIN_Y:Number = 0.9;
      
      private static const MAIN_EXPLOSION_SCALE:Number = 3;
      
      private static const IDLE_EXPLOSION_SCALE:Number = 3;
      
      private static const MINE_ACTIVATION_SOUND_VOLUME:Number = 0.3;
      
      private static const DECAL_RADIUS:Number = 200;
      
      private static const projectionOrigin:Vector3 = new Vector3();
      
      private var mineModelData:MineModelData = new MineModelData();
      
      private var minesByUser:Dictionary = new Dictionary();
      
      private var minesOnField:Dictionary = new Dictionary();
      
      private var mineProximityRadius:Number;
      
      private var deferredMines:Vector.<BattleMine>;
      
      private var redMineMaterial:TextureMaterial;
      
      private var blueMineMaterial:TextureMaterial;
      
      private var friendlyMineMaterial:TextureMaterial;
      
      private var enemyMineMaterial:TextureMaterial;
      
      private var referenceMesh:Mesh;
      
      private var mainExplosionAnimation:TextureAnimation;
      
      private var mainExplosionFrameSize:FrameSize = new FrameSize();
      
      private var idleExplosionAnimation:TextureAnimation;
      
      private var idleExplosionFrameSize:FrameSize = new FrameSize();
      
      private var explosionMarkMaterial:TextureMaterial;
      
      private var mineArmedSound:Sound;
      
      private var explosionSound:Sound;
      
      private var deactivationSound:Sound;
      
      private var impactForce:Number;
      
      private var battleObject:IGameObject;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var loadedTanks:Dictionary = new Dictionary();
      
      private var localTank:Tank;
      
      private var minDistanceFromBase:Number;
      
      private var explosionLightAnimation:LightAnimation;
      
      public function BattleMinesModel()
      {
         super();
         MineExplosionCameraEffect.initVars();
         this.initBattleEventListeners();
      }
      
      private static function addExplosionEffect(param1:Vector3, param2:TextureAnimation, param3:FrameSize, param4:Number, param5:Number) : void
      {
         var _loc6_:int = 50;
         var _loc7_:ObjectPool = battleService.getObjectPool();
         var _loc8_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(_loc7_.getObject(StaticObject3DPositionProvider));
         _loc8_.init(param1,_loc6_);
         var _loc9_:AnimatedSpriteEffect = AnimatedSpriteEffect(_loc7_.getObject(AnimatedSpriteEffect));
         _loc9_.init(param3.width,param3.height,param2,0,_loc8_,param4,param5);
         battleService.getBattleScene3D().addGraphicEffect(_loc9_);
      }
      
      private static function addSound3DEffect(param1:Sound, param2:Vector3, param3:Number) : void
      {
         var _loc4_:Sound3D = null;
         if(param1 != null)
         {
            _loc4_ = Sound3D.create(param1,param3);
            battleService.getBattleRunner().getSoundManager().addEffect(Sound3DEffect.create(param2,_loc4_,0));
         }
      }
      
      private static function getExplosionAnimation(param1:MultiframeImageResource, param2:int, param3:FrameSize) : TextureAnimation
      {
         var _loc4_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(textureMaterialRegistry,param1);
         _loc4_.material.resolution = param2;
         param3.height = param1.frameHeight * param2;
         param3.width = param1.frameWidth * param2;
         return _loc4_;
      }
      
      private static function getTextureMaterial(param1:ImageResource) : TextureMaterial
      {
         return textureMaterialRegistry.getMaterial(param1.data);
      }
      
      private function initBattleEventListeners() : void
      {
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.activateHandlers();
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function getMinDistanceFromBase() : Number
      {
         return this.minDistanceFromBase;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         this.battleObject = object;
         dumperService.registerDumper(this);
         this.mineModelData.armedFlashDuration = 100;
         this.mineModelData.armedFlashFadeDuration = 300;
         this.mineModelData.flashChannelOffset = 204;
         this.mineModelData.farRadius = BattleUtils.toClientScale(getInitParam().farVisibilityRadius);
         this.mineModelData.nearRadius = BattleUtils.toClientScale(getInitParam().nearVisibilityRadius);
         this.mineProximityRadius = BattleUtils.toClientScale(getInitParam().radius);
         this.impactForce = getInitParam().impactForce;
         this.mineArmedSound = getInitParam().activateSound.sound;
         this.explosionSound = getInitParam().explosionSound.sound;
         this.deactivationSound = getInitParam().deactivateSound.sound;
         this.minDistanceFromBase = BattleUtils.toClientScale(getInitParam().minDistanceFromBase);
         this.initReferenceMesh(Tanks3DSResource(getInitParam().model3ds));
         this.mainExplosionAnimation = getExplosionAnimation(getInitParam().mainExplosionTexture,MAIN_EXPLOSION_SCALE,this.mainExplosionFrameSize);
         this.idleExplosionAnimation = getExplosionAnimation(getInitParam().idleExplosionTexture,IDLE_EXPLOSION_SCALE,this.idleExplosionFrameSize);
         this.explosionMarkMaterial = getTextureMaterial(getInitParam().explosionMarkTexture);
         this.redMineMaterial = getTextureMaterial(getInitParam().redMineTexture);
         this.blueMineMaterial = getTextureMaterial(getInitParam().blueMineTexture);
         this.friendlyMineMaterial = getTextureMaterial(getInitParam().friendlyMineTexture);
         this.enemyMineMaterial = getTextureMaterial(getInitParam().enemyMineTexture);
         var _loc1_:LightingSfx = BattleSfx(object.adapt(BattleSfx)).getLightingSfx();
         this.explosionLightAnimation = _loc1_.createAnimation("explosion");
         this.initMines(getInitParam().battleMines);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         dumperService.unregisterDumper(this.dumperName);
         this._removeAllMines();
         this.mineArmedSound = null;
         this.mainExplosionAnimation = null;
         this.idleExplosionAnimation = null;
         this.redMineMaterial = null;
         this.blueMineMaterial = null;
         this.friendlyMineMaterial = null;
         this.enemyMineMaterial = null;
         this.battleObject = null;
         this.localTank = null;
         this.explosionMarkMaterial = null;
         this.loadedTanks = new Dictionary();
      }
      
      private function initMines(param1:Vector.<BattleMine>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.length != 0)
         {
            if(this.deferredMines == null)
            {
               this.deferredMines = new Vector.<BattleMine>();
            }
            _loc2_ = int(param1.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.deferredMines.push(param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function putMine(param1:String, param2:Number, param3:Number, param4:Number, param5:String) : void
      {
         var _loc6_:Tank = this.loadedTanks[param5];
         if(_loc6_ == null)
         {
            if(this.deferredMines == null)
            {
               this.deferredMines = new Vector.<BattleMine>();
            }
         }
         else
         {
            this.addMine(param1,this.mineProximityRadius,new Vector3(param2,param3,param4),param5,_loc6_.teamType,this.getMineMaterial(_loc6_),false);
         }
      }
      
      [Obfuscation(rename="false")]
      public function activateMine(param1:String) : void
      {
         var _loc3_:BattleMine = null;
         var _loc2_:ProximityMine = this.minesOnField[param1];
         if(_loc2_ != null)
         {
            _loc2_.arm();
            addSound3DEffect(this.mineArmedSound,_loc2_.position,MINE_ACTIVATION_SOUND_VOLUME);
         }
         else
         {
            for each(_loc3_ in this.deferredMines)
            {
               if(_loc3_.mineId == param1)
               {
                  _loc3_.activated = true;
                  return;
               }
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function removeAllMines(param1:String) : void
      {
         var _loc3_:ProximityMine = null;
         var _loc4_:ProximityMine = null;
         var _loc2_:UserMinesList = this.minesByUser[param1];
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_;
               _loc3_ = _loc3_.next;
               this.playEffectAndRemoveMine(_loc4_,_loc2_);
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function removeMines(param1:String, param2:Vector.<String>) : void
      {
         var _loc4_:String = null;
         var _loc5_:ProximityMine = null;
         var _loc3_:UserMinesList = this.minesByUser[param1];
         for each(_loc4_ in param2)
         {
            _loc5_ = this.minesOnField[_loc4_];
            if(_loc5_ != null)
            {
               this.playEffectAndRemoveMine(_loc5_,_loc3_);
            }
         }
      }
      
      private function playEffectAndRemoveMine(param1:ProximityMine, param2:UserMinesList) : void
      {
         addExplosionEffect(param1.position,this.idleExplosionAnimation,this.idleExplosionFrameSize,IDLE_EXPLOSION_ORIGIN_X,IDLE_EXPLOSION_ORIGIN_Y);
         addSound3DEffect(this.deactivationSound,param1.position,0.1);
         this.removeMine(param1,param2);
      }
      
      [Obfuscation(rename="false")]
      public function explodeMine(param1:String, param2:String) : void
      {
         var _loc4_:UserMinesList = null;
         var _loc5_:Tank = null;
         var _loc3_:ProximityMine = this.minesOnField[param1];
         if(_loc3_ != null)
         {
            _loc4_ = this.minesByUser[_loc3_.ownerId];
            if(_loc4_ != null)
            {
               addExplosionEffect(_loc3_.position,this.mainExplosionAnimation,this.mainExplosionFrameSize,MAIN_EXPLOSION_ORIGIN_X,MAIN_EXPLOSION_ORIGIN_Y);
               this.addLightingEffect(_loc3_.position,this.explosionLightAnimation);
               this.addExplosionMark(_loc3_);
               addSound3DEffect(this.explosionSound,_loc3_.position,0.5);
               _loc5_ = this.loadedTanks[param2];
               if(_loc5_ != null)
               {
                  _loc5_.applyWeaponHit(_loc3_.position,_loc3_.groundNormal,WeaponConst.BASE_IMPACT_FORCE.getNumber() * this.impactForce);
               }
               this.removeMine(_loc3_,_loc4_);
            }
         }
      }
      
      private function addLightingEffect(param1:Vector3, param2:LightAnimation) : void
      {
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         var _loc4_:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         _loc3_.init(param1,50);
         _loc4_.init(_loc3_,param2);
         battleService.addGraphicEffect(_loc4_);
      }
      
      private function addExplosionMark(param1:ProximityMine) : void
      {
         projectionOrigin.copy(param1.position);
         projectionOrigin.addScaled(100,param1.groundNormal);
         battleService.getBattleScene3D().addDecal(param1.position,projectionOrigin,DECAL_RADIUS,this.explosionMarkMaterial);
      }
      
      [Obfuscation(rename="false")]
      public function dump(param1:Array) : String
      {
         var _loc3_:ProximityMine = null;
         var _loc2_:String = "=== Mines ===\n";
         if(this.deferredMines != null)
         {
            _loc2_ += "Deferred:\n" + this.deferredMines.join("\n") + "\n";
         }
         _loc2_ += "On field:\n";
         for each(_loc3_ in this.minesOnField)
         {
            _loc2_ += _loc3_ + "\n";
         }
         return _loc2_;
      }
      
      [Obfuscation(rename="false")]
      public function get dumperName() : String
      {
         return "mines";
      }
      
      public function onTouchMine(param1:ProximityMine) : void
      {
         battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      }
      
      private function addMine(param1:String, param2:Number, param3:Vector3, param4:String, param5:BattleTeam, param6:Material, param7:Boolean) : void
      {
         var _loc9_:UserMinesList = null;
         var _loc10_:ProximityMine = null;
         var _loc8_:RayHit = new RayHit();
         if(battleService.getBattleRunner().getCollisionDetector().raycastStatic(param3,Vector3.DOWN,CollisionGroup.STATIC,10000000000,null,_loc8_))
         {
            _loc9_ = this.minesByUser[param4];
            if(_loc9_ == null)
            {
               _loc9_ = new UserMinesList();
               this.minesByUser[param4] = _loc9_;
            }
            _loc10_ = ProximityMine.create(param1,param4,param2,this.referenceMesh,param6,param5,this.mineModelData,this);
            _loc10_.setPosition(_loc8_.position,_loc8_.normal);
            if(param7)
            {
               _loc10_.arm();
            }
            _loc9_.addMine(_loc10_);
            this.minesOnField[param1] = _loc10_;
            _loc10_.addToGame();
         }
      }
      
      private function _removeAllMines() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:ProximityMine = null;
         var _loc3_:UserMinesList = null;
         for(_loc1_ in this.minesOnField)
         {
            _loc2_ = this.minesOnField[_loc1_];
            _loc2_.removeFromGame();
            delete this.minesOnField[_loc1_];
         }
         for(_loc1_ in this.minesByUser)
         {
            _loc3_ = this.minesByUser[_loc1_];
            _loc3_.clearMines();
            delete this.minesByUser[_loc1_];
         }
         this.deferredMines = null;
      }
      
      private function initReferenceMesh(param1:Tanks3DSResource) : void
      {
         this.referenceMesh = Mesh(param1.objects[0]);
         if(this.referenceMesh.sorting != Sorting.AVERAGE_Z)
         {
            this.referenceMesh.sorting = Sorting.AVERAGE_Z;
            this.referenceMesh.calculateFacesNormals(true);
         }
      }
      
      private function removeMine(param1:ProximityMine, param2:UserMinesList) : void
      {
         delete this.minesOnField[param1.id];
         param1.removeFromGame();
         param2.removeMine(param1);
      }
      
      private function getMineMaterial(param1:Tank) : Material
      {
         switch(param1.teamType)
         {
            case BattleTeam.NONE:
               return param1 == this.localTank ? this.friendlyMineMaterial : this.enemyMineMaterial;
            case BattleTeam.BLUE:
               return this.blueMineMaterial;
            case BattleTeam.RED:
               return this.redMineMaterial;
            default:
               return this.enemyMineMaterial;
         }
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         this.loadedTanks[param1.tank.getUser().id] = param1.tank;
         if(param1.isLocal)
         {
            this.localTank = param1.tank;
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         delete this.loadedTanks[param1.tank.getUser().id];
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         if(param1.tank == this.localTank)
         {
            this.addReadyMinesToField();
         }
         else
         {
            this.addOwnerMinesToField(param1.tank);
         }
      }
      
      private function addReadyMinesToField() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BattleMine = null;
         var _loc3_:Tank = null;
         var _loc4_:Vector3 = null;
         if(this.deferredMines != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.deferredMines.length)
            {
               _loc2_ = this.deferredMines[_loc1_];
               _loc3_ = this.loadedTanks[_loc2_.ownerId];
               if(_loc3_ != null)
               {
                  this.deferredMines.splice(_loc1_,1);
                  _loc1_--;
                  _loc4_ = BattleUtils.getVector3(_loc2_.position);
                  this.addMine(_loc2_.mineId,this.mineProximityRadius,_loc4_,_loc2_.ownerId,_loc3_.teamType,this.getMineMaterial(_loc3_),_loc2_.activated);
               }
               _loc1_++;
            }
         }
      }
      
      private function addOwnerMinesToField(param1:Tank) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BattleMine = null;
         var _loc4_:Vector3 = null;
         if(this.deferredMines != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this.deferredMines.length)
            {
               _loc3_ = this.deferredMines[_loc2_];
               if(_loc3_.ownerId == param1.getUserId())
               {
                  this.deferredMines.splice(_loc2_,1);
                  _loc2_--;
                  _loc4_ = BattleUtils.getVector3(_loc3_.position);
                  this.addMine(_loc3_.mineId,this.mineProximityRadius,_loc4_,_loc3_.ownerId,param1.teamType,this.getMineMaterial(param1),_loc3_.activated);
               }
               _loc2_++;
            }
         }
      }
      
      [Obfuscation(rename="false")]
      private function onBattleFinish(param1:BattleFinishEvent) : void
      {
         this._removeAllMines();
      }
   }
}

