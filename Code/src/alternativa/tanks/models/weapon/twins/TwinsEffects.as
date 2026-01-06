package alternativa.tanks.models.weapon.twins
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.PlaneMuzzleFlashEffect;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   
   public class TwinsEffects
   {
      
      public static const FLASH_SIZE:int = 120;
      
      private static const FLASH_LIFE_TIME:int = 50;
      
      private var battleService:BattleService;
      
      private var sfxData:TwinsSFXData;
      
      public function TwinsEffects(param1:BattleService, param2:TwinsSFXData)
      {
         super();
         this.battleService = param1;
         this.sfxData = param2;
      }
      
      public function createShotEffects(param1:Object3D, param2:Vector3) : void
      {
         this.createGraphicEffect(param2,param1);
         this.createMuzzleLightEffect(param2,param1);
         this.createSoundEffect(param1);
      }
      
      private function createGraphicEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:PlaneMuzzleFlashEffect = PlaneMuzzleFlashEffect(this.battleService.getObjectPool().getObject(PlaneMuzzleFlashEffect));
         _loc3_.init(param1,param2,this.sfxData.muzzleFlashMaterial,FLASH_LIFE_TIME,FLASH_SIZE,FLASH_SIZE);
         this.battleService.addGraphicEffect(_loc3_);
      }
      
      private function createMuzzleLightEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc4_:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
         _loc4_.init(param2,param1);
         _loc3_.init(_loc4_,this.sfxData.shotLightingAnimation);
         this.battleService.addGraphicEffect(_loc3_);
      }
      
      private function createSoundEffect(param1:Object3D) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Sound3D = null;
         if(this.sfxData.shotSound != null)
         {
            _loc2_ = 0.8;
            _loc3_ = Sound3D.create(this.sfxData.shotSound,_loc2_);
            BattleUtils.tmpVector.reset(param1.x,param1.y,param1.z);
            this.battleService.addSound3DEffect(Sound3DEffect.create(BattleUtils.tmpVector,_loc3_));
         }
      }
   }
}

