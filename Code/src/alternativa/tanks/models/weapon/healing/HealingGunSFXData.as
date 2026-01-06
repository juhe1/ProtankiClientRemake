package alternativa.tanks.models.weapon.healing
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.sfx.LightAnimation;
   import flash.media.Sound;
   
   public class HealingGunSFXData
   {
      
      public var idleMuzzle:TextureAnimation;
      
      public var idleSound:Sound;
      
      public var healMuzzle:TextureAnimation;
      
      public var healTarget:TextureAnimation;
      
      public var healShaft:TextureMaterial;
      
      public var healSound:Sound;
      
      public var damageMuzzle:TextureAnimation;
      
      public var damageTarget:TextureAnimation;
      
      public var damageShaft:TextureMaterial;
      
      public var damageSound:Sound;
      
      public var startLightAnimation:LightAnimation;
      
      public var loopLightAnimation:LightAnimation;
      
      public var friendStartLightAnimation:LightAnimation;
      
      public var friendLoopLightAnimation:LightAnimation;
      
      public var enemyStartLightAnimation:LightAnimation;
      
      public var enemyLoopLightAnimation:LightAnimation;
      
      public var friendBeamAnimation:LightAnimation;
      
      public var enemyBeamAnimation:LightAnimation;
      
      public function HealingGunSFXData()
      {
         super();
      }
   }
}

