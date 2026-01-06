package alternativa.tanks.sfx
{
   import alternativa.engine3d.core.MipMapping;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.sfx.levelup.LightBeamEffect;
   import alternativa.tanks.sfx.levelup.LightWaveEffect;
   import alternativa.tanks.sfx.levelup.SparkEffect;
   import alternativa.types.Long;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import forms.ranks.BigRankIcon;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   
   public class LevelUpEffectFactory
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var userInfoService:IUserInfoService;
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      private static const BeamTexture:Class = LevelUpEffectFactory_BeamTexture;
      
      private static const beamBitmapData:BitmapData = new BeamTexture().bitmapData;
      
      private static const SparkTexture:Class = LevelUpEffectFactory_SparkTexture;
      
      private static const sparkBitmapData:BitmapData = new SparkTexture().bitmapData;
      
      private static const WaveTexture:Class = LevelUpEffectFactory_WaveTexture;
      
      private static const waveBitmapData:BitmapData = new WaveTexture().bitmapData;
      
      private static const origin:Vector3 = new Vector3();
      
      private static const upDirection:Vector3 = new Vector3(0,0,1);
      
      private static const rayHit:RayHit = new RayHit();
      
      public function LevelUpEffectFactory()
      {
         super();
      }
      
      private static function getAvailableHeight(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         origin.reset(param1,param2,param3);
         var _loc5_:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         if(_loc5_.raycastStatic(origin,upDirection,CollisionGroup.STATIC,param4,null,rayHit))
         {
            return rayHit.t;
         }
         return param4;
      }
      
      public function createEffect(param1:Tank, param2:int) : void
      {
         var _loc3_:Object3D = param1.getSkin().getTurret3D();
         var _loc4_:Number = this.getEffectHeight(_loc3_.x,_loc3_.y,_loc3_.z);
         this.createLightBeams(_loc4_,_loc3_);
         this.createLabel(param1.getUser().id,_loc4_,param2,_loc3_);
         this.createSparks(_loc4_,_loc3_);
         this.createWave(_loc3_);
      }
      
      private function getEffectHeight(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc4_:Number = 500;
         var _loc5_:Number = 2000;
         var _loc6_:Number = getAvailableHeight(param1,param2,param3,_loc5_);
         return Math.max(_loc4_,_loc6_);
      }
      
      private function createLightBeams(param1:Number, param2:Object3D) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:LightBeamEffect = null;
         var _loc3_:int = 6;
         var _loc4_:Number = 90;
         var _loc5_:Number = 0;
         var _loc6_:Number = Math.PI * 2 / _loc3_;
         var _loc7_:TextureMaterial = materialRegistry.getMaterial(beamBitmapData);
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc9_ = Math.sin(_loc5_) * _loc4_;
            _loc10_ = Math.cos(_loc5_) * _loc4_;
            _loc11_ = LightBeamEffect(battleService.getObjectPool().getObject(LightBeamEffect));
            _loc11_.init(500,200,30,param1,0.8,0.5,_loc9_,_loc10_,-50,param2,_loc7_);
            battleService.getBattleScene3D().addGraphicEffect(_loc11_);
            _loc5_ += _loc6_;
            _loc8_++;
         }
      }
      
      private function createLabel(param1:Long, param2:Number, param3:int, param4:Object3D) : void
      {
         var _loc5_:BigRankIcon = new BigRankIcon();
         var _loc6_:BattleUserInfoService = BattleUserInfoService(OSGi.getInstance().getService(BattleUserInfoService));
         var _loc7_:Boolean = Boolean(_loc6_.hasUserPremium(param1));
         _loc5_.init(_loc7_,param3);
         var _loc8_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc8_.draw(_loc5_);
         var _loc9_:TextureMaterial = new TextureMaterial(_loc8_,false,true,MipMapping.PER_PIXEL,1);
         var _loc10_:SparkEffect = SparkEffect(battleService.getObjectPool().getObject(SparkEffect));
         _loc10_.init(500,270,270,0,param2 * 0.8,param2 * 0.15,0.35,0,0,50,param4,_loc9_,BlendMode.NORMAL);
         battleService.getBattleScene3D().addGraphicEffect(_loc10_);
      }
      
      private function createSparks(param1:Number, param2:Object3D) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:TextureMaterial = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:SparkEffect = null;
         if(GPUCapabilities.gpuEnabled)
         {
            _loc3_ = 15;
            _loc4_ = 100;
            _loc5_ = materialRegistry.getMaterial(sparkBitmapData);
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc7_ = Math.PI * 2 * Math.random();
               _loc8_ = Math.sin(_loc7_) * _loc4_;
               _loc9_ = Math.cos(_loc7_) * _loc4_;
               _loc10_ = -110 * _loc6_ - 50;
               _loc11_ = SparkEffect(battleService.getObjectPool().getObject(SparkEffect));
               _loc11_.init(400,150,150,_loc7_,param1 * 0.7,param1 * 0.15,0.7,_loc8_,_loc9_,_loc10_,param2,_loc5_,BlendMode.ADD);
               battleService.getBattleScene3D().addGraphicEffect(_loc11_);
               _loc6_++;
            }
         }
      }
      
      private function createWave(param1:Object3D) : void
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(waveBitmapData);
         var _loc3_:LightWaveEffect = LightWaveEffect(battleService.getObjectPool().getObject(LightWaveEffect));
         _loc3_.init(900,220,3,true,param1,_loc2_);
         battleService.getBattleScene3D().addGraphicEffect(_loc3_);
      }
   }
}

