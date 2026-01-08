package projects.tanks.client.battlefield.models.battle.battlefield.meteors
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class MeteorStormCC
   {
      
      private var _bigSplashRadius:Number;
      
      private var _craterDecal:ImageResource;
      
      private var _currentMeteors:Vector.<MeteorDescriptor>;
      
      private var _impactSoundTimelabel:int;
      
      private var _meteorArrivingSound:SoundResource;
      
      private var _meteorDistantSound:SoundResource;
      
      private var _meteorFlyDistance:Number;
      
      private var _meteorModel:Tanks3DSResource;
      
      private var _meteorSpeed:Number;
      
      private var _nuclearBangFlame:ImageResource;
      
      private var _nuclearBangLight:ImageResource;
      
      private var _nuclearBangSmoke:ImageResource;
      
      private var _nuclearBangSound:SoundResource;
      
      private var _nuclearBangWave:ImageResource;
      
      private var _preferredFallAngle:Number;
      
      private var _smallSplashRadius:Number;
      
      private var _splashDamageImpact:Number;
      
      private var _splashDamageMinPercent:Number;
      
      private var _tailFlame:ImageResource;
      
      private var _tailLight:Vector.<LightEffectItem>;
      
      private var _tailSmoke:ImageResource;
      
      public function MeteorStormCC(param1:Number = 0, param2:ImageResource = null, param3:Vector.<MeteorDescriptor> = null, param4:int = 0, param5:SoundResource = null, param6:SoundResource = null, param7:Number = 0, param8:Tanks3DSResource = null, param9:Number = 0, param10:ImageResource = null, param11:ImageResource = null, param12:ImageResource = null, param13:SoundResource = null, param14:ImageResource = null, param15:Number = 0, param16:Number = 0, param17:Number = 0, param18:Number = 0, param19:ImageResource = null, param20:Vector.<LightEffectItem> = null, param21:ImageResource = null)
      {
         super();
         this._bigSplashRadius = param1;
         this._craterDecal = param2;
         this._currentMeteors = param3;
         this._impactSoundTimelabel = param4;
         this._meteorArrivingSound = param5;
         this._meteorDistantSound = param6;
         this._meteorFlyDistance = param7;
         this._meteorModel = param8;
         this._meteorSpeed = param9;
         this._nuclearBangFlame = param10;
         this._nuclearBangLight = param11;
         this._nuclearBangSmoke = param12;
         this._nuclearBangSound = param13;
         this._nuclearBangWave = param14;
         this._preferredFallAngle = param15;
         this._smallSplashRadius = param16;
         this._splashDamageImpact = param17;
         this._splashDamageMinPercent = param18;
         this._tailFlame = param19;
         this._tailLight = param20;
         this._tailSmoke = param21;
      }
      
      public function get bigSplashRadius() : Number
      {
         return this._bigSplashRadius;
      }
      
      public function set bigSplashRadius(param1:Number) : void
      {
         this._bigSplashRadius = param1;
      }
      
      public function get craterDecal() : ImageResource
      {
         return this._craterDecal;
      }
      
      public function set craterDecal(param1:ImageResource) : void
      {
         this._craterDecal = param1;
      }
      
      public function get currentMeteors() : Vector.<MeteorDescriptor>
      {
         return this._currentMeteors;
      }
      
      public function set currentMeteors(param1:Vector.<MeteorDescriptor>) : void
      {
         this._currentMeteors = param1;
      }
      
      public function get impactSoundTimelabel() : int
      {
         return this._impactSoundTimelabel;
      }
      
      public function set impactSoundTimelabel(param1:int) : void
      {
         this._impactSoundTimelabel = param1;
      }
      
      public function get meteorArrivingSound() : SoundResource
      {
         return this._meteorArrivingSound;
      }
      
      public function set meteorArrivingSound(param1:SoundResource) : void
      {
         this._meteorArrivingSound = param1;
      }
      
      public function get meteorDistantSound() : SoundResource
      {
         return this._meteorDistantSound;
      }
      
      public function set meteorDistantSound(param1:SoundResource) : void
      {
         this._meteorDistantSound = param1;
      }
      
      public function get meteorFlyDistance() : Number
      {
         return this._meteorFlyDistance;
      }
      
      public function set meteorFlyDistance(param1:Number) : void
      {
         this._meteorFlyDistance = param1;
      }
      
      public function get meteorModel() : Tanks3DSResource
      {
         return this._meteorModel;
      }
      
      public function set meteorModel(param1:Tanks3DSResource) : void
      {
         this._meteorModel = param1;
      }
      
      public function get meteorSpeed() : Number
      {
         return this._meteorSpeed;
      }
      
      public function set meteorSpeed(param1:Number) : void
      {
         this._meteorSpeed = param1;
      }
      
      public function get nuclearBangFlame() : ImageResource
      {
         return this._nuclearBangFlame;
      }
      
      public function set nuclearBangFlame(param1:ImageResource) : void
      {
         this._nuclearBangFlame = param1;
      }
      
      public function get nuclearBangLight() : ImageResource
      {
         return this._nuclearBangLight;
      }
      
      public function set nuclearBangLight(param1:ImageResource) : void
      {
         this._nuclearBangLight = param1;
      }
      
      public function get nuclearBangSmoke() : ImageResource
      {
         return this._nuclearBangSmoke;
      }
      
      public function set nuclearBangSmoke(param1:ImageResource) : void
      {
         this._nuclearBangSmoke = param1;
      }
      
      public function get nuclearBangSound() : SoundResource
      {
         return this._nuclearBangSound;
      }
      
      public function set nuclearBangSound(param1:SoundResource) : void
      {
         this._nuclearBangSound = param1;
      }
      
      public function get nuclearBangWave() : ImageResource
      {
         return this._nuclearBangWave;
      }
      
      public function set nuclearBangWave(param1:ImageResource) : void
      {
         this._nuclearBangWave = param1;
      }
      
      public function get preferredFallAngle() : Number
      {
         return this._preferredFallAngle;
      }
      
      public function set preferredFallAngle(param1:Number) : void
      {
         this._preferredFallAngle = param1;
      }
      
      public function get smallSplashRadius() : Number
      {
         return this._smallSplashRadius;
      }
      
      public function set smallSplashRadius(param1:Number) : void
      {
         this._smallSplashRadius = param1;
      }
      
      public function get splashDamageImpact() : Number
      {
         return this._splashDamageImpact;
      }
      
      public function set splashDamageImpact(param1:Number) : void
      {
         this._splashDamageImpact = param1;
      }
      
      public function get splashDamageMinPercent() : Number
      {
         return this._splashDamageMinPercent;
      }
      
      public function set splashDamageMinPercent(param1:Number) : void
      {
         this._splashDamageMinPercent = param1;
      }
      
      public function get tailFlame() : ImageResource
      {
         return this._tailFlame;
      }
      
      public function set tailFlame(param1:ImageResource) : void
      {
         this._tailFlame = param1;
      }
      
      public function get tailLight() : Vector.<LightEffectItem>
      {
         return this._tailLight;
      }
      
      public function set tailLight(param1:Vector.<LightEffectItem>) : void
      {
         this._tailLight = param1;
      }
      
      public function get tailSmoke() : ImageResource
      {
         return this._tailSmoke;
      }
      
      public function set tailSmoke(param1:ImageResource) : void
      {
         this._tailSmoke = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "MeteorStormCC [";
         _loc1_ += "bigSplashRadius = " + this.bigSplashRadius + " ";
         _loc1_ += "craterDecal = " + this.craterDecal + " ";
         _loc1_ += "currentMeteors = " + this.currentMeteors + " ";
         _loc1_ += "impactSoundTimelabel = " + this.impactSoundTimelabel + " ";
         _loc1_ += "meteorArrivingSound = " + this.meteorArrivingSound + " ";
         _loc1_ += "meteorDistantSound = " + this.meteorDistantSound + " ";
         _loc1_ += "meteorFlyDistance = " + this.meteorFlyDistance + " ";
         _loc1_ += "meteorModel = " + this.meteorModel + " ";
         _loc1_ += "meteorSpeed = " + this.meteorSpeed + " ";
         _loc1_ += "nuclearBangFlame = " + this.nuclearBangFlame + " ";
         _loc1_ += "nuclearBangLight = " + this.nuclearBangLight + " ";
         _loc1_ += "nuclearBangSmoke = " + this.nuclearBangSmoke + " ";
         _loc1_ += "nuclearBangSound = " + this.nuclearBangSound + " ";
         _loc1_ += "nuclearBangWave = " + this.nuclearBangWave + " ";
         _loc1_ += "preferredFallAngle = " + this.preferredFallAngle + " ";
         _loc1_ += "smallSplashRadius = " + this.smallSplashRadius + " ";
         _loc1_ += "splashDamageImpact = " + this.splashDamageImpact + " ";
         _loc1_ += "splashDamageMinPercent = " + this.splashDamageMinPercent + " ";
         _loc1_ += "tailFlame = " + this.tailFlame + " ";
         _loc1_ += "tailLight = " + this.tailLight + " ";
         _loc1_ += "tailSmoke = " + this.tailSmoke + " ";
         return _loc1_ + "]";
      }
   }
}

