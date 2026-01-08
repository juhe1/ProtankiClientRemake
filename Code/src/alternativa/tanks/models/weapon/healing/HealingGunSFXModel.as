package alternativa.tanks.models.weapon.healing
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.engine3d.UVFrame;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.utils.GraphicsUtils;
   import flash.display.BitmapData;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IIsisSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXModelBase;
   
   [ModelInfo]
   public class HealingGunSFXModel extends IsisSFXModelBase implements IIsisSFXModelBase, IHealingGunSFXModel, ObjectLoadPostListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      public function HealingGunSFXModel()
      {
         super();
      }
      
      private static function createMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1);
         _loc2_.repeat = true;
         return _loc2_;
      }
      
      private static function flipUVFrames(param1:Vector.<UVFrame>) : Vector.<UVFrame>
      {
         var _loc2_:Vector.<UVFrame> = new Vector.<UVFrame>();
         var _loc3_:int = param1.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_.push(param1[_loc3_]);
            _loc3_--;
         }
         return _loc2_;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:IsisSFXCC = getInitParam();
         var _loc2_:HealingGunSFXData = new HealingGunSFXData();
         var _loc3_:MultiframeImageResource = _loc1_.healingBall;
         var _loc4_:TextureMaterial = createMaterial(_loc1_.healingBall.data);
         var _loc5_:TextureMaterial = createMaterial(_loc1_.healingBall.data);
         var _loc6_:TextureMaterial = createMaterial(_loc1_.healingRay.data);
         var _loc7_:TextureMaterial = createMaterial(_loc1_.damagingBall.data);
         var _loc8_:TextureMaterial = createMaterial(_loc1_.damagingRay.data);
         var _loc9_:Vector.<UVFrame> = GraphicsUtils.getUVFramesFromTexture(_loc4_.texture,_loc3_.frameWidth,_loc3_.frameHeight,_loc3_.numFrames);
         var _loc10_:Vector.<UVFrame> = flipUVFrames(_loc9_);
         _loc2_.idleMuzzle = new TextureAnimation(_loc4_,_loc9_,_loc3_.fps);
         _loc2_.idleSound = _loc1_.idleSound.sound;
         _loc2_.healMuzzle = new TextureAnimation(_loc5_,_loc9_,_loc3_.fps);
         _loc2_.healTarget = new TextureAnimation(_loc5_,_loc10_,_loc3_.fps);
         _loc2_.healShaft = _loc6_;
         _loc2_.healSound = _loc1_.healingSound.sound;
         _loc2_.damageMuzzle = new TextureAnimation(_loc7_,_loc10_,_loc3_.fps);
         _loc2_.damageTarget = new TextureAnimation(_loc7_,_loc9_,_loc3_.fps);
         _loc2_.damageShaft = _loc8_;
         _loc2_.damageSound = _loc1_.damagingSound.sound;
         var _loc11_:LightingSfx = new LightingSfx(_loc1_.lightingSFXEntity);
         _loc2_.startLightAnimation = _loc11_.createAnimation("start");
         _loc2_.loopLightAnimation = _loc11_.createAnimation("loop");
         _loc2_.friendStartLightAnimation = _loc11_.createAnimation("friendStart");
         _loc2_.friendLoopLightAnimation = _loc11_.createAnimation("friendLoop");
         _loc2_.enemyStartLightAnimation = _loc11_.createAnimation("enemyStart");
         _loc2_.enemyLoopLightAnimation = _loc11_.createAnimation("enemyLoop");
         _loc2_.friendBeamAnimation = _loc11_.createAnimation("friendBeam");
         _loc2_.enemyBeamAnimation = _loc11_.createAnimation("enemyBeam");
         putData(HealingGunSFXData,_loc2_);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:HealingGunSFXData = HealingGunSFXData(getData(HealingGunSFXData));
         materialRegistry.releaseMaterial(_loc1_.idleMuzzle.material);
         materialRegistry.releaseMaterial(_loc1_.healMuzzle.material);
         materialRegistry.releaseMaterial(_loc1_.healTarget.material);
         materialRegistry.releaseMaterial(_loc1_.healShaft);
         materialRegistry.releaseMaterial(_loc1_.damageMuzzle.material);
         materialRegistry.releaseMaterial(_loc1_.damageTarget.material);
         materialRegistry.releaseMaterial(_loc1_.damageShaft);
      }
      
      public function getHealingGunEffects() : HealingGunEffects
      {
         return new HealingGunEffectsImpl(battleService,HealingGunSFXData(getData(HealingGunSFXData)));
      }
   }
}

