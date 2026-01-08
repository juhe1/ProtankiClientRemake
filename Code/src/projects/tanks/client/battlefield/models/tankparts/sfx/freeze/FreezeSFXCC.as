package projects.tanks.client.battlefield.models.tankparts.sfx.freeze
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class FreezeSFXCC
   {
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _particleSpeed:Number;
      
      private var _particleTextureResource:MultiframeImageResource;
      
      private var _planeTextureResource:MultiframeImageResource;
      
      private var _shotSoundResource:SoundResource;
      
      public function FreezeSFXCC(param1:LightingSFXEntity = null, param2:Number = 0, param3:MultiframeImageResource = null, param4:MultiframeImageResource = null, param5:SoundResource = null)
      {
         super();
         this._lightingSFXEntity = param1;
         this._particleSpeed = param2;
         this._particleTextureResource = param3;
         this._planeTextureResource = param4;
         this._shotSoundResource = param5;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get particleSpeed() : Number
      {
         return this._particleSpeed;
      }
      
      public function set particleSpeed(param1:Number) : void
      {
         this._particleSpeed = param1;
      }
      
      public function get particleTextureResource() : MultiframeImageResource
      {
         return this._particleTextureResource;
      }
      
      public function set particleTextureResource(param1:MultiframeImageResource) : void
      {
         this._particleTextureResource = param1;
      }
      
      public function get planeTextureResource() : MultiframeImageResource
      {
         return this._planeTextureResource;
      }
      
      public function set planeTextureResource(param1:MultiframeImageResource) : void
      {
         this._planeTextureResource = param1;
      }
      
      public function get shotSoundResource() : SoundResource
      {
         return this._shotSoundResource;
      }
      
      public function set shotSoundResource(param1:SoundResource) : void
      {
         this._shotSoundResource = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "FreezeSFXCC [";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "particleSpeed = " + this.particleSpeed + " ";
         _loc1_ += "particleTextureResource = " + this.particleTextureResource + " ";
         _loc1_ += "planeTextureResource = " + this.planeTextureResource + " ";
         _loc1_ += "shotSoundResource = " + this.shotSoundResource + " ";
         return _loc1_ + "]";
      }
   }
}

