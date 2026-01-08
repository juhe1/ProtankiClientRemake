package projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class MachineGunSFXCC
   {
      
      private var _chainStartSound:SoundResource;
      
      private var _crumbsTexture:ImageResource;
      
      private var _dustTexture:MultiframeImageResource;
      
      private var _fireAcrossTexture:MultiframeImageResource;
      
      private var _fireAlongTexture:MultiframeImageResource;
      
      private var _hitSound:SoundResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _longFailSound:SoundResource;
      
      private var _shootEndSound:SoundResource;
      
      private var _shootSound:SoundResource;
      
      private var _smokeTexture:MultiframeImageResource;
      
      private var _sparklesTexture:MultiframeImageResource;
      
      private var _tankHitSound:SoundResource;
      
      private var _tankSparklesTexture:MultiframeImageResource;
      
      private var _tracerTexture:ImageResource;
      
      private var _turbineStartSound:SoundResource;
      
      public function MachineGunSFXCC(param1:SoundResource = null, param2:ImageResource = null, param3:MultiframeImageResource = null, param4:MultiframeImageResource = null, param5:MultiframeImageResource = null, param6:SoundResource = null, param7:LightingSFXEntity = null, param8:SoundResource = null, param9:SoundResource = null, param10:SoundResource = null, param11:MultiframeImageResource = null, param12:MultiframeImageResource = null, param13:SoundResource = null, param14:MultiframeImageResource = null, param15:ImageResource = null, param16:SoundResource = null)
      {
         super();
         this._chainStartSound = param1;
         this._crumbsTexture = param2;
         this._dustTexture = param3;
         this._fireAcrossTexture = param4;
         this._fireAlongTexture = param5;
         this._hitSound = param6;
         this._lightingSFXEntity = param7;
         this._longFailSound = param8;
         this._shootEndSound = param9;
         this._shootSound = param10;
         this._smokeTexture = param11;
         this._sparklesTexture = param12;
         this._tankHitSound = param13;
         this._tankSparklesTexture = param14;
         this._tracerTexture = param15;
         this._turbineStartSound = param16;
      }
      
      public function get chainStartSound() : SoundResource
      {
         return this._chainStartSound;
      }
      
      public function set chainStartSound(param1:SoundResource) : void
      {
         this._chainStartSound = param1;
      }
      
      public function get crumbsTexture() : ImageResource
      {
         return this._crumbsTexture;
      }
      
      public function set crumbsTexture(param1:ImageResource) : void
      {
         this._crumbsTexture = param1;
      }
      
      public function get dustTexture() : MultiframeImageResource
      {
         return this._dustTexture;
      }
      
      public function set dustTexture(param1:MultiframeImageResource) : void
      {
         this._dustTexture = param1;
      }
      
      public function get fireAcrossTexture() : MultiframeImageResource
      {
         return this._fireAcrossTexture;
      }
      
      public function set fireAcrossTexture(param1:MultiframeImageResource) : void
      {
         this._fireAcrossTexture = param1;
      }
      
      public function get fireAlongTexture() : MultiframeImageResource
      {
         return this._fireAlongTexture;
      }
      
      public function set fireAlongTexture(param1:MultiframeImageResource) : void
      {
         this._fireAlongTexture = param1;
      }
      
      public function get hitSound() : SoundResource
      {
         return this._hitSound;
      }
      
      public function set hitSound(param1:SoundResource) : void
      {
         this._hitSound = param1;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get longFailSound() : SoundResource
      {
         return this._longFailSound;
      }
      
      public function set longFailSound(param1:SoundResource) : void
      {
         this._longFailSound = param1;
      }
      
      public function get shootEndSound() : SoundResource
      {
         return this._shootEndSound;
      }
      
      public function set shootEndSound(param1:SoundResource) : void
      {
         this._shootEndSound = param1;
      }
      
      public function get shootSound() : SoundResource
      {
         return this._shootSound;
      }
      
      public function set shootSound(param1:SoundResource) : void
      {
         this._shootSound = param1;
      }
      
      public function get smokeTexture() : MultiframeImageResource
      {
         return this._smokeTexture;
      }
      
      public function set smokeTexture(param1:MultiframeImageResource) : void
      {
         this._smokeTexture = param1;
      }
      
      public function get sparklesTexture() : MultiframeImageResource
      {
         return this._sparklesTexture;
      }
      
      public function set sparklesTexture(param1:MultiframeImageResource) : void
      {
         this._sparklesTexture = param1;
      }
      
      public function get tankHitSound() : SoundResource
      {
         return this._tankHitSound;
      }
      
      public function set tankHitSound(param1:SoundResource) : void
      {
         this._tankHitSound = param1;
      }
      
      public function get tankSparklesTexture() : MultiframeImageResource
      {
         return this._tankSparklesTexture;
      }
      
      public function set tankSparklesTexture(param1:MultiframeImageResource) : void
      {
         this._tankSparklesTexture = param1;
      }
      
      public function get tracerTexture() : ImageResource
      {
         return this._tracerTexture;
      }
      
      public function set tracerTexture(param1:ImageResource) : void
      {
         this._tracerTexture = param1;
      }
      
      public function get turbineStartSound() : SoundResource
      {
         return this._turbineStartSound;
      }
      
      public function set turbineStartSound(param1:SoundResource) : void
      {
         this._turbineStartSound = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "MachineGunSFXCC [";
         _loc1_ += "chainStartSound = " + this.chainStartSound + " ";
         _loc1_ += "crumbsTexture = " + this.crumbsTexture + " ";
         _loc1_ += "dustTexture = " + this.dustTexture + " ";
         _loc1_ += "fireAcrossTexture = " + this.fireAcrossTexture + " ";
         _loc1_ += "fireAlongTexture = " + this.fireAlongTexture + " ";
         _loc1_ += "hitSound = " + this.hitSound + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "longFailSound = " + this.longFailSound + " ";
         _loc1_ += "shootEndSound = " + this.shootEndSound + " ";
         _loc1_ += "shootSound = " + this.shootSound + " ";
         _loc1_ += "smokeTexture = " + this.smokeTexture + " ";
         _loc1_ += "sparklesTexture = " + this.sparklesTexture + " ";
         _loc1_ += "tankHitSound = " + this.tankHitSound + " ";
         _loc1_ += "tankSparklesTexture = " + this.tankSparklesTexture + " ";
         _loc1_ += "tracerTexture = " + this.tracerTexture + " ";
         _loc1_ += "turbineStartSound = " + this.turbineStartSound + " ";
         return _loc1_ + "]";
      }
   }
}

