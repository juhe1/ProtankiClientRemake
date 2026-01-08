package projects.tanks.client.battlefield.models.battle.assault
{
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class AssaultCC
   {
      
      private var _blueFlags:Vector.<ClientAssaultFlag>;
      
      private var _flagModel:Tanks3DSResource;
      
      private var _flagPedestalModel:Tanks3DSResource;
      
      private var _flagSprite:ImageResource;
      
      private var _pointCircleTexture:ImageResource;
      
      private var _pointPedestalModel:Tanks3DSResource;
      
      private var _redBases:Vector.<AssaultBase>;
      
      private var _sounds:AssaultSoundFX;
      
      public function AssaultCC(param1:Vector.<ClientAssaultFlag> = null, param2:Tanks3DSResource = null, param3:Tanks3DSResource = null, param4:ImageResource = null, param5:ImageResource = null, param6:Tanks3DSResource = null, param7:Vector.<AssaultBase> = null, param8:AssaultSoundFX = null)
      {
         super();
         this._blueFlags = param1;
         this._flagModel = param2;
         this._flagPedestalModel = param3;
         this._flagSprite = param4;
         this._pointCircleTexture = param5;
         this._pointPedestalModel = param6;
         this._redBases = param7;
         this._sounds = param8;
      }
      
      public function get blueFlags() : Vector.<ClientAssaultFlag>
      {
         return this._blueFlags;
      }
      
      public function set blueFlags(param1:Vector.<ClientAssaultFlag>) : void
      {
         this._blueFlags = param1;
      }
      
      public function get flagModel() : Tanks3DSResource
      {
         return this._flagModel;
      }
      
      public function set flagModel(param1:Tanks3DSResource) : void
      {
         this._flagModel = param1;
      }
      
      public function get flagPedestalModel() : Tanks3DSResource
      {
         return this._flagPedestalModel;
      }
      
      public function set flagPedestalModel(param1:Tanks3DSResource) : void
      {
         this._flagPedestalModel = param1;
      }
      
      public function get flagSprite() : ImageResource
      {
         return this._flagSprite;
      }
      
      public function set flagSprite(param1:ImageResource) : void
      {
         this._flagSprite = param1;
      }
      
      public function get pointCircleTexture() : ImageResource
      {
         return this._pointCircleTexture;
      }
      
      public function set pointCircleTexture(param1:ImageResource) : void
      {
         this._pointCircleTexture = param1;
      }
      
      public function get pointPedestalModel() : Tanks3DSResource
      {
         return this._pointPedestalModel;
      }
      
      public function set pointPedestalModel(param1:Tanks3DSResource) : void
      {
         this._pointPedestalModel = param1;
      }
      
      public function get redBases() : Vector.<AssaultBase>
      {
         return this._redBases;
      }
      
      public function set redBases(param1:Vector.<AssaultBase>) : void
      {
         this._redBases = param1;
      }
      
      public function get sounds() : AssaultSoundFX
      {
         return this._sounds;
      }
      
      public function set sounds(param1:AssaultSoundFX) : void
      {
         this._sounds = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "AssaultCC [";
         _loc1_ += "blueFlags = " + this.blueFlags + " ";
         _loc1_ += "flagModel = " + this.flagModel + " ";
         _loc1_ += "flagPedestalModel = " + this.flagPedestalModel + " ";
         _loc1_ += "flagSprite = " + this.flagSprite + " ";
         _loc1_ += "pointCircleTexture = " + this.pointCircleTexture + " ";
         _loc1_ += "pointPedestalModel = " + this.pointPedestalModel + " ";
         _loc1_ += "redBases = " + this.redBases + " ";
         _loc1_ += "sounds = " + this.sounds + " ";
         return _loc1_ + "]";
      }
   }
}

