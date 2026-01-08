package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class ThunderShootSFXCC
   {
      
      private var _explosionMarkTexture:ImageResource;
      
      private var _explosionSize:Number;
      
      private var _explosionSound:SoundResource;
      
      private var _explosionTexture:MultiframeImageResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _shotSound:SoundResource;
      
      private var _shotTexture:ImageResource;
      
      public function ThunderShootSFXCC(param1:ImageResource = null, param2:Number = 0, param3:SoundResource = null, param4:MultiframeImageResource = null, param5:LightingSFXEntity = null, param6:SoundResource = null, param7:ImageResource = null)
      {
         super();
         this._explosionMarkTexture = param1;
         this._explosionSize = param2;
         this._explosionSound = param3;
         this._explosionTexture = param4;
         this._lightingSFXEntity = param5;
         this._shotSound = param6;
         this._shotTexture = param7;
      }
      
      public function get explosionMarkTexture() : ImageResource
      {
         return this._explosionMarkTexture;
      }
      
      public function set explosionMarkTexture(param1:ImageResource) : void
      {
         this._explosionMarkTexture = param1;
      }
      
      public function get explosionSize() : Number
      {
         return this._explosionSize;
      }
      
      public function set explosionSize(param1:Number) : void
      {
         this._explosionSize = param1;
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
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get shotSound() : SoundResource
      {
         return this._shotSound;
      }
      
      public function set shotSound(param1:SoundResource) : void
      {
         this._shotSound = param1;
      }
      
      public function get shotTexture() : ImageResource
      {
         return this._shotTexture;
      }
      
      public function set shotTexture(param1:ImageResource) : void
      {
         this._shotTexture = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ThunderShootSFXCC [";
         _loc1_ += "explosionMarkTexture = " + this.explosionMarkTexture + " ";
         _loc1_ += "explosionSize = " + this.explosionSize + " ";
         _loc1_ += "explosionSound = " + this.explosionSound + " ";
         _loc1_ += "explosionTexture = " + this.explosionTexture + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "shotSound = " + this.shotSound + " ";
         _loc1_ += "shotTexture = " + this.shotTexture + " ";
         return _loc1_ + "]";
      }
   }
}

