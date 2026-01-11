package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class ShotgunSFXCC
   {
      
      private var _explosionMarkTextures:Vector.<ImageResource>;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _magazineReloadSound:SoundResource;
      
      private var _pelletTrailTexture:ImageResource;
      
      private var _reloadSound:SoundResource;
      
      private var _shotAcrossTexture:MultiframeImageResource;
      
      private var _shotAlongTexture:MultiframeImageResource;
      
      private var _shotSound:SoundResource;
      
      private var _smokeTexture:MultiframeImageResource;
      
      private var _sparkleTexture:ImageResource;
      
      public function ShotgunSFXCC(param1:Vector.<ImageResource> = null, param2:LightingSFXEntity = null, param3:SoundResource = null, param4:ImageResource = null, param5:SoundResource = null, param6:MultiframeImageResource = null, param7:MultiframeImageResource = null, param8:SoundResource = null, param9:MultiframeImageResource = null, param10:ImageResource = null)
      {
         super();
         this._explosionMarkTextures = param1;
         this._lightingSFXEntity = param2;
         this._magazineReloadSound = param3;
         this._pelletTrailTexture = param4;
         this._reloadSound = param5;
         this._shotAcrossTexture = param6;
         this._shotAlongTexture = param7;
         this._shotSound = param8;
         this._smokeTexture = param9;
         this._sparkleTexture = param10;
      }
      
      public function get explosionMarkTextures() : Vector.<ImageResource>
      {
         return this._explosionMarkTextures;
      }
      
      public function set explosionMarkTextures(param1:Vector.<ImageResource>) : void
      {
         this._explosionMarkTextures = param1;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get magazineReloadSound() : SoundResource
      {
         return this._magazineReloadSound;
      }
      
      public function set magazineReloadSound(param1:SoundResource) : void
      {
         this._magazineReloadSound = param1;
      }
      
      public function get pelletTrailTexture() : ImageResource
      {
         return this._pelletTrailTexture;
      }
      
      public function set pelletTrailTexture(param1:ImageResource) : void
      {
         this._pelletTrailTexture = param1;
      }
      
      public function get reloadSound() : SoundResource
      {
         return this._reloadSound;
      }
      
      public function set reloadSound(param1:SoundResource) : void
      {
         this._reloadSound = param1;
      }
      
      public function get shotAcrossTexture() : MultiframeImageResource
      {
         return this._shotAcrossTexture;
      }
      
      public function set shotAcrossTexture(param1:MultiframeImageResource) : void
      {
         this._shotAcrossTexture = param1;
      }
      
      public function get shotAlongTexture() : MultiframeImageResource
      {
         return this._shotAlongTexture;
      }
      
      public function set shotAlongTexture(param1:MultiframeImageResource) : void
      {
         this._shotAlongTexture = param1;
      }
      
      public function get shotSound() : SoundResource
      {
         return this._shotSound;
      }
      
      public function set shotSound(param1:SoundResource) : void
      {
         this._shotSound = param1;
      }
      
      public function get smokeTexture() : MultiframeImageResource
      {
         return this._smokeTexture;
      }
      
      public function set smokeTexture(param1:MultiframeImageResource) : void
      {
         this._smokeTexture = param1;
      }
      
      public function get sparkleTexture() : ImageResource
      {
         return this._sparkleTexture;
      }
      
      public function set sparkleTexture(param1:ImageResource) : void
      {
         this._sparkleTexture = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ShotgunSFXCC [";
         _loc1_ += "explosionMarkTextures = " + this.explosionMarkTextures + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "magazineReloadSound = " + this.magazineReloadSound + " ";
         _loc1_ += "pelletTrailTexture = " + this.pelletTrailTexture + " ";
         _loc1_ += "reloadSound = " + this.reloadSound + " ";
         _loc1_ += "shotAcrossTexture = " + this.shotAcrossTexture + " ";
         _loc1_ += "shotAlongTexture = " + this.shotAlongTexture + " ";
         _loc1_ += "shotSound = " + this.shotSound + " ";
         _loc1_ += "smokeTexture = " + this.smokeTexture + " ";
         _loc1_ += "sparkleTexture = " + this.sparkleTexture + " ";
         return _loc1_ + "]";
      }
   }
}

