package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.PlaneMuzzleFlashEffect;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   
   public class RicochetEffects
   {
      
      public static const MUZZLE_FLASH_SIZE:Number = 150;
      
      private static const MUZZLE_FLASH_DURATION:int = 100;
      
      private var battleService:BattleService;
      
      private var sfxData:RicochetSFXData;
      
      public function RicochetEffects(param1:BattleService, param2:RicochetSFXData)
      {
         super();
         this.battleService = param1;
         this.sfxData = param2;
      }
      
      public function createShotEffects(param1:Object3D, param2:Vector3, param3:Vector3) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Sound3D = null;
         var _loc7_:Sound3DEffect = null;
         var _loc4_:PlaneMuzzleFlashEffect = PlaneMuzzleFlashEffect(this.battleService.getObjectPool().getObject(PlaneMuzzleFlashEffect));
         _loc4_.init(param2,param1,this.sfxData.muzzleFlashMaterial,MUZZLE_FLASH_DURATION,MUZZLE_FLASH_SIZE,MUZZLE_FLASH_SIZE);
         this.battleService.addGraphicEffect(_loc4_);
         if(this.sfxData.shotSound != null)
         {
            _loc5_ = 0.8;
            _loc6_ = Sound3D.create(this.sfxData.shotSound,_loc5_);
            _loc7_ = Sound3DEffect.create(param3,_loc6_);
            this.battleService.addSound3DEffect(_loc7_);
         }
      }
      
      public function createLightEffect(param1:Object3D, param2:Vector3) : void
      {
         var _loc3_:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc4_:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
         _loc4_.init(param1,param2);
         _loc3_.init(_loc4_,this.sfxData.shotLightAnimation);
         this.battleService.addGraphicEffect(_loc3_);
      }
   }
}

