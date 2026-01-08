package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class TwinsShootSFXCC
   {
      
      private var _explosionTexture:MultiframeImageResource;
      
      private var _hitMarkTexture:ImageResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _muzzleFlashTexture:ImageResource;
      
      private var _shotSound:SoundResource;
      
      private var _shotTexture:MultiframeImageResource;
      
      public function TwinsShootSFXCC(param1:MultiframeImageResource = null, param2:ImageResource = null, param3:LightingSFXEntity = null, param4:ImageResource = null, param5:SoundResource = null, param6:MultiframeImageResource = null)
      {
         super();
         this._explosionTexture = param1;
         this._hitMarkTexture = param2;
         this._lightingSFXEntity = param3;
         this._muzzleFlashTexture = param4;
         this._shotSound = param5;
         this._shotTexture = param6;
      }
      
      public function get explosionTexture() : MultiframeImageResource
      {
         return this._explosionTexture;
      }
      
      public function set explosionTexture(param1:MultiframeImageResource) : void
      {
         this._explosionTexture = param1;
      }
      
      public function get hitMarkTexture() : ImageResource
      {
         return this._hitMarkTexture;
      }
      
      public function set hitMarkTexture(param1:ImageResource) : void
      {
         this._hitMarkTexture = param1;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get muzzleFlashTexture() : ImageResource
      {
         return this._muzzleFlashTexture;
      }
      
      public function set muzzleFlashTexture(param1:ImageResource) : void
      {
         this._muzzleFlashTexture = param1;
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
      
      public function toString() : String
      {
         var _loc1_:String = "TwinsShootSFXCC [";
         _loc1_ += "explosionTexture = " + this.explosionTexture + " ";
         _loc1_ += "hitMarkTexture = " + this.hitMarkTexture + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "muzzleFlashTexture = " + this.muzzleFlashTexture + " ";
         _loc1_ += "shotSound = " + this.shotSound + " ";
         _loc1_ += "shotTexture = " + this.shotTexture + " ";
         return _loc1_ + "]";
      }
   }
}

