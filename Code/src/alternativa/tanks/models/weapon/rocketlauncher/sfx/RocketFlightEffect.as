package alternativa.tanks.models.weapon.rocketlauncher.sfx
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
   import alternativa.tanks.sfx.MobileSound3DEffect;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   import flash.media.Sound;
   import platform.client.fp10.core.type.AutoClosable;
   import alternativa.engine3d.alternativa3d;

   public class RocketFlightEffect extends PooledObject implements AutoClosable
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const FLAMES_COUNT:int = 8;
      
      private static const FLAME_LOOP:Number = 0.5;
      
      private static const SMOKE_INTERVAL:Number = 0.016;
      
      private var flames:Vector.<Sprite3D>;
      
      private var soundEffect:MobileSound3DEffect;
      
      private var flameTime:Number;
      
      private var smokeTime:Number;
      
      private var rocketMesh:Mesh;
      
      private var flightDirection:Vector3;
      
      private var smokeMaterial:TextureMaterial;
      
      private var lightEffect:AnimatedLightEffect;
      
      private var lightEffectPositionProvider:ExternalObject3DPositionProvider;
      
      public function RocketFlightEffect(param1:Pool)
      {
         var _loc3_:Sprite3D = null;
         this.flames = new Vector.<Sprite3D>();
         super(param1);
         var _loc2_:int = 0;
         while(_loc2_ < FLAMES_COUNT)
         {
            _loc3_ = new Sprite3D(128,128);
            _loc3_.blendMode = BlendMode.ADD;
            this.flames[_loc2_] = _loc3_;
            _loc2_++;
         }
      }
      
      public function init(param1:Mesh, param2:Vector3, param3:Sound, param4:RocketLauncherSfxData) : void
      {
         var _loc6_:Sprite3D = null;
         this.rocketMesh = param1;
         this.flightDirection = param2;
         this.smokeMaterial = param4.rocketSmoke;
         var _loc5_:Sound3D = Sound3D.create(param3);
         this.soundEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
         this.soundEffect.init(_loc5_,param1,0,Sound3D.ETERNAL_LOOP);
         battleService.addSound3DEffect(this.soundEffect);
         for each(_loc6_ in this.flames)
         {
            _loc6_.material = param4.rocketFlame;
            _loc6_.rotation = Math.random() * Math.PI * 2;
            battleService.getBattleScene3D().addObject(_loc6_);
         }
         this.flameTime = 0;
         this.smokeTime = 0;
         this.lightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         this.lightEffectPositionProvider = ExternalObject3DPositionProvider(battleService.getObjectPool().getObject(ExternalObject3DPositionProvider));
         this.lightEffect.init(this.lightEffectPositionProvider,param4.rocketLightingAnimation,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
         battleService.addGraphicEffect(this.lightEffect);
      }
      
      public function update(param1:Number) : void
      {
         var _loc3_:RocketSmoke = null;
         this.flameTime += param1;
         this.smokeTime += param1;
         var _loc2_:int = 0;
         while(_loc2_ < FLAMES_COUNT)
         {
            this.updateFlame(this.flames[_loc2_],this.flameTime + _loc2_ * FLAME_LOOP / FLAMES_COUNT);
            _loc2_++;
         }
         if(this.smokeTime >= SMOKE_INTERVAL)
         {
            _loc3_ = RocketSmoke(battleService.getObjectPool().getObject(RocketSmoke));
            _loc3_.init(this.rocketMesh,this.flightDirection,this.smokeMaterial);
            battleService.addGraphicEffect(_loc3_);
            this.smokeTime = 0;
         }
         this.lightEffectPositionProvider.setPosition(BattleUtils.tmpVector.reset(this.rocketMesh.x,this.rocketMesh.y,this.rocketMesh.z));
      }
      
      private function updateFlame(param1:Sprite3D, param2:Number) : void
      {
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc3_:Number = 5 / 60;
         var _loc4_:Number = FLAME_LOOP;
         var _loc5_:Number = 0.5;
         var _loc6_:Number = 0.8;
         var _loc7_:Number = 0.2;
         var _loc8_:Number = 10;
         var _loc9_:Number = 30;
         var _loc10_:Number = 250;
         var _loc11_:Number = 0.6;
         var _loc12_:Number = 1;
         var _loc13_:Number = 0;
         param2 %= _loc4_;
         if(param2 <= _loc3_)
         {
            _loc14_ = param2 / _loc3_;
            _loc15_ = _loc5_ + (_loc6_ - _loc5_) * _loc14_;
            _loc16_ = _loc8_ + (_loc9_ - _loc8_) * _loc14_;
            _loc17_ = _loc11_ + (_loc12_ - _loc11_) * _loc14_;
         }
         else
         {
            _loc14_ = (param2 - _loc3_) / (_loc4_ - _loc3_);
            _loc15_ = _loc6_ + (_loc7_ - _loc6_) * _loc14_;
            _loc16_ = _loc9_ + (_loc10_ - _loc9_) * _loc14_;
            _loc17_ = _loc12_ + (_loc13_ - _loc12_) * _loc14_;
         }
         param1.scaleX = _loc15_;
         param1.scaleY = _loc15_;
         param1.scaleZ = _loc15_;
         param1.x = this.rocketMesh.x - this.flightDirection.x * _loc16_;
         param1.y = this.rocketMesh.y - this.flightDirection.y * _loc16_;
         param1.z = this.rocketMesh.z - this.flightDirection.z * _loc16_;
         param1.alpha = _loc17_;
      }
      
      public function close() : void
      {
         var _loc1_:Sprite3D = null;
         this.soundEffect.kill();
         this.soundEffect = null;
         for each(_loc1_ in this.flames)
         {
            battleService.getBattleScene3D().removeObject(_loc1_);
            _loc1_.material = null;
         }
         this.rocketMesh = null;
         this.flightDirection = null;
         this.smokeMaterial = null;
         this.lightEffect.kill();
         this.lightEffect = null;
         this.lightEffectPositionProvider = null;
         recycle();
      }
   }
}

