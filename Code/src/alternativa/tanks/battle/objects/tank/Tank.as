package alternativa.tanks.battle.objects.tank
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.FillMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.primitives.Box;
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.PhysicsScene;
   import alternativa.physics.PhysicsUtils;
   import alternativa.physics.collision.BodyCollisionFilter;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleRunner;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.Dust;
   import alternativa.tanks.battle.PhysicsController;
   import alternativa.tanks.battle.PhysicsInterpolator;
   import alternativa.tanks.battle.PostPhysicsController;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.objects.tank.controllers.CameraTargetMode;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingMode;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.battle.objects.tank.tankchassis.SuspensionParams;
   import alternativa.tanks.battle.objects.tank.tankchassis.Track;
   import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
   import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.TracksAnimator;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretGeometryItem;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.camera.CameraTarget;
   import alternativa.tanks.display.usertitle.UserTitle;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.BasicGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponUtils;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TankBody;
   import alternativa.tanks.physics.TankBodyIdProvider;
   import alternativa.tanks.services.targeting.TargetingModeService;
   import alternativa.tanks.sfx.TankSoundEffects;
   import alternativa.tanks.sfx.floatingmessage.FloatingTextEffect;
   import alternativa.tanks.utils.CircularObjectBuffer;
   import alternativa.tanks.utils.DataUnitValidator;
   import alternativa.tanks.utils.DataValidationErrorEvent;
   import alternativa.tanks.utils.MathUtils;
   import flash.display.BitmapData;
   import flash.geom.Vector3D;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class Tank implements PhysicsController, PostPhysicsController, PhysicsInterpolator, Renderer, BodyCollisionFilter, CameraTarget, WeaponPlatform
   {
      
      public static var logService:LogService;
      
      public static var targetingModeService:TargetingModeService;
      
      private static const _v:Vector3 = new Vector3();
      
      private static const _m:Matrix3 = new Matrix3();
      
      private static const _rayOrigin:Vector3 = new Vector3();
      
      private static const _rayVector:Vector3 = new Vector3();
      
      private static const _point:Vector3 = new Vector3();
      
      private static const _rayHit:RayHit = new RayHit();
      
      private static const _m41:Matrix4 = new Matrix4();
      
      private static const _m42:Matrix4 = new Matrix4();
      
      private static const _tankPosition:Vector3 = new Vector3();
      
      private static const _tankDirection:Vector3 = new Vector3();
      
      private static const _upDirection:Vector3 = new Vector3();
      
      private static const _projYToPlane:Vector3 = new Vector3();
      
      private static const _projXToPlane:Vector3 = new Vector3();
      
      public var user:IGameObject;
      
      public var health:Number = 0;
      
      public var state:ClientTankState;
      
      public var prevState:ClientTankState;
      
      private var _teamType:BattleTeam;
      
      private var _incarnation:int;
      
      private var weapon:Weapon;
      
      private var _turretController:TurretController;
      
      private var localTurretController:LocalTurretController;
      
      private var battleService:BattleService;
      
      private var tankBody:TankBody;
      
      private var collisionCount:int;
      
      private var skin:TankSkin;
      
      private var maxSpeedSmoother:ValueSmoother = new EncryptedValueSmoother(100,1000,0,0);
      
      private var maxTurnSpeedSmoother:ValueSmoother = new EncryptedValueSmoother(0.3,10,0,0);
      
      private var suspensionParams:SuspensionParams = new SuspensionParams();
      
      internal var skinCenterOffset:Vector3 = new Vector3();
      
      private var visibilityPoints:Vector.<Vector3>;
      
      internal var interpolatedPosition:Vector3 = new Vector3();
      
      internal var interpolatedOrientation:Quaternion = new Quaternion();
      
      private var interpolatedTurretDirection:Number = 0;
      
      private var validator:TankDataValidator;
      
      private var chassis:TrackedChassis;
      
      private var tracksAnimator:TracksAnimator;
      
      private var title:UserTitle;
      
      private var sounds:TankSoundEffects;
      
      private var bodyStateValidator:BodyPhysicsStateValidator;
      
      private var battleEventDispatcher:BattleEventDispatcher;
      
      private var halfLength:Number;
      
      private var savedBodyState:BodyState = new BodyState();
      
      private var floatingTextEffect:FloatingTextEffect;
      
      private var temperature:Number = 0;
      
      private var maxHealth:int;
      
      private var hullTransformUpdater:HullTransformUpdater;
      
      private var boundSphereRadius:Number;
      
      private var logBuffer:CircularObjectBuffer;
      
      private var inBattle:Boolean;
      
      private var tankDirection:Number;
      
      public var lastHitPoint:Vector3 = new Vector3();
      
      public var isLastHitPointSet:Boolean;
      
      public var turretCollisions:Vector.<CollisionBox> = new Vector.<CollisionBox>();
      
      public function Tank(param1:IGameObject, param2:Number, param3:Number, param4:TankSoundEffects, param5:TankSkin, param6:TurretController, param7:LocalTurretController, param8:Weapon, param9:UserTitle, param10:BattleEventDispatcher, param11:int)
      {
         super();
         this.user = param1;
         this.skin = param5;
         this.sounds = param4;
         this.battleEventDispatcher = param10;
         this.maxHealth = param11;
         this.suspensionParams.dampingCoeff = param3;
         param4.setTank(this);
         var _loc12_:Vector3 = calculateSizeForMesh(param5.getHullDescriptor().mesh);
         var _loc13_:Vector3 = new Vector3(_loc12_.x / 2,_loc12_.y / 2,_loc12_.z / 2);
         this.halfLength = _loc13_.y;
         this.calculateSkinCenterOffset(_loc12_);
         this.createBody(param2,_loc13_);
         this.createCollisionPrimitives(_loc13_);
         this.createVisibilityPoints(_loc13_);
         this.initTurretGeometry(param5);
         this.chassis = new TrackedChassis(this.tankBody.body,this.suspensionParams,this.maxSpeedSmoother,_loc12_);
         this.tracksAnimator = new TracksAnimator(this.chassis,param5,this.maxSpeedSmoother);
         this.state = ClientTankState.ACTIVE;
         this.bodyStateValidator = new BodyPhysicsStateValidator(this.tankBody.body,param10);
         this.weapon = param8;
         param8.init(this);
         this._turretController = param6;
         this.title = param9;
         this.localTurretController = param7;
         logService = LogService(OSGi.getInstance().getService(LogService));
         targetingModeService = TargetingModeService(OSGi.getInstance().getService(TargetingModeService));
         this.tankBody.onTankInited();
      }
      
      private static function calculateSizeForMesh(param1:Mesh) : Vector3
      {
         return new Vector3(param1.boundMaxX - param1.boundMinX,param1.boundMaxY - param1.boundMinY,param1.boundMaxZ - param1.boundMinZ);
      }
      
      private static function _getPhysicsState(param1:BodyState, param2:Vector3d, param3:Vector3d, param4:Vector3d, param5:Vector3d) : void
      {
         BattleUtils.copyToVector3d(param1.position,param2);
         var _loc6_:Quaternion = param1.orientation;
         _loc6_.getEulerAngles(_v);
         param3.x = _v.x;
         param3.y = _v.y;
         param3.z = _v.z;
         BattleUtils.copyToVector3d(param1.velocity,param4);
         BattleUtils.copyToVector3d(param1.angularVelocity,param5);
      }
      
      public function get turretController() : TurretController
      {
         return this._turretController;
      }
      
      private function initTurretGeometry(param1:TankSkin) : void
      {
         var _loc3_:TurretGeometryItem = null;
         var _loc4_:CollisionBox = null;
         var _loc2_:Vector.<TurretGeometryItem> = param1.getTurretGeometry();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = this.createTurretCollision(_loc3_.getHalfSize());
            this.turretCollisions.push(_loc4_);
            this.tankBody.body.addCollisionShape(_loc4_,new Matrix4());
         }
         this.updateTurretPhysics(0);
      }
      
      private function createTurretCollision(param1:Vector3) : CollisionBox
      {
         return new CollisionBox(param1,0,PhysicsMaterial.DEFAULT_MATERIAL);
      }
      
      private function initView() : void
      {
      }
      
      private function createViewByCollision(param1:CollisionBox, param2:uint = 65535) : Box
      {
         var _loc3_:Vector3 = param1.hs;
         var _loc4_:Box = new Box(_loc3_.x * 2,_loc3_.y * 2,_loc3_.z * 2);
         _loc4_.setMaterialToAllFaces(new FillMaterial(param2,0.9));
         return _loc4_;
      }
      
      public function log(param1:String) : void
      {
      }
      
      public function getLogStrings() : Vector.<String>
      {
         return new Vector.<String>();
      }
      
      public function setHullTransformUpdater(param1:HullTransformUpdater) : void
      {
         this.hullTransformUpdater = param1;
      }
      
      public function get teamType() : BattleTeam
      {
         return this._teamType;
      }
      
      public function get incarnation() : int
      {
         return this._incarnation;
      }
      
      public function getAllGunParams(param1:AllGlobalGunParams, param2:int = 0) : void
      {
         WeaponUtils.calculateMainGunParams(this.skin.getBarrel3D(),this.skin.getTurretDescriptor().muzzles[param2],param1);
      }
      
      public function getBasicGunParams(param1:BasicGlobalGunParams, param2:int = 0) : void
      {
         WeaponUtils.calculateBasicGunParams(this.skin.getBarrel3D(),this.skin.getTurretDescriptor().muzzles[param2],param1);
      }
      
      public function getLocalMuzzlePosition(param1:int = 0) : Vector3
      {
         return this.skin.getTurretDescriptor().muzzles[param1];
      }
      
      public function getLaserLocalPosition() : Vector3
      {
         return this.skin.getTurretDescriptor().laserPoint;
      }
      
      public function getBarrelLength(param1:int = 0) : Number
      {
         return Vector3(this.skin.getTurretDescriptor().muzzles[param1]).y;
      }
      
      public function getTurret3D() : Object3D
      {
         return this.skin.getTurret3D();
      }
      
      public function getHullMesh() : Mesh
      {
         return this.skin.getHullMesh();
      }
      
      public function getSkin() : TankSkin
      {
         return this.skin;
      }
      
      public function showTitle() : void
      {
         this.title.show();
      }
      
      public function hideTitle() : void
      {
         this.title.hide();
      }
      
      public function addDust(param1:int = 7) : void
      {
         var _loc2_:Dust = null;
         var _loc3_:int = 0;
         if(this.battleService != null)
         {
            _loc2_ = this.battleService.getBattleScene3D().getDustEngine();
            _loc3_ = 0;
            while(_loc3_ < param1)
            {
               _loc2_.addTankDust(this,0,0.9);
               _loc3_++;
            }
         }
      }
      
      private function getCameraTargetingMode() : int
      {
         switch(targetingModeService.getCurrentMode())
         {
            case TargetingMode.KEYBOARD:
               return CameraTargetMode.TURRET;
            case TargetingMode.MOUSE_LOOK:
               return this.turretController.hasCameraRotation() && this.prevState != ClientTankState.DEAD ? CameraTargetMode.FREE : CameraTargetMode.TURRET;
            default:
               return CameraTargetMode.TURRET;
         }
      }
      
      public function getCameraParams(param1:Vector3, param2:Vector3) : void
      {
         var _loc3_:int = -11;
         var _loc4_:int = this.getCameraTargetingMode();
         var _loc5_:Object3D = this.skin.getTurret3D();
         if(_loc4_ == CameraTargetMode.TURRET)
         {
            _m42.setMatrix(_loc5_.x,_loc5_.y,_loc5_.z,_loc5_.rotationX,_loc5_.rotationY,_loc5_.rotationZ);
         }
         else if(_loc4_ == CameraTargetMode.FREE)
         {
            _m42.setMatrix(_loc5_.x,_loc5_.y,_loc5_.z,_loc5_.rotationX,_loc5_.rotationY,this.turretController.getCameraRotation());
         }
         else
         {
            _m42.setMatrix(_loc5_.x,_loc5_.y,_loc5_.z,0,0,0);
         }
         var _loc6_:Mesh = this.skin.getHullMesh();
         _m41.setRotationMatrix(_loc6_.rotationX,_loc6_.rotationY,_loc6_.rotationZ);
         var _loc7_:Vector3 = BattleUtils.tmpVector;
         _m41.getUp(_loc7_);
         _m42.getPosition(param1);
         param1.addScaled(_loc3_,_loc7_);
         param2.reset(_m42.m01,_m42.m11,_m42.m21);
         this.prevState = this.state;
      }
      
      public function stopMovement() : void
      {
         this.sounds.setIdleMode();
      }
      
      public function lockMovement(param1:Boolean) : void
      {
         this.chassis.movementLocked = param1;
      }
      
      public function getBarrelOrigin(param1:Vector3, param2:int = 0) : void
      {
         param1.copy(this.skin.getTurretDescriptor().muzzles[param2]);
         param1.y = 0;
      }
      
      public function getNumberOfBarrels() : int
      {
         return this.skin.getTurretDescriptor().muzzles.length;
      }
      
      public function enableTurretSound(param1:Boolean) : void
      {
         this.sounds.turretSoundEnabled = param1;
      }
      
      public function spawn(param1:BattleTeam, param2:int) : void
      {
         this._teamType = param1;
         this._incarnation = param2;
         this.temperature = 0;
         this.maxSpeedSmoother.reset(this.maxSpeedSmoother.getTargetValue());
         this.maxTurnSpeedSmoother.reset(this.maxTurnSpeedSmoother.getTargetValue());
         this.tankBody.body.clearAccumulators();
         this.skin.resetColorTransform();
         this.skin.setNormalState();
         this.weapon.reset();
         this.sounds.setIdleMode();
         this.sounds.turretSoundEnabled = true;
         this.chassis.reset();
         this.turretController.reset();
         this.turretController.resetCameraRotation();
         if(this.localTurretController != null)
         {
            this.localTurretController.reset();
         }
         this.title.setTeamType(param1);
      }
      
      public function kill() : void
      {
         this.state = ClientTankState.DEAD;
         this.health = 0;
         this.sounds.enabled = false;
         this.battleService.getBattleRunner().getSoundManager().removeEffect(this.sounds);
         this.title.hideIndicators();
         this.title.hide();
         if(this.localTurretController != null)
         {
            this.localTurretController.reset();
         }
      }
      
      public function disable() : void
      {
         this.title.hideIndicators();
      }
      
      public function isSameTeam(param1:BattleTeam) : Boolean
      {
         return this._teamType == param1 && param1 != BattleTeam.NONE;
      }
      
      public function getUser() : IGameObject
      {
         return this.user;
      }
      
      public function getMainCollisionBox() : CollisionBox
      {
         return this.tankBody.tankCollisionBox;
      }
      
      public function setSemiActivatedState() : void
      {
         this.state = ClientTankState.SEMI_ACTIVE;
         this.setBodyCollisionGroup(CollisionGroup.TANK);
         this.setTracksCollisionGroup(CollisionGroup.INACTIVE_TRACK);
         this.skin.setAlpha(0.5);
         this.tankBody.body.postCollisionFilter = this;
      }
      
      public function setActivatedState() : void
      {
         this.state = ClientTankState.ACTIVE;
         this.setBodyCollisionGroup(CollisionGroup.TANK | CollisionGroup.ACTIVE_TRACK | CollisionGroup.WEAPON);
         this.setTracksCollisionGroup(CollisionGroup.ACTIVE_TRACK);
         this.skin.setAlpha(1);
         this.tankBody.body.postCollisionFilter = null;
      }
      
      public function considerBodies(param1:Body, param2:Body) : Boolean
      {
         if(param1.postCollisionFilter != null && param2.postCollisionFilter == null)
         {
            ++param1.tank.collisionCount;
         }
         else if(param1.postCollisionFilter == null && param2.postCollisionFilter != null)
         {
            ++param2.tank.collisionCount;
         }
         return false;
      }
      
      public function addToBattle(param1:BattleService) : void
      {
         var _loc2_:BattleRunner = null;
         var _loc3_:BattleScene3D = null;
         if(this.battleService == null)
         {
            this.inBattle = true;
            this.battleService = param1;
            this.tankBody.id = TankBodyIdProvider.claimId();
            _loc2_ = param1.getBattleRunner();
            _loc2_.addBodyWrapper(this.tankBody);
            _loc2_.addPhysicsController(this);
            _loc2_.addPostPhysicsController(this);
            _loc2_.addPhysicsInterpolator(this);
            this.skin.addToScene();
            this.title.addToContainer();
            _loc3_ = param1.getBattleScene3D();
            _loc3_.addTank(this);
            _loc2_.getSoundManager().addEffect(this.sounds);
            this.hullTransformUpdater.reset();
            _loc3_.getDustEngine().addTank(this);
         }
      }
      
      private function addDebugViewToScene(param1:BattleScene3D) : void
      {
      }
      
      public function removeFromBattle() : void
      {
         var _loc1_:BattleRunner = null;
         var _loc2_:BattleScene3D = null;
         if(this.battleService != null)
         {
            this.inBattle = false;
            this.weapon.deactivate();
            this.battleService.getBattleScene3D().getDustEngine().removeTank(this);
            _loc1_ = this.battleService.getBattleRunner();
            _loc2_ = this.battleService.getBattleScene3D();
            _loc1_.removeBodyWrapper(this.tankBody);
            _loc1_.removePhysicsController(this);
            _loc1_.removePostPhysicsController(this);
            _loc1_.removePhysicsInterpolator(this);
            TankBodyIdProvider.releaseId(this.tankBody.id);
            this.skin.removeFromScene();
            this.title.removeFromContainer();
            if(this.floatingTextEffect != null)
            {
               this.floatingTextEffect.kill();
            }
            _loc2_.removeTank(this);
            _loc1_.getSoundManager().removeEffect(this.sounds);
            this.battleService = null;
         }
      }
      
      private function removeDebugViewFromScene(param1:BattleScene3D) : void
      {
      }
      
      public function destroy() : void
      {
         this.user = null;
         this.state = ClientTankState.DEAD;
         this.skin.dispose();
         this.skin = null;
         this.weapon.destroy();
         this.tankBody.destroy();
         if(this.validator != null)
         {
            this.validator.destroy();
         }
      }
      
      public function setMaxSpeed(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            this.maxSpeedSmoother.reset(param1);
         }
         else
         {
            this.maxSpeedSmoother.setTargetValue(param1);
         }
      }
      
      public function setMaxTurnSpeed(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            this.maxTurnSpeedSmoother.reset(param1);
         }
         else
         {
            this.maxTurnSpeedSmoother.setTargetValue(param1);
         }
      }
      
      public function runBeforePhysicsUpdate(param1:Number) : void
      {
         this.collisionCount = 0;
         var _loc2_:Number = Number(this.maxSpeedSmoother.update(param1));
         var _loc3_:Number = Number(this.maxTurnSpeedSmoother.update(param1));
         this.tankBody.body.setMaxSpeedXY(_loc2_);
         this.chassis.applyForces(_loc2_,_loc3_,param1);
         this.tankBody.body.slipperyMode = !this.hasTracksContactsWithStatic() && this.tankBody.isSoaring();
         this.rotateTurret(param1);
         this.validateBodyState();
      }
      
      private function updateLocalTurretController(param1:Number) : void
      {
         this.localTurretController.tick(param1);
      }
      
      public function getTankDirection() : Number
      {
         return this.tankDirection;
      }
      
      private function calculateTankDirection() : Number
      {
         this.interpolatedOrientation.toMatrix3(_m);
         _m.transformVector(Vector3.Z_AXIS,_upDirection);
         _upDirection.normalize();
         _v.copy(this.skinCenterOffset);
         _v.transform3(_m);
         _v.add(this.interpolatedPosition);
         _m41.setFromMatrix3(_m,_v);
         _tankPosition.reset(_m41.m03,_m41.m13,_m41.m23);
         _tankDirection.reset(_m41.m01,_m41.m11,_m41.m21);
         _tankDirection.normalize();
         _projXToPlane.copy(Vector3.X_AXIS);
         _projYToPlane.copy(Vector3.Y_AXIS);
         _projXToPlane.projectOnPlane(_upDirection);
         _projYToPlane.projectOnPlane(_upDirection);
         _projXToPlane.normalize();
         _projYToPlane.normalize();
         var _loc1_:Number = MathUtils.clamp(_projYToPlane.dot(_tankDirection),-1,1);
         var _loc2_:Number = _projXToPlane.dot(_tankDirection);
         return Math.acos(_loc1_) * (_loc2_ > 0 ? -1 : 1);
      }
      
      public function runAfterPhysicsUpdate(param1:Number) : void
      {
         this.ensureBodyStateIsValid();
         this.bodyStateValidator.refresh();
         this.turretController.updatePhysics(this.getBody());
      }
      
      private function ensureBodyStateIsValid() : void
      {
         var _loc1_:Body = this.tankBody.body;
         var _loc2_:BodyState = _loc1_.state;
         if(!_loc2_.isValid())
         {
            _loc2_.copy(this.savedBodyState);
            _loc1_.saveState();
         }
      }
      
      public function updatePhysicsState() : void
      {
         this.interpolatePhysicsState(1);
         this.hullTransformUpdater.update(0);
         this.skin.updateTurretTransform(this.interpolatedTurretDirection);
      }
      
      public function interpolatePhysicsState(param1:Number) : void
      {
         this.tankBody.body.interpolate(param1,this.interpolatedPosition,this.interpolatedOrientation);
         this.interpolatedOrientation.normalize();
         this.interpolatedTurretDirection = this.turretController.getInterpolatedDirection(param1);
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc3_:Number = param2 * 0.001;
         this.hullTransformUpdater.update(_loc3_);
         this.skin.updateTurretTransform(this.interpolatedTurretDirection);
         this.skin.setColorTransformByTemperature(this.temperature);
         this.tracksAnimator.animate(_loc3_);
         var _loc4_:Object3D = this.skin.getTurret3D();
         _v.x = _loc4_.x;
         _v.y = _loc4_.y;
         _v.z = _loc4_.z;
         this.title.setWeaponStatus(100 * this.weapon.getStatus());
         this.title.update(_v);
         var _loc5_:TankHullSkinCacheItem = this.skin.getHullDescriptor();
         if(_loc5_.hasIncorrectData())
         {
            this.battleEventDispatcher.dispatchEventOnce(new DataValidationErrorEvent(_loc5_.getType()));
         }
         var _loc6_:TurretSkinCacheItem = this.skin.getTurretDescriptor();
         if(_loc6_.hasIncorrectData())
         {
            this.battleEventDispatcher.dispatchEventOnce(new DataValidationErrorEvent(_loc6_.getType()));
         }
         if(this.localTurretController != null && this.state != ClientTankState.DEAD)
         {
            this.tankDirection = this.calculateTankDirection();
         }
      }
      
      private function renderDebugView() : void
      {
      }
      
      public function setViewPositionByCollision(param1:Object3D, param2:CollisionBox) : void
      {
         var _loc3_:Matrix4 = param2.transform;
         _loc3_.getEulerAngles(_v);
         param1.rotationX = _v.x;
         param1.rotationY = _v.y;
         param1.rotationZ = _v.z;
         param1.x = _loc3_.m03;
         param1.y = _loc3_.m13;
         param1.z = _loc3_.m23;
      }
      
      public function getValidator() : DataUnitValidator
      {
         if(this.validator == null)
         {
            this.validator = new TankDataValidator(this.tankBody.body.collisionShapes);
         }
         return this.validator;
      }
      
      public function isInvisible(param1:Vector3) : Boolean
      {
         var _loc2_:int = int(this.visibilityPoints.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _point.copy(this.visibilityPoints[_loc3_]);
            if(this.isPointVisible(_point,param1))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function isPointVisible(param1:Vector3, param2:Vector3) : Boolean
      {
         var _loc3_:Body = this.tankBody.body;
         param1.transform3(_loc3_.baseMatrix);
         var _loc4_:BodyState = _loc3_.state;
         param1.add(_loc4_.position);
         _rayOrigin.copy(param2);
         _rayVector.diff(param1,_rayOrigin);
         var _loc5_:PhysicsScene = _loc3_.scene;
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc6_:CollisionDetector = _loc5_.collisionDetector;
         return !_loc6_.raycastStatic(_rayOrigin,_rayVector,CollisionGroup.STATIC,1,null,_rayHit);
      }
      
      public function getBodyCollisionGroup() : int
      {
         return CollisionShape(this.tankBody.tankCollisionBox).collisionGroup;
      }
      
      public function setBodyCollisionGroup(param1:int) : void
      {
         var _loc2_:CollisionBox = null;
         this.tankBody.tankCollisionBox.collisionGroup = param1;
         for each(_loc2_ in this.turretCollisions)
         {
            _loc2_.collisionGroup = param1 & CollisionGroup.WEAPON;
         }
      }
      
      public function setTracksCollisionGroup(param1:int) : void
      {
         this.chassis.setTracksCollisionGroup(param1);
      }
      
      public function setMovementParams(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         this.chassis.movementDirection = param1;
         this.chassis.turnDirection = param2;
         this.chassis.turnSpeedNumber = param3;
         this.chassis.inverseBackTurnMovement = param4;
         if(!this.chassis.movementLocked)
         {
            if(param1 != 0)
            {
               this.sounds.setAccelerationMode();
            }
            else if(param2 != 0)
            {
               this.sounds.setTurningMode();
            }
            else
            {
               this.sounds.setIdleMode();
            }
         }
      }
      
      public function setPhysicsState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d) : void
      {
         var _loc5_:Body = this.tankBody.body;
         var _loc6_:BodyState = _loc5_.state;
         BattleUtils.copyToVector3(param1,_loc6_.position);
         _loc6_.orientation.setFromEulerAnglesXYZ(param2.x,param2.y,param2.z);
         BattleUtils.copyToVector3(param3,_loc6_.velocity);
         BattleUtils.copyToVector3(param4,_loc6_.angularVelocity);
         _loc5_.saveState();
         _loc5_.calcDerivedData();
         this.bodyStateValidator.refresh();
      }
      
      public function getPhysicsState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d) : void
      {
         _getPhysicsState(this.tankBody.body.state,param1,param2,param3,param4);
      }
      
      public function getPreviousPhysicsState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d) : void
      {
         _getPhysicsState(this.tankBody.body.prevState,param1,param2,param3,param4);
      }
      
      public function getBody() : Body
      {
         return this.tankBody.body;
      }
      
      public function getCollisionCount() : int
      {
         return this.collisionCount;
      }
      
      public function setTemperature(param1:Number) : void
      {
         this.temperature = param1;
      }
      
      public function getTemperature() : Number
      {
         return this.temperature;
      }
      
      private function rotateTurret(param1:Number) : void
      {
         this.turretController.rotate(param1);
         this.updateTurretPhysics(this.turretController.getDirection());
         this.sounds.playTurretSound(this.turretController.isRotating());
      }
      
      private function updateTurretPhysics(param1:Number) : void
      {
         var _loc5_:CollisionBox = null;
         var _loc6_:Matrix4 = null;
         var _loc7_:TurretGeometryItem = null;
         var _loc2_:TankHullSkinCacheItem = this.skin.getHullDescriptor();
         var _loc3_:Vector.<TurretGeometryItem> = this.skin.getTurretGeometry();
         var _loc4_:int = 0;
         while(_loc4_ < this.turretCollisions.length)
         {
            _loc5_ = this.turretCollisions[_loc4_];
            _loc6_ = _loc5_.localTransform;
            _loc6_.setMatrix(_loc2_.getTurretMountPointX() + this.skinCenterOffset.x,_loc2_.getTurretMountPointY() + this.skinCenterOffset.y,_loc2_.getTurretMountPointZ() + this.skinCenterOffset.z,0,0,param1);
            _loc7_ = _loc3_[_loc4_];
            _loc6_.prepend(_loc7_.getTransform());
            _loc4_++;
         }
      }
      
      private function validateBodyState() : void
      {
         this.savedBodyState.copy(this.tankBody.body.state);
         this.bodyStateValidator.validate();
      }
      
      private function createBody(param1:Number, param2:Vector3) : void
      {
         var _loc3_:Body = new Body(param1,Matrix3.IDENTITY,0);
         PhysicsUtils.setBoxInvInertia(param1,param2,_loc3_.invInertia);
         _loc3_.tank = this;
         this.tankBody = new TankBody(_loc3_);
      }
      
      private function createCollisionPrimitives(param1:Vector3) : void
      {
         var _loc2_:Number = 2 * param1.z - (this.suspensionParams.nominalRayLength - TankConst.RAY_OFFSET);
         CollisionBoxesBuilder.createTankCollisionBox(param1,_loc2_,this.tankBody);
         CollisionBoxesBuilder.createStaticCollisionBoxes(param1,_loc2_,this.tankBody);
         this.setBoundSphereRadius(param1,_loc2_);
      }
      
      private function setBoundSphereRadius(param1:Vector3, param2:Number) : void
      {
         var _loc3_:Vector3 = new Vector3(param1.x,param1.y,param2 / 2);
         var _loc4_:Matrix4 = this.tankBody.tankCollisionBox.localTransform;
         this.boundSphereRadius = _loc3_.length() + Math.abs(_loc4_.m23);
      }
      
      private function createVisibilityPoints(param1:Vector3) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         this.visibilityPoints = Vector.<Vector3>([new Vector3(-_loc2_,_loc3_,0),new Vector3(_loc2_,_loc3_,0),new Vector3(-_loc2_,0,0),new Vector3(_loc2_,0,0),new Vector3(-_loc2_,-_loc3_,0),new Vector3(_loc2_,-_loc3_,0)]);
      }
      
      private function calculateSkinCenterOffset(param1:Vector3) : void
      {
         var _loc2_:Mesh = this.skin.getHullMesh();
         _loc2_.calculateBounds();
         this.skinCenterOffset.x = -0.5 * (_loc2_.boundMinX + _loc2_.boundMaxX);
         this.skinCenterOffset.y = -0.5 * (_loc2_.boundMinY + _loc2_.boundMaxY);
         this.skinCenterOffset.z = -0.5 * param1.z - this.suspensionParams.nominalRayLength + TankConst.RAY_OFFSET;
      }
      
      public function getSkinCenterOffset() : Vector3
      {
         return this.skinCenterOffset;
      }
      
      public function getTitleTexture() : BitmapData
      {
         return this.title.getTexture();
      }
      
      public function readTitlePosition(param1:Vector3D) : void
      {
         this.title.readPosition(param1);
      }
      
      public function getHalfLength() : Number
      {
         return this.halfLength;
      }
      
      public function getMaxHealth() : int
      {
         return this.maxHealth;
      }
      
      public function getBoundSphereRadius() : Number
      {
         return this.boundSphereRadius;
      }
      
      public function applyWeaponHit(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         if(this.health > 0)
         {
            this.tankBody.body.addWorldForceScaled(param1,param2,param3);
            this.tankBody.additionForcesSum.addScaled(param3,param2);
            this.setLastHitPoint(param1);
         }
      }
      
      public function getLeftTrack() : Track
      {
         return this.chassis.leftTrack;
      }
      
      public function getRightTrack() : Track
      {
         return this.chassis.rightTrack;
      }
      
      public function hasTracksContactsWithStatic() : Boolean
      {
         return this.getLeftTrack().hasContactsWithStatic() || this.getRightTrack().hasContactsWithStatic();
      }
      
      public function hasCollisionWithStatic() : Boolean
      {
         return this.tankBody.hasContactsWithStatic;
      }
      
      public function hasCollisionWithOtherBodies() : Boolean
      {
         return this.tankBody.hasContactsWithOtherBodies();
      }
      
      public function getPenetratedBodies() : Vector.<Body>
      {
         return this.tankBody.penetratedBodies;
      }
      
      public function getTurretDirection() : Number
      {
         return this.turretController.getDirection();
      }
      
      public function setAcceleration(param1:Number) : void
      {
         this.chassis.setAcceleration(param1);
      }
      
      public function setReverseAcceleration(param1:Number) : void
      {
         this.chassis.setReverseAcceleration(param1);
      }
      
      public function setSideAcceleration(param1:Number) : void
      {
         this.chassis.setSideAcceleration(param1);
      }
      
      public function setTurnAcceleration(param1:Number) : void
      {
         this.chassis.setTurnAcceleration(param1);
      }
      
      public function setReverseTurnAcceleration(param1:Number) : void
      {
         this.chassis.setReverseTurnAcceleration(param1);
      }
      
      public function setStabilizationAcceleration(param1:Number) : void
      {
         this.chassis.setStabilizationAcceleration(param1);
      }
      
      public function isInBattle() : Boolean
      {
         return this.inBattle;
      }
      
      public function isJumpBegin() : Boolean
      {
         return this.tankBody.isJumpBegin();
      }
      
      public function isJumpEnd() : Boolean
      {
         return this.tankBody.isJumpEnd();
      }
      
      public function isElasticStaticCollisionWhenSoaring() : Boolean
      {
         return this.tankBody.isElasticStaticCollisionWhenSoaring();
      }
      
      public function setLastHitPoint(param1:Vector3) : void
      {
         this.lastHitPoint.copy(param1);
         BattleUtils.globalToLocal(this.getBody(),this.lastHitPoint);
         this.isLastHitPointSet = true;
      }
   }
}

