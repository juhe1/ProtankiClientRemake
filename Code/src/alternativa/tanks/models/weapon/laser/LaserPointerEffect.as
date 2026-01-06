package alternativa.tanks.models.weapon.laser
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.Object3DNames;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.SFXUtils;
   import alternativa.tanks.utils.Colorizer;
   import alternativa.tanks.utils.SetControllerForTemporaryItems;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class LaserPointerEffect implements GraphicEffect, AutoClosable
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const EmbedLaserSpot:Class = LaserPointerEffect_EmbedLaserSpot;
      
      public static var spotTexture:BitmapData = new EmbedLaserSpot().bitmapData;
      
      private static const startPosition:Vector3 = new Vector3();
      
      private static const endPosition:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const colorizedSpotTextures:Dictionary = new Dictionary();
      
      private static const STATE_OFF:int = 0;
      
      private static const STATE_FADEIN:int = 1;
      
      private static const STATE_SHOW:int = 2;
      
      private static const STATE_FADEOUT:int = 3;
      
      private static const STATE_DEAD:int = 4;
      
      private static const FADE_OUT_TIME:int = 200;
      
      private static const MAX_BEAM_LENGTH:Number = 100000;
      
      private static const MIN_BEAM_LENGTH:Number = 200;
      
      private static const CURVE:Number = 2.2;
      
      private static const LERP_FACTOR:Number = 0.333;
      
      private static const SPOT_SIZE:Number = 30;
      
      private static const RAYCAST_SHIFT:Number = 10;
      
      private static const DIRECTION_ACCURACY:Number = 0.001;
      
      private static const LOCAL_POINT_ACCURACY:Number = 1;
      
      private var visible:Boolean;
      
      private var state:int;
      
      private var time:int;
      
      private var fadeInTimeMs:int;
      
      private var turret:Object3D;
      
      private var laser:Laser;
      
      private var container:Scene3DContainer;
      
      private var sourcePositionProvider:MuzzlePositionProvider;
      
      private var spot:Sprite3D;
      
      private var targetUpCoord:Number;
      
      private var currentUpCoord:Number;
      
      private var currentForwardCoord:Number;
      
      private var targetTank:Tank;
      
      private var localPointOnTarget:Vector3 = new Vector3();
      
      private var exclusionSetController:SetControllerForTemporaryItems;
      
      private var excludedObjects:Dictionary;
      
      public function LaserPointerEffect(param1:int, param2:Tank)
      {
         super();
         this.fadeInTimeMs = param1;
         this.reset(param2);
      }
      
      public function show(param1:uint) : void
      {
         this.visible = true;
         this.state = STATE_OFF;
         this.currentUpCoord = 0;
         this.currentForwardCoord = 1;
         this.laser.alpha = 0;
         this.laser.visible = false;
         this.laser.init(param1);
         this.spot.alpha = 0;
         this.spot.visible = false;
         this.spot.material = Colorizer.getColorizedMaterial(colorizedSpotTextures,param1,spotTexture);
         if(this.container == null)
         {
            battleService.addGraphicEffect(this);
         }
      }
      
      public function reset(param1:Tank) : void
      {
         this.laser = new Laser();
         this.spot = new Sprite3D(SPOT_SIZE,SPOT_SIZE);
         this.spot.useShadowMap = false;
         this.spot.useLight = false;
         this.spot.blendMode = BlendMode.ADD;
         this.spot.sorting = Sorting.DYNAMIC_BSP;
         this.spot.shadowMapAlphaThreshold = 2;
         this.spot.depthMapAlphaThreshold = 2;
         this.turret = param1.getTurret3D();
         var _loc2_:ObjectPool = battleService.getObjectPool();
         this.sourcePositionProvider = MuzzlePositionProvider(_loc2_.getObject(MuzzlePositionProvider));
         this.sourcePositionProvider.init(this.turret,param1.getLaserLocalPosition());
         this.excludedObjects = battleService.getBattleScene3D().getExcludedObjects();
         this.exclusionSetController = new SetControllerForTemporaryItems(this.excludedObjects);
      }
      
      public function markAsVisible() : void
      {
         this.visible = true;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.laser);
         param1.addChild(this.spot);
      }
      
      public function updateDirection(param1:Number) : Boolean
      {
         if(this.state == STATE_OFF || this.targetTank != null || Math.abs(this.targetUpCoord - param1) > DIRECTION_ACCURACY)
         {
            this.changeStateIfWasOff();
            this.targetUpCoord = param1;
            this.targetTank = null;
            return true;
         }
         return false;
      }
      
      public function aimAtTank(param1:Tank, param2:Vector3) : Boolean
      {
         this.changeStateIfWasOff();
         if(this.targetTank != param1 || param2.distanceToSquared(this.localPointOnTarget) > LOCAL_POINT_ACCURACY)
         {
            this.targetTank = param1;
            this.localPointOnTarget.copy(param2);
            return true;
         }
         return false;
      }
      
      private function changeStateIfWasOff() : void
      {
         if(this.state == STATE_OFF)
         {
            this.time = 0;
            this.state = STATE_FADEIN;
         }
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:Number = NaN;
         this.updateState(param1);
         if(this.state == STATE_DEAD)
         {
            return false;
         }
         if(this.state == STATE_OFF)
         {
            this.laser.alpha = 0;
            this.laser.visible = false;
            this.spot.alpha = 0;
            this.spot.visible = false;
            return true;
         }
         this.sourcePositionProvider.updateObjectPosition(this.laser,param2,param1);
         startPosition.x = this.laser.x;
         startPosition.y = this.laser.y;
         startPosition.z = this.laser.z;
         this.calculateDirectionAndEndPoint();
         _loc3_ = Vector3.distanceBetween(startPosition,endPosition);
         this.laser.update(param1,_loc3_);
         this.laser.visible = _loc3_ >= MIN_BEAM_LENGTH;
         this.spot.x = endPosition.x;
         this.spot.y = endPosition.y;
         this.spot.z = endPosition.z;
         this.spot.visible = _loc3_ < MAX_BEAM_LENGTH;
         SFXUtils.alignObjectPlaneToView(this.laser,startPosition,direction,param2.position);
         return true;
      }
      
      private function calculateDirectionAndEndPoint() : void
      {
         var _loc1_:Matrix3 = BattleUtils.tmpMatrix3;
         _loc1_.setRotationMatrixForObject3D(this.turret);
         var _loc2_:Vector3 = BattleUtils.tmpVector;
         _loc1_.getUp(_loc2_);
         if(this.targetTank != null && this.targetTank.getBody() != null)
         {
            endPosition.copy(this.localPointOnTarget);
            BattleUtils.localToGlobal(this.targetTank.getBody(),endPosition);
            direction.diff(endPosition,startPosition).normalize();
            this.targetUpCoord = _loc2_.dot(direction);
            if(Math.abs(this.targetUpCoord - this.currentUpCoord) < DIRECTION_ACCURACY)
            {
               endPosition.addScaled(-RAYCAST_SHIFT,direction);
               return;
            }
         }
         if(Math.abs(this.targetUpCoord - this.currentUpCoord) > DIRECTION_ACCURACY)
         {
            this.currentUpCoord += LERP_FACTOR * (this.targetUpCoord - this.currentUpCoord);
            this.currentForwardCoord = Math.sqrt(1 - this.currentUpCoord * this.currentUpCoord);
         }
         direction.copy(_loc2_);
         direction.scale(this.currentUpCoord);
         _loc1_.getForward(_loc2_);
         direction.addScaled(this.currentForwardCoord,_loc2_);
         this.calculateEndPoint();
      }
      
      private function updateState(param1:int) : void
      {
         var _loc2_:Number = 0;
         switch(this.state)
         {
            case STATE_FADEIN:
               _loc2_ = this.updateStateTimer(param1,STATE_SHOW,this.fadeInTimeMs);
               break;
            case STATE_FADEOUT:
               _loc2_ = 1 - this.updateStateTimer(param1,STATE_DEAD,FADE_OUT_TIME);
               break;
            default:
               return;
         }
         var _loc3_:Number = Math.pow(_loc2_,CURVE);
         this.laser.alpha = _loc3_;
         this.spot.alpha = _loc3_;
      }
      
      private function updateStateTimer(param1:int, param2:int, param3:int) : Number
      {
         this.time += param1;
         if(this.time >= param3)
         {
            this.state = param2;
            this.time = param3;
         }
         return this.time / param3;
      }
      
      private function calculateEndPoint() : void
      {
         var _loc1_:RayIntersectionData = null;
         var _loc2_:Object3D = null;
         this.exclusionSetController.addTemporaryItem(this.turret);
         while(true)
         {
            _loc1_ = battleService.getBattleScene3D().raycast(startPosition,direction,this.excludedObjects);
            if(_loc1_ == null)
            {
               break;
            }
            _loc2_ = _loc1_.object;
            if(_loc2_.name == Object3DNames.STATIC || _loc2_.name == Object3DNames.TANK_PART)
            {
               endPosition.copy(startPosition);
               endPosition.addScaled(_loc1_.time - RAYCAST_SHIFT,direction);
               this.exclusionSetController.deleteAllTemporaryItems();
               return;
            }
            this.exclusionSetController.addTemporaryItem(_loc1_.object);
         }
         this.exclusionSetController.deleteAllTemporaryItems();
         endPosition.copy(startPosition);
         endPosition.addScaled(MAX_BEAM_LENGTH,direction);
      }
      
      public function hide() : void
      {
         this.visible = false;
         if(Boolean(this.container))
         {
            this.state = STATE_FADEOUT;
            this.time = 0;
         }
         else
         {
            this.kill();
         }
      }
      
      public function isVisible() : Boolean
      {
         return this.visible;
      }
      
      public function destroy() : void
      {
         this.kill();
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.kill();
         this.sourcePositionProvider.destroy();
         this.sourcePositionProvider = null;
         this.turret = null;
         this.laser = null;
         this.spot = null;
         this.excludedObjects = null;
         this.exclusionSetController = null;
      }
      
      public function kill() : void
      {
         if(Boolean(this.container))
         {
            this.container.removeChild(this.laser);
            this.container.removeChild(this.spot);
            this.container = null;
            this.laser.close();
            this.spot.material = null;
            this.state = STATE_DEAD;
         }
         else
         {
            this.state = STATE_OFF;
         }
         this.targetTank = null;
         this.localPointOnTarget.reset();
         this.targetUpCoord = 0;
         this.currentUpCoord = 0;
         this.currentForwardCoord = 1;
      }
   }
}

