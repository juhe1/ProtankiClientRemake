package alternativa.tanks.models.battle.commonflag
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.Trigger;
   import alternativa.tanks.battle.hidablegraphicobjects.HidableGraphicObject;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.engine3d.AnimatedSprite3D;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.utils.GraphicsUtils;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import platform.client.fp10.core.resource.types.TextureResource;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class Flag extends CommonFlag implements HidableGraphicObject, Trigger, Renderer, PointIndicatorStateProvider
   {
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const FLAG_ACCENDING:Number = 80;
      
      protected static const SKIN_HEIGHT:int = 400;
      
      private static const SKIN_BASE_SIZE:int = 95;
      
      private static const FLAG_FRAME_WIDTH:int = 128;
      
      private static const FLAG_FRAME_HEIGHT:int = 256;
      
      private static const FRAME_INTERVAL:int = 1000;
      
      private static const BASE_Z_AMPLITUDE:Number = 20;
      
      private static const BASE_Z_FREQUENCY:Number = 0.001;
      
      private static const FLAG_INDICATOR_ASCENDING:Number = 180;
      
      private var skin:AnimatedSprite3D;
      
      private var startTime:int;
      
      private var _hideIndicatorOnBase:Boolean;
      
      public function Flag(param1:int, param2:Vector3d, param3:BattleTeam, param4:TextureResource, param5:Boolean = false)
      {
         super(param1,param3,createBasePosition(param2));
         this._hideIndicatorOnBase = param5;
         var _loc6_:BitmapData = param4.data;
         var _loc7_:TextureAnimation = GraphicsUtils.getTextureAnimation(materialRegistry,_loc6_,FLAG_FRAME_WIDTH,_loc6_.height,0,false);
         skinObject = this.createSkin(FLAG_FRAME_WIDTH,FLAG_FRAME_HEIGHT,_loc7_);
         this.skin = AnimatedSprite3D(skinObject);
         collisionPrimitive = new CollisionBox(new Vector3(0.5 * SKIN_BASE_SIZE,0.5 * SKIN_BASE_SIZE,0.5 * SKIN_HEIGHT),CollisionGroup.TANK,PhysicsMaterial.DEFAULT_MATERIAL);
         setPosition(this.basePosition);
         this.startTime = FRAME_INTERVAL * Math.random();
      }
      
      private static function createBasePosition(param1:Vector3d) : Vector3
      {
         var _loc2_:Vector3 = Vector3.fromVector3d(param1);
         _loc2_.z += FLAG_ACCENDING;
         return _loc2_;
      }
      
      override protected function renderImpl(param1:int, param2:int, param3:FlagStatus) : void
      {
         var _loc4_:Number = NaN;
         this.skin.setFrameIndex(int((param1 - this.startTime) / FRAME_INTERVAL));
         if(state == FlagState.AT_BASE)
         {
            moveObjects(param3.position);
            _loc4_ = basePosition.z + BASE_Z_AMPLITUDE * Math.sin(BASE_Z_FREQUENCY * param1);
            this.skin.z = _loc4_;
            lightSource.z = _loc4_ + 0.75 * SKIN_HEIGHT;
         }
         else
         {
            moveObjects(param3.position);
         }
      }
      
      private function createSkin(param1:int, param2:int, param3:TextureAnimation) : Object3D
      {
         var _loc4_:Number = param1 * SKIN_HEIGHT / param2;
         this.skin = new AnimatedSprite3D(_loc4_,SKIN_HEIGHT);
         this.skin.softAttenuation = 10;
         this.skin.setAnimationData(param3);
         this.skin.setFrameIndex(0);
         this.skin.originY = 1;
         param3.material.resolution = 1;
         return this.skin;
      }
      
      override public function positionChanged(param1:Vector3, param2:Quaternion) : void
      {
         if(_state == FlagState.DROPPED || _state == FlagState.AT_BASE)
         {
            collisionPrimitive.transform.m03 = param1.x;
            collisionPrimitive.transform.m13 = param1.y;
            collisionPrimitive.transform.m23 = param1.z + 0.5 * skinHeight;
            collisionPrimitive.calculateAABB();
         }
         lightSource.x = param1.x;
         lightSource.y = param1.y;
         lightSource.z = param1.z + 0.75 * skinHeight;
      }
      
      public function isIndicatorActive(param1:Vector3 = null) : Boolean
      {
         if(this._hideIndicatorOnBase)
         {
            return state != FlagState.AT_BASE && (state != FlagState.CARRIED || !isLocalCarrier);
         }
         return state != FlagState.CARRIED || !isLocalCarrier;
      }
      
      public function zOffset() : Number
      {
         return FLAG_INDICATOR_ASCENDING;
      }
      
      public function set hideIndicatorOnBase(param1:Boolean) : void
      {
         this._hideIndicatorOnBase = param1;
      }
   }
}

