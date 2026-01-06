package projects.tanks.client.battlefield.models.battle.pointbased.rugby.explosion
{
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class BallExplosionCC
   {
      
      private var _explosionSound:SoundResource;
      
      private var _explosionTexture:MultiframeTextureResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _smokeTextureId:MultiframeTextureResource;
      
      public function BallExplosionCC(param1:SoundResource = null, param2:MultiframeTextureResource = null, param3:LightingSFXEntity = null, param4:MultiframeTextureResource = null)
      {
         super();
         this._explosionSound = param1;
         this._explosionTexture = param2;
         this._lightingSFXEntity = param3;
         this._smokeTextureId = param4;
      }
      
      public function get explosionSound() : SoundResource
      {
         return this._explosionSound;
      }
      
      public function set explosionSound(param1:SoundResource) : void
      {
         this._explosionSound = param1;
      }
      
      public function get explosionTexture() : MultiframeTextureResource
      {
         return this._explosionTexture;
      }
      
      public function set explosionTexture(param1:MultiframeTextureResource) : void
      {
         this._explosionTexture = param1;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get smokeTextureId() : MultiframeTextureResource
      {
         return this._smokeTextureId;
      }
      
      public function set smokeTextureId(param1:MultiframeTextureResource) : void
      {
         this._smokeTextureId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BallExplosionCC [";
         _loc1_ += "explosionSound = " + this.explosionSound + " ";
         _loc1_ += "explosionTexture = " + this.explosionTexture + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "smokeTextureId = " + this.smokeTextureId + " ";
         return _loc1_ + "]";
      }
   }
}

