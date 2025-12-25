package projects.tanks.client.battlefield.models.battle.cp.resources
{
   import platform.client.fp10.core.resource.types.SoundResource;
   
   public class DominationSounds
   {
      
      private var _pointCaptureStartNegativeSound:SoundResource;
      
      private var _pointCaptureStartPositiveSound:SoundResource;
      
      private var _pointCaptureStopNegativeSound:SoundResource;
      
      private var _pointCaptureStopPositiveSound:SoundResource;
      
      private var _pointCapturedNegativeSound:SoundResource;
      
      private var _pointCapturedPositiveSound:SoundResource;
      
      private var _pointNeutralizedNegativeSound:SoundResource;
      
      private var _pointNeutralizedPositiveSound:SoundResource;
      
      private var _pointScoreDecreasingSound:SoundResource;
      
      private var _pointScoreIncreasingSound:SoundResource;
      
      public function DominationSounds(param1:SoundResource = null, param2:SoundResource = null, param3:SoundResource = null, param4:SoundResource = null, param5:SoundResource = null, param6:SoundResource = null, param7:SoundResource = null, param8:SoundResource = null, param9:SoundResource = null, param10:SoundResource = null)
      {
         super();
         this._pointCaptureStartNegativeSound = param1;
         this._pointCaptureStartPositiveSound = param2;
         this._pointCaptureStopNegativeSound = param3;
         this._pointCaptureStopPositiveSound = param4;
         this._pointCapturedNegativeSound = param5;
         this._pointCapturedPositiveSound = param6;
         this._pointNeutralizedNegativeSound = param7;
         this._pointNeutralizedPositiveSound = param8;
         this._pointScoreDecreasingSound = param9;
         this._pointScoreIncreasingSound = param10;
      }
      
      public function get pointCaptureStartNegativeSound() : SoundResource
      {
         return this._pointCaptureStartNegativeSound;
      }
      
      public function set pointCaptureStartNegativeSound(param1:SoundResource) : void
      {
         this._pointCaptureStartNegativeSound = param1;
      }
      
      public function get pointCaptureStartPositiveSound() : SoundResource
      {
         return this._pointCaptureStartPositiveSound;
      }
      
      public function set pointCaptureStartPositiveSound(param1:SoundResource) : void
      {
         this._pointCaptureStartPositiveSound = param1;
      }
      
      public function get pointCaptureStopNegativeSound() : SoundResource
      {
         return this._pointCaptureStopNegativeSound;
      }
      
      public function set pointCaptureStopNegativeSound(param1:SoundResource) : void
      {
         this._pointCaptureStopNegativeSound = param1;
      }
      
      public function get pointCaptureStopPositiveSound() : SoundResource
      {
         return this._pointCaptureStopPositiveSound;
      }
      
      public function set pointCaptureStopPositiveSound(param1:SoundResource) : void
      {
         this._pointCaptureStopPositiveSound = param1;
      }
      
      public function get pointCapturedNegativeSound() : SoundResource
      {
         return this._pointCapturedNegativeSound;
      }
      
      public function set pointCapturedNegativeSound(param1:SoundResource) : void
      {
         this._pointCapturedNegativeSound = param1;
      }
      
      public function get pointCapturedPositiveSound() : SoundResource
      {
         return this._pointCapturedPositiveSound;
      }
      
      public function set pointCapturedPositiveSound(param1:SoundResource) : void
      {
         this._pointCapturedPositiveSound = param1;
      }
      
      public function get pointNeutralizedNegativeSound() : SoundResource
      {
         return this._pointNeutralizedNegativeSound;
      }
      
      public function set pointNeutralizedNegativeSound(param1:SoundResource) : void
      {
         this._pointNeutralizedNegativeSound = param1;
      }
      
      public function get pointNeutralizedPositiveSound() : SoundResource
      {
         return this._pointNeutralizedPositiveSound;
      }
      
      public function set pointNeutralizedPositiveSound(param1:SoundResource) : void
      {
         this._pointNeutralizedPositiveSound = param1;
      }
      
      public function get pointScoreDecreasingSound() : SoundResource
      {
         return this._pointScoreDecreasingSound;
      }
      
      public function set pointScoreDecreasingSound(param1:SoundResource) : void
      {
         this._pointScoreDecreasingSound = param1;
      }
      
      public function get pointScoreIncreasingSound() : SoundResource
      {
         return this._pointScoreIncreasingSound;
      }
      
      public function set pointScoreIncreasingSound(param1:SoundResource) : void
      {
         this._pointScoreIncreasingSound = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DominationSounds [";
         _loc1_ += "pointCaptureStartNegativeSound = " + this.pointCaptureStartNegativeSound + " ";
         _loc1_ += "pointCaptureStartPositiveSound = " + this.pointCaptureStartPositiveSound + " ";
         _loc1_ += "pointCaptureStopNegativeSound = " + this.pointCaptureStopNegativeSound + " ";
         _loc1_ += "pointCaptureStopPositiveSound = " + this.pointCaptureStopPositiveSound + " ";
         _loc1_ += "pointCapturedNegativeSound = " + this.pointCapturedNegativeSound + " ";
         _loc1_ += "pointCapturedPositiveSound = " + this.pointCapturedPositiveSound + " ";
         _loc1_ += "pointNeutralizedNegativeSound = " + this.pointNeutralizedNegativeSound + " ";
         _loc1_ += "pointNeutralizedPositiveSound = " + this.pointNeutralizedPositiveSound + " ";
         _loc1_ += "pointScoreDecreasingSound = " + this.pointScoreDecreasingSound + " ";
         _loc1_ += "pointScoreIncreasingSound = " + this.pointScoreIncreasingSound + " ";
         return _loc1_ + "]";
      }
   }
}

