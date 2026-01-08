package projects.tanks.client.battlefield.models.battle.ctf
{
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class CaptureTheFlagCC
   {
      
      private var _blueFlag:ClientFlag;
      
      private var _blueFlagModel:Tanks3DSResource;
      
      private var _blueFlagSprite:ImageResource;
      
      private var _bluePedestalModel:Tanks3DSResource;
      
      private var _redFlag:ClientFlag;
      
      private var _redFlagModel:Tanks3DSResource;
      
      private var _redFlagSprite:ImageResource;
      
      private var _redPedestalModel:Tanks3DSResource;
      
      private var _sounds:CaptureTheFlagSoundFX;
      
      public function CaptureTheFlagCC(param1:ClientFlag = null, param2:Tanks3DSResource = null, param3:ImageResource = null, param4:Tanks3DSResource = null, param5:ClientFlag = null, param6:Tanks3DSResource = null, param7:ImageResource = null, param8:Tanks3DSResource = null, param9:CaptureTheFlagSoundFX = null)
      {
         super();
         this._blueFlag = param1;
         this._blueFlagModel = param2;
         this._blueFlagSprite = param3;
         this._bluePedestalModel = param4;
         this._redFlag = param5;
         this._redFlagModel = param6;
         this._redFlagSprite = param7;
         this._redPedestalModel = param8;
         this._sounds = param9;
      }
      
      public function get blueFlag() : ClientFlag
      {
         return this._blueFlag;
      }
      
      public function set blueFlag(param1:ClientFlag) : void
      {
         this._blueFlag = param1;
      }
      
      public function get blueFlagModel() : Tanks3DSResource
      {
         return this._blueFlagModel;
      }
      
      public function set blueFlagModel(param1:Tanks3DSResource) : void
      {
         this._blueFlagModel = param1;
      }
      
      public function get blueFlagSprite() : ImageResource
      {
         return this._blueFlagSprite;
      }
      
      public function set blueFlagSprite(param1:ImageResource) : void
      {
         this._blueFlagSprite = param1;
      }
      
      public function get bluePedestalModel() : Tanks3DSResource
      {
         return this._bluePedestalModel;
      }
      
      public function set bluePedestalModel(param1:Tanks3DSResource) : void
      {
         this._bluePedestalModel = param1;
      }
      
      public function get redFlag() : ClientFlag
      {
         return this._redFlag;
      }
      
      public function set redFlag(param1:ClientFlag) : void
      {
         this._redFlag = param1;
      }
      
      public function get redFlagModel() : Tanks3DSResource
      {
         return this._redFlagModel;
      }
      
      public function set redFlagModel(param1:Tanks3DSResource) : void
      {
         this._redFlagModel = param1;
      }
      
      public function get redFlagSprite() : ImageResource
      {
         return this._redFlagSprite;
      }
      
      public function set redFlagSprite(param1:ImageResource) : void
      {
         this._redFlagSprite = param1;
      }
      
      public function get redPedestalModel() : Tanks3DSResource
      {
         return this._redPedestalModel;
      }
      
      public function set redPedestalModel(param1:Tanks3DSResource) : void
      {
         this._redPedestalModel = param1;
      }
      
      public function get sounds() : CaptureTheFlagSoundFX
      {
         return this._sounds;
      }
      
      public function set sounds(param1:CaptureTheFlagSoundFX) : void
      {
         this._sounds = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "CaptureTheFlagCC [";
         _loc1_ += "blueFlag = " + this.blueFlag + " ";
         _loc1_ += "blueFlagModel = " + this.blueFlagModel + " ";
         _loc1_ += "blueFlagSprite = " + this.blueFlagSprite + " ";
         _loc1_ += "bluePedestalModel = " + this.bluePedestalModel + " ";
         _loc1_ += "redFlag = " + this.redFlag + " ";
         _loc1_ += "redFlagModel = " + this.redFlagModel + " ";
         _loc1_ += "redFlagSprite = " + this.redFlagSprite + " ";
         _loc1_ += "redPedestalModel = " + this.redPedestalModel + " ";
         _loc1_ += "sounds = " + this.sounds + " ";
         return _loc1_ + "]";
      }
   }
}

