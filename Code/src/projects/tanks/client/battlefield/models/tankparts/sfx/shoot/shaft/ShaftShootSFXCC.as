package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class ShaftShootSFXCC
   {
      
      private var _explosionSound:SoundResource;
      
      private var _explosionTexture:MultiframeImageResource;
      
      private var _hitMarkTexture:ImageResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _muzzleFlashTexture:MultiframeImageResource;
      
      private var _shotSound:SoundResource;
      
      private var _targetingSound:SoundResource;
      
      private var _trailTexture:ImageResource;
      
      private var _zoomModeSound:SoundResource;
      
      public function ShaftShootSFXCC(param1:SoundResource = null, param2:MultiframeImageResource = null, param3:ImageResource = null, param4:LightingSFXEntity = null, param5:MultiframeImageResource = null, param6:SoundResource = null, param7:SoundResource = null, param8:ImageResource = null, param9:SoundResource = null)
      {
         super();
         this._explosionSound = param1;
         this._explosionTexture = param2;
         this._hitMarkTexture = param3;
         this._lightingSFXEntity = param4;
         this._muzzleFlashTexture = param5;
         this._shotSound = param6;
         this._targetingSound = param7;
         this._trailTexture = param8;
         this._zoomModeSound = param9;
      }
      
      public function get explosionSound() : SoundResource
      {
         return this._explosionSound;
      }
      
      public function set explosionSound(param1:SoundResource) : void
      {
         this._explosionSound = param1;
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
      
      public function get muzzleFlashTexture() : MultiframeImageResource
      {
         return this._muzzleFlashTexture;
      }
      
      public function set muzzleFlashTexture(param1:MultiframeImageResource) : void
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
      
      public function get targetingSound() : SoundResource
      {
         return this._targetingSound;
      }
      
      public function set targetingSound(param1:SoundResource) : void
      {
         this._targetingSound = param1;
      }
      
      public function get trailTexture() : ImageResource
      {
         return this._trailTexture;
      }
      
      public function set trailTexture(param1:ImageResource) : void
      {
         this._trailTexture = param1;
      }
      
      public function get zoomModeSound() : SoundResource
      {
         return this._zoomModeSound;
      }
      
      public function set zoomModeSound(param1:SoundResource) : void
      {
         this._zoomModeSound = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ShaftShootSFXCC [";
         _loc1_ += "explosionSound = " + this.explosionSound + " ";
         _loc1_ += "explosionTexture = " + this.explosionTexture + " ";
         _loc1_ += "hitMarkTexture = " + this.hitMarkTexture + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "muzzleFlashTexture = " + this.muzzleFlashTexture + " ";
         _loc1_ += "shotSound = " + this.shotSound + " ";
         _loc1_ += "targetingSound = " + this.targetingSound + " ";
         _loc1_ += "trailTexture = " + this.trailTexture + " ";
         _loc1_ += "zoomModeSound = " + this.zoomModeSound + " ";
         return _loc1_ + "]";
      }
   }
}

