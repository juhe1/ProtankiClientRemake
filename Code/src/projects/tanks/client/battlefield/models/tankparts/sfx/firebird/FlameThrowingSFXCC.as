package projects.tanks.client.battlefield.models.tankparts.sfx.firebird
{
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class FlameThrowingSFXCC
   {
      
      private var _fireTexture:MultiframeTextureResource;
      
      private var _flameSound:SoundResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _muzzlePlaneTexture:MultiframeTextureResource;
      
      public function FlameThrowingSFXCC(param1:MultiframeTextureResource = null, param2:SoundResource = null, param3:LightingSFXEntity = null, param4:MultiframeTextureResource = null)
      {
         super();
         this._fireTexture = param1;
         this._flameSound = param2;
         this._lightingSFXEntity = param3;
         this._muzzlePlaneTexture = param4;
      }
      
      public function get fireTexture() : MultiframeTextureResource
      {
         return this._fireTexture;
      }
      
      public function set fireTexture(param1:MultiframeTextureResource) : void
      {
         this._fireTexture = param1;
      }
      
      public function get flameSound() : SoundResource
      {
         return this._flameSound;
      }
      
      public function set flameSound(param1:SoundResource) : void
      {
         this._flameSound = param1;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get muzzlePlaneTexture() : MultiframeTextureResource
      {
         return this._muzzlePlaneTexture;
      }
      
      public function set muzzlePlaneTexture(param1:MultiframeTextureResource) : void
      {
         this._muzzlePlaneTexture = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "FlameThrowingSFXCC [";
         _loc1_ += "fireTexture = " + this.fireTexture + " ";
         _loc1_ += "flameSound = " + this.flameSound + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "muzzlePlaneTexture = " + this.muzzlePlaneTexture + " ";
         return _loc1_ + "]";
      }
   }
}

