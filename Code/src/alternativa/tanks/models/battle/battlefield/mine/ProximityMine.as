package alternativa.tanks.models.battle.battlefield.mine
{
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.collision.colliders.BoxSphereCollider;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.primitives.CollisionSphere;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.Trigger;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.sfx.Blinker;
   import alternativa.types.Long;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   public class ProximityMine extends BattleRunnerProvider implements Trigger, Renderer
   {
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      private static var pool:ProximityMine;
      
      private static const FLASH_GROW:int = 1;
      
      private static const FLASH_FADE:int = 2;
      
      private static const FLASH_DONE:int = 3;
      
      private static const INITIAL_BLINK_INTERVAL:int = 320;
      
      private static const MIN_BLINK_INTERVAL:int = 22;
      
      private static const BLINK_INTERVAL_DECREMENT:int = 12;
      
      private static const ALPHA_MIN:Number = 0.2;
      
      private static const BLINK_SPEED_COEFF:Number = 10;
      
      private static const _vector:Vector3 = new Vector3();
      
      private static const collider:BoxSphereCollider = new BoxSphereCollider();
      
      public var next:ProximityMine;
      
      public var prev:ProximityMine;
      
      public var id:String;
      
      public var ownerId:String;
      
      public var collisionPrimitive:CollisionSphere = new CollisionSphere(1,CollisionGroup.WEAPON,PhysicsMaterial.DEFAULT_MATERIAL);
      
      public var position:Vector3 = new Vector3();
      
      public var groundNormal:Vector3 = new Vector3();
      
      private var callback:IMineCallback;
      
      private var teamType:BattleTeam;
      
      private var mesh:Mesh;
      
      private var state:ProximityMineState = ProximityMineState.NOT_ARMED;
      
      private var mineModelData:MineModelData;
      
      private var flashBaseTime:int;
      
      private var flashState:int;
      
      private var colorTransform:ColorTransform = new ColorTransform();
      
      private const blinker:Blinker = new Blinker(INITIAL_BLINK_INTERVAL,MIN_BLINK_INTERVAL,BLINK_INTERVAL_DECREMENT,ALPHA_MIN,1,BLINK_SPEED_COEFF);
      
      private var localTank:Tank;
      
      private var inContact:Boolean;
      
      public function ProximityMine(param1:Mesh)
      {
         super();
         this.mesh = Mesh(param1.clone());
      }
      
      public static function create(param1:String, param2:String, param3:Number, param4:Mesh, param5:Material, param6:BattleTeam, param7:MineModelData, param8:IMineCallback) : ProximityMine
      {
         var _loc9_:ProximityMine = null;
         if(pool == null)
         {
            _loc9_ = new ProximityMine(param4);
         }
         else
         {
            _loc9_ = pool;
            pool = pool.next;
            _loc9_.next = null;
         }
         _loc9_.init(param1,param2,param3,param5,param6,param7,param8);
         return _loc9_;
      }
      
      public function dispose() : void
      {
         this.id = null;
         this.ownerId = null;
         this.mineModelData = null;
         this.localTank = null;
         this.inContact = false;
         this.prev = null;
         this.next = pool == null ? null : pool;
         pool = this;
      }
      
      public function arm() : void
      {
         this.state = ProximityMineState.ARMED;
         this.flashBaseTime = getTimer();
         this.flashState = FLASH_GROW;
         this.mesh.colorTransform = this.colorTransform;
         this.mesh.alpha = 1;
      }
      
      public function setPosition(param1:Vector3, param2:Vector3) : void
      {
         this.position.copy(param1);
         this.groundNormal.copy(param2);
         this.mesh.x = param1.x;
         this.mesh.y = param1.y;
         this.mesh.z = param1.z;
         _vector.cross2(Vector3.Z_AXIS,param2).normalize();
         var _loc3_:Number = Math.acos(param2.dot(Vector3.Z_AXIS));
         var _loc4_:Matrix3 = new Matrix3();
         _loc4_.fromAxisAngle(_vector,_loc3_);
         _loc4_.getEulerAngles(_vector);
         this.mesh.rotationX = _vector.x;
         this.mesh.rotationY = _vector.y;
         this.mesh.rotationZ = _vector.z;
         var _loc5_:Matrix4 = this.collisionPrimitive.transform;
         _loc5_.setPosition(param1);
         this.collisionPrimitive.calculateAABB();
      }
      
      public function addToGame() : void
      {
         getBattleRunner().addTrigger(this);
         var _loc1_:BattleScene3D = battleService.getBattleScene3D();
         _loc1_.addObject(this.mesh);
         _loc1_.addRenderer(this,0);
      }
      
      public function removeFromGame() : void
      {
         getBattleRunner().removeTrigger(this);
         var _loc1_:BattleScene3D = battleService.getBattleScene3D();
         _loc1_.removeRenderer(this,0);
         _loc1_.removeObject(this.mesh);
      }
      
      public function checkTrigger(param1:Body) : void
      {
         this.localTank = param1.tank;
         if(this.canExplode(this.localTank))
         {
            if(this.collidesWith(this.localTank))
            {
               if(!this.inContact)
               {
                  this.inContact = true;
                  this.callback.onTouchMine(this);
               }
            }
            else
            {
               this.inContact = false;
            }
         }
      }
      
      private function canExplode(param1:Tank) : Boolean
      {
         return this.state == ProximityMineState.ARMED && this.ownerId != param1.getUserId() && !param1.isSameTeam(this.teamType) && param1.state == ClientTankState.ACTIVE;
      }
      
      private function collidesWith(param1:Tank) : Boolean
      {
         var _loc2_:CollisionBox = param1.getMainCollisionBox();
         return (_loc2_.collisionGroup & this.collisionPrimitive.collisionGroup) != 0 && collider.haveCollision(_loc2_,this.collisionPrimitive);
      }
      
      public function render(param1:int, param2:int) : void
      {
         if(this.state == ProximityMineState.NOT_ARMED)
         {
            this.mesh.alpha = this.blinker.updateValue(param1,param2);
         }
         else if(this.state == ProximityMineState.ARMED)
         {
            if(this.flashState != FLASH_DONE)
            {
               this.updateFlash(param1);
            }
            else
            {
               this.updateVisibility();
            }
         }
      }
      
      private function updateVisibility() : void
      {
         if(this.isAlwaysVisible())
         {
            this.mesh.visible = true;
         }
         else if(this.isLocalTankAlive())
         {
            this.updateVisibilityByDistance(this.localTank);
         }
         else
         {
            this.mesh.visible = false;
         }
      }
      
      private function isAlwaysVisible() : Boolean
      {
         return Boolean(battleInfoService.isSpectatorMode()) || this.state != ProximityMineState.ARMED || this.isLocalTankAlive() && (this.ownerId == this.localTank.getUserId() || this.localTank.isSameTeam(this.teamType));
      }
      
      private function isLocalTankAlive() : Boolean
      {
         return Boolean(this.localTank) && Boolean(this.localTank.getUser()) && this.localTank.health > 0;
      }
      
      private function updateVisibilityByDistance(param1:Tank) : void
      {
         this.mesh.visible = true;
         _vector.diff(param1.getBody().state.position,this.position);
         var _loc2_:Number = _vector.length();
         if(_loc2_ > this.mineModelData.farRadius)
         {
            this.mesh.visible = false;
         }
         else if(_loc2_ < this.mineModelData.nearRadius)
         {
            this.mesh.alpha = 1;
         }
         else
         {
            this.mesh.alpha = (this.mineModelData.farRadius - _loc2_) / (this.mineModelData.farRadius - this.mineModelData.nearRadius);
         }
      }
      
      private function init(param1:String, param2:String, param3:Number, param4:Material, param5:BattleTeam, param6:MineModelData, param7:IMineCallback) : void
      {
         this.id = param1;
         this.ownerId = param2;
         this.setProximityRadius(param3);
         this.teamType = param5;
         this.mineModelData = param6;
         this.callback = param7;
         this.mesh.colorTransform = null;
         this.mesh.alpha = 1;
         this.mesh.visible = true;
         this.mesh.setMaterialToAllFaces(param4);
         this.state = ProximityMineState.NOT_ARMED;
         this.flashState = FLASH_DONE;
         this.flashBaseTime = getTimer();
         this.blinker.init(this.flashBaseTime);
      }
      
      private function setProximityRadius(param1:Number) : void
      {
         this.collisionPrimitive.r = param1;
         this.collisionPrimitive.calculateAABB();
      }
      
      private function updateFlash(param1:int) : void
      {
         switch(this.flashState)
         {
            case FLASH_GROW:
               if(param1 < this.flashBaseTime + this.mineModelData.armedFlashDuration)
               {
                  this.setColorOffset(this.mineModelData.flashChannelOffset * (param1 - this.flashBaseTime) / this.mineModelData.armedFlashDuration);
                  break;
               }
               this.setColorOffset(this.mineModelData.flashChannelOffset);
               this.flashBaseTime += this.mineModelData.armedFlashDuration + this.mineModelData.armedFlashFadeDuration;
               this.flashState = FLASH_FADE;
               break;
            case FLASH_FADE:
               if(param1 < this.flashBaseTime)
               {
                  this.setColorOffset(this.mineModelData.flashChannelOffset * (this.flashBaseTime - param1) / this.mineModelData.armedFlashFadeDuration);
                  break;
               }
               this.setColorOffset(0);
               this.flashState = FLASH_DONE;
               this.mesh.colorTransform = null;
         }
      }
      
      private function setColorOffset(param1:uint) : void
      {
         this.colorTransform.redOffset = param1;
         this.colorTransform.greenOffset = param1;
         this.colorTransform.blueOffset = param1;
         this.mesh.colorTransform = this.colorTransform;
      }
   }
}

