package projects.tanks.client.battlefield.models.ultimate.effects.dictator
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class DictatorUltimateCC
   {
      
      private var _activationSound:SoundResource;
      
      private var _beam:ImageResource;
      
      private var _beamScale:Number;
      
      private var _secondaryBeamScale:Number;
      
      private var _star:ImageResource;
      
      private var _wave:ImageResource;
      
      private var _waveSize:Number;
      
      public function DictatorUltimateCC(param1:SoundResource = null, param2:ImageResource = null, param3:Number = 0, param4:Number = 0, param5:ImageResource = null, param6:ImageResource = null, param7:Number = 0)
      {
         super();
         this._activationSound = param1;
         this._beam = param2;
         this._beamScale = param3;
         this._secondaryBeamScale = param4;
         this._star = param5;
         this._wave = param6;
         this._waveSize = param7;
      }
      
      public function get activationSound() : SoundResource
      {
         return this._activationSound;
      }
      
      public function set activationSound(param1:SoundResource) : void
      {
         this._activationSound = param1;
      }
      
      public function get beam() : ImageResource
      {
         return this._beam;
      }
      
      public function set beam(param1:ImageResource) : void
      {
         this._beam = param1;
      }
      
      public function get beamScale() : Number
      {
         return this._beamScale;
      }
      
      public function set beamScale(param1:Number) : void
      {
         this._beamScale = param1;
      }
      
      public function get secondaryBeamScale() : Number
      {
         return this._secondaryBeamScale;
      }
      
      public function set secondaryBeamScale(param1:Number) : void
      {
         this._secondaryBeamScale = param1;
      }
      
      public function get star() : ImageResource
      {
         return this._star;
      }
      
      public function set star(param1:ImageResource) : void
      {
         this._star = param1;
      }
      
      public function get wave() : ImageResource
      {
         return this._wave;
      }
      
      public function set wave(param1:ImageResource) : void
      {
         this._wave = param1;
      }
      
      public function get waveSize() : Number
      {
         return this._waveSize;
      }
      
      public function set waveSize(param1:Number) : void
      {
         this._waveSize = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DictatorUltimateCC [";
         _loc1_ += "activationSound = " + this.activationSound + " ";
         _loc1_ += "beam = " + this.beam + " ";
         _loc1_ += "beamScale = " + this.beamScale + " ";
         _loc1_ += "secondaryBeamScale = " + this.secondaryBeamScale + " ";
         _loc1_ += "star = " + this.star + " ";
         _loc1_ += "wave = " + this.wave + " ";
         _loc1_ += "waveSize = " + this.waveSize + " ";
         return _loc1_ + "]";
      }
   }
}

