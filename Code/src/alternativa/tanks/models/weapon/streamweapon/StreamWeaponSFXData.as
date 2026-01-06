package alternativa.tanks.models.weapon.streamweapon
{
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
   import alternativa.tanks.sfx.LightAnimation;
   import flash.media.Sound;
   
   public class StreamWeaponSFXData
   {
      
      public var particleAnimation:TextureAnimation;
      
      public var muzzlePlaneAnimation:TextureAnimation;
      
      public var shootingSound:Sound;
      
      public var particleColorTransformPoints:Vector.<ColorTransformEntry>;
      
      public var muzzlePlaneColorTransformPoints:Vector.<ColorTransformEntry>;
      
      public var particleSpeed:Number;
      
      public var startLightAnimation:LightAnimation;
      
      public var loopLightAnimation:LightAnimation;
      
      public var startFireAnimation:LightAnimation;
      
      public var loopFireAnimation:LightAnimation;
      
      public function StreamWeaponSFXData()
      {
         super();
      }
   }
}

