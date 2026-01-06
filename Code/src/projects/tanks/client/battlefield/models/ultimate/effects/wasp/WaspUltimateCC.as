package projects.tanks.client.battlefield.models.ultimate.effects.wasp
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class WaspUltimateCC
   {
      
      private var _bigSplashRadius:Number;
      
      private var _bomb:Tanks3DSResource;
      
      private var _craterDecal:TextureResource;
      
      private var _effectStartSound:SoundResource;
      
      private var _nuclearBangFlame:TextureResource;
      
      private var _nuclearBangLight:TextureResource;
      
      private var _nuclearBangSmoke:TextureResource;
      
      private var _nuclearBangSound:SoundResource;
      
      private var _nuclearBangWave:TextureResource;
      
      private var _smallSplashRadius:Number;
      
      private var _splashDamageImpact:Number;
      
      private var _splashDamageMinPercent:Number;
      
      public function WaspUltimateCC(param1:Number = 0, param2:Tanks3DSResource = null, param3:TextureResource = null, param4:SoundResource = null, param5:TextureResource = null, param6:TextureResource = null, param7:TextureResource = null, param8:SoundResource = null, param9:TextureResource = null, param10:Number = 0, param11:Number = 0, param12:Number = 0)
      {
         super();
         this._bigSplashRadius = param1;
         this._bomb = param2;
         this._craterDecal = param3;
         this._effectStartSound = param4;
         this._nuclearBangFlame = param5;
         this._nuclearBangLight = param6;
         this._nuclearBangSmoke = param7;
         this._nuclearBangSound = param8;
         this._nuclearBangWave = param9;
         this._smallSplashRadius = param10;
         this._splashDamageImpact = param11;
         this._splashDamageMinPercent = param12;
      }
      
      public function get bigSplashRadius() : Number
      {
         return this._bigSplashRadius;
      }
      
      public function set bigSplashRadius(param1:Number) : void
      {
         this._bigSplashRadius = param1;
      }
      
      public function get bomb() : Tanks3DSResource
      {
         return this._bomb;
      }
      
      public function set bomb(param1:Tanks3DSResource) : void
      {
         this._bomb = param1;
      }
      
      public function get craterDecal() : TextureResource
      {
         return this._craterDecal;
      }
      
      public function set craterDecal(param1:TextureResource) : void
      {
         this._craterDecal = param1;
      }
      
      public function get effectStartSound() : SoundResource
      {
         return this._effectStartSound;
      }
      
      public function set effectStartSound(param1:SoundResource) : void
      {
         this._effectStartSound = param1;
      }
      
      public function get nuclearBangFlame() : TextureResource
      {
         return this._nuclearBangFlame;
      }
      
      public function set nuclearBangFlame(param1:TextureResource) : void
      {
         this._nuclearBangFlame = param1;
      }
      
      public function get nuclearBangLight() : TextureResource
      {
         return this._nuclearBangLight;
      }
      
      public function set nuclearBangLight(param1:TextureResource) : void
      {
         this._nuclearBangLight = param1;
      }
      
      public function get nuclearBangSmoke() : TextureResource
      {
         return this._nuclearBangSmoke;
      }
      
      public function set nuclearBangSmoke(param1:TextureResource) : void
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
      
      public function get nuclearBangWave() : TextureResource
      {
         return this._nuclearBangWave;
      }
      
      public function set nuclearBangWave(param1:TextureResource) : void
      {
         this._nuclearBangWave = param1;
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
      
      public function toString() : String
      {
         var _loc1_:String = "WaspUltimateCC [";
         _loc1_ += "bigSplashRadius = " + this.bigSplashRadius + " ";
         _loc1_ += "bomb = " + this.bomb + " ";
         _loc1_ += "craterDecal = " + this.craterDecal + " ";
         _loc1_ += "effectStartSound = " + this.effectStartSound + " ";
         _loc1_ += "nuclearBangFlame = " + this.nuclearBangFlame + " ";
         _loc1_ += "nuclearBangLight = " + this.nuclearBangLight + " ";
         _loc1_ += "nuclearBangSmoke = " + this.nuclearBangSmoke + " ";
         _loc1_ += "nuclearBangSound = " + this.nuclearBangSound + " ";
         _loc1_ += "nuclearBangWave = " + this.nuclearBangWave + " ";
         _loc1_ += "smallSplashRadius = " + this.smallSplashRadius + " ";
         _loc1_ += "splashDamageImpact = " + this.splashDamageImpact + " ";
         _loc1_ += "splashDamageMinPercent = " + this.splashDamageMinPercent + " ";
         return _loc1_ + "]";
      }
   }
}

