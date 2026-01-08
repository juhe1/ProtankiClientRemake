package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class RicochetSFXCC
   {
      
      private var _bumpFlashTexture:MultiframeImageResource;
      
      private var _explosionTexture:MultiframeImageResource;
      
      private var _explostinSound:SoundResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _ricochetSound:SoundResource;
      
      private var _shotFlashTexture:ImageResource;
      
      private var _shotSound:SoundResource;
      
      private var _shotTexture:MultiframeImageResource;
      
      private var _tailTrailTexutre:ImageResource;
      
      public function RicochetSFXCC(param1:MultiframeImageResource = null, param2:MultiframeImageResource = null, param3:SoundResource = null, param4:LightingSFXEntity = null, param5:SoundResource = null, param6:ImageResource = null, param7:SoundResource = null, param8:MultiframeImageResource = null, param9:ImageResource = null)
      {
         super();
         this._bumpFlashTexture = param1;
         this._explosionTexture = param2;
         this._explostinSound = param3;
         this._lightingSFXEntity = param4;
         this._ricochetSound = param5;
         this._shotFlashTexture = param6;
         this._shotSound = param7;
         this._shotTexture = param8;
         this._tailTrailTexutre = param9;
      }
      
      public function get bumpFlashTexture() : MultiframeImageResource
      {
         return this._bumpFlashTexture;
      }
      
      public function set bumpFlashTexture(param1:MultiframeImageResource) : void
      {
         this._bumpFlashTexture = param1;
      }
      
      public function get explosionTexture() : MultiframeImageResource
      {
         return this._explosionTexture;
      }
      
      public function set explosionTexture(param1:MultiframeImageResource) : void
      {
         this._explosionTexture = param1;
      }
      
      public function get explostinSound() : SoundResource
      {
         return this._explostinSound;
      }
      
      public function set explostinSound(param1:SoundResource) : void
      {
         this._explostinSound = param1;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get ricochetSound() : SoundResource
      {
         return this._ricochetSound;
      }
      
      public function set ricochetSound(param1:SoundResource) : void
      {
         this._ricochetSound = param1;
      }
      
      public function get shotFlashTexture() : ImageResource
      {
         return this._shotFlashTexture;
      }
      
      public function set shotFlashTexture(param1:ImageResource) : void
      {
         this._shotFlashTexture = param1;
      }
      
      public function get shotSound() : SoundResource
      {
         return this._shotSound;
      }
      
      public function set shotSound(param1:SoundResource) : void
      {
         this._shotSound = param1;
      }
      
      public function get shotTexture() : MultiframeImageResource
      {
         return this._shotTexture;
      }
      
      public function set shotTexture(param1:MultiframeImageResource) : void
      {
         this._shotTexture = param1;
      }
      
      public function get tailTrailTexutre() : ImageResource
      {
         return this._tailTrailTexutre;
      }
      
      public function set tailTrailTexutre(param1:ImageResource) : void
      {
         this._tailTrailTexutre = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "RicochetSFXCC [";
         _loc1_ += "bumpFlashTexture = " + this.bumpFlashTexture + " ";
         _loc1_ += "explosionTexture = " + this.explosionTexture + " ";
         _loc1_ += "explostinSound = " + this.explostinSound + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "ricochetSound = " + this.ricochetSound + " ";
         _loc1_ += "shotFlashTexture = " + this.shotFlashTexture + " ";
         _loc1_ += "shotSound = " + this.shotSound + " ";
         _loc1_ += "shotTexture = " + this.shotTexture + " ";
         _loc1_ += "tailTrailTexutre = " + this.tailTrailTexutre + " ";
         return _loc1_ + "]";
      }
   }
}

