package alternativa.tanks.battle
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.tankchassis.SuspensionRay;
   import alternativa.tanks.battle.objects.tank.tankchassis.Track;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.sfx.*;
   import alternativa.tanks.utils.GraphicsUtils;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BlendMode;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   
   public class Dust
   {
      
      private static const CHANCE:Number = 0.2;
      
      private static const SCALE_JITTER:Number = 1;
      
      private static const bias:Vector3 = new Vector3(100,0,0);
      
      private static const particleVelocity:Vector3 = new Vector3();
      
      private static const particlePosition:Vector3 = new Vector3();
      
      private var battleService:BattleService;
      
      private var dustSize:Number = 0;
      
      private var animation:TextureAnimation;
      
      private var tanks:Dictionary = new Dictionary();
      
      private var camera:GameCamera;
      
      private var nearDistance:Number;
      
      private var farDistance:Number;
      
      public var enabled:Boolean = true;
      
      private var intensity:Number;
      
      private var density:Number;
      
      public function Dust(param1:BattleService)
      {
         super();
         this.battleService = param1;
         this.camera = param1.getBattleScene3D().getCamera();
      }
      
      private static function addJitter(param1:Vector3, param2:Number) : void
      {
         param1.x += (Math.random() - 0.5) * 2 * param2;
         param1.y += (Math.random() - 0.5) * 2 * param2;
         param1.z += (Math.random() - 0.5) * 2 * param2;
      }
      
      public function init(param1:MultiframeImageResource, param2:TextureMaterialRegistry, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
      {
         this.animation = GraphicsUtils.getTextureAnimationFromResource(param2,param1);
         this.farDistance = param3;
         this.nearDistance = param4;
         this.dustSize = param5;
         this.intensity = param6;
         this.density = param7;
      }
      
      public function addTank(param1:Tank) : void
      {
         this.tanks[param1] = param1.getBoundSphereRadius() / 600;
      }
      
      public function removeTank(param1:Tank) : void
      {
         delete this.tanks[param1];
      }
      
      public function update() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:Tank = null;
         if(this.enabled && Boolean(this.camera.softTransparency) && this.camera.softTransparencyStrength > 0)
         {
            for(_loc1_ in this.tanks)
            {
               _loc2_ = _loc1_ as Tank;
               if(Boolean(_loc2_) && _loc2_.state == ClientTankState.ACTIVE)
               {
                  this.addTankDust(_loc2_,100,this.density);
               }
            }
         }
      }
      
      public function addTankDust(param1:Tank, param2:Number = 100, param3:Number = 0.2) : void
      {
         var _loc4_:Number = Number(this.tanks[param1]);
         var _loc5_:Track = param1.getLeftTrack();
         var _loc6_:Track = param1.getRightTrack();
         if(_loc5_.animationSpeed * _loc6_.animationSpeed < 0)
         {
            param2 = 5;
         }
         var _loc7_:Matrix3 = param1.getBody().baseMatrix;
         bias.x *= -1;
         _loc7_.transformVector(bias,particleVelocity);
         this.addTrackDust(_loc5_,_loc4_,particleVelocity,param2,param3);
         bias.x *= -1;
         _loc7_.transformVector(bias,particleVelocity);
         this.addTrackDust(_loc6_,_loc4_,particleVelocity,param2,param3);
      }
      
      private function addTrackDust(param1:Track, param2:Number, param3:Vector3, param4:Number, param5:Number) : void
      {
         var _loc7_:SuspensionRay = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:int = 0;
         while(_loc6_ < param1.numRays)
         {
            _loc7_ = param1.rays[_loc6_];
            _loc8_ = _loc7_.speed;
            if(_loc8_ > param4 && Math.random() < param5)
            {
               _loc9_ = _loc8_ > 500 ? 1 : 0.3 + _loc8_ / 712;
               particlePosition.copy(_loc7_.getGlobalOrigin());
               addJitter(particlePosition,50);
               param3.z = 100;
               addJitter(param3,20);
               this.createDustParticle(param2,particlePosition,param3,_loc9_);
            }
            _loc6_++;
         }
      }
      
      private function createDustParticle(param1:Number, param2:Vector3, param3:Vector3, param4:Number) : void
      {
         var _loc5_:ScalingObject3DPositionProvider = null;
         var _loc6_:LimitedDistanceAnimatedSpriteEffect = null;
         var _loc7_:Number = NaN;
         if(this.enabled && Boolean(this.camera.softTransparency) && this.camera.softTransparencyStrength > 0)
         {
            _loc5_ = ScalingObject3DPositionProvider(this.battleService.getObjectPool().getObject(ScalingObject3DPositionProvider));
            _loc5_.init(param2,param3,0.01);
            _loc6_ = LimitedDistanceAnimatedSpriteEffect(this.battleService.getObjectPool().getObject(LimitedDistanceAnimatedSpriteEffect));
            _loc7_ = this.dustSize * param1 * (1 + SCALE_JITTER * Math.random());
            _loc6_.init(_loc7_,_loc7_,this.animation,Math.random() * 2 * Math.PI,_loc5_,0.5,0.5,null,130,BlendMode.NORMAL,this.nearDistance,this.farDistance,this.intensity * param4 * this.camera.softTransparencyStrength,true);
            this.battleService.addGraphicEffect(_loc6_);
         }
      }
   }
}

