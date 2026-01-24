package alternativa.tanks.models.weapon.shotgun.sfx
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.sfx.LightAnimation;
   import alternativa.tanks.utils.GraphicsUtils;
   import flash.media.Sound;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.AutoClosable;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx.ShotgunSFXCC;
   
   public class ShotgunSFXData implements AutoClosable
   {
      
      [Inject] // added
      public static var materialRegistry:EffectsMaterialRegistry;
      
      public var shotSound:Sound;
      
      public var reloadSound:Sound;
      
      public var magazineReloadSound:Sound;
      
      public var shotAcrossAnimation:TextureAnimation;
      
      public var shotAlongAnimation:TextureAnimation;
      
      public var smokeAnimation:TextureAnimation;
      
      public var pelletTrailMaterial:TextureMaterial;
      
      public var sparkleMaterial:TextureMaterial;
      
      public var explosionMarkMaterials:Vector.<TextureMaterial>;
      
      public var shotLightAnimation:LightAnimation;
      
      public function ShotgunSFXData(param1:ShotgunSFXCC, param2:LightAnimation)
      {
         var _loc3_:ImageResource = null;
         var _loc4_:TextureMaterial = null;
         super();
         this.shotSound = param1.shotSound.sound;
         this.reloadSound = param1.reloadSound.sound;
         this.magazineReloadSound = param1.magazineReloadSound.sound;
         this.shotAcrossAnimation = this.getFilteredTextureAnimation(param1.shotAcrossTexture);
         this.shotAlongAnimation = this.getFilteredTextureAnimation(param1.shotAlongTexture);
         this.smokeAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.smokeTexture);
         this.pelletTrailMaterial = this.getTextureMaterial(param1.pelletTrailTexture);
         this.sparkleMaterial = this.getTextureMaterial(param1.sparkleTexture);
         this.explosionMarkMaterials = new Vector.<TextureMaterial>();
         for each(_loc3_ in param1.explosionMarkTextures)
         {
            _loc4_ = materialRegistry.getMaterial(_loc3_.data);
            this.explosionMarkMaterials.push(_loc4_);
         }
         this.shotLightAnimation = param2;
      }
      
      private function getTextureMaterial(param1:ImageResource) : TextureMaterial
      {
         return materialRegistry.getMaterial(param1.data);
      }
      
      private function getFilteredTextureAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         return GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         var _loc1_:TextureMaterial = null;
         this.shotSound = null;
         this.reloadSound = null;
         this.magazineReloadSound = null;
         materialRegistry.releaseMaterial(this.shotAcrossAnimation.material);
         materialRegistry.releaseMaterial(this.shotAlongAnimation.material);
         materialRegistry.releaseMaterial(this.smokeAnimation.material);
         materialRegistry.releaseMaterial(this.pelletTrailMaterial);
         materialRegistry.releaseMaterial(this.sparkleMaterial);
         for each(_loc1_ in this.explosionMarkMaterials)
         {
            materialRegistry.releaseMaterial(_loc1_);
         }
      }
   }
}

