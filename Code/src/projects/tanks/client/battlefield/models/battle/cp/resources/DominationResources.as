package projects.tanks.client.battlefield.models.battle.cp.resources
{
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class DominationResources
   {
      
      private var _bigLetters:ImageResource;
      
      private var _blueCircle:ImageResource;
      
      private var _bluePedestalTexture:ImageResource;
      
      private var _blueRay:ImageResource;
      
      private var _blueRayTip:ImageResource;
      
      private var _neutralCircle:ImageResource;
      
      private var _neutralPedestalTexture:ImageResource;
      
      private var _pedestal:Tanks3DSResource;
      
      private var _redCircle:ImageResource;
      
      private var _redPedestalTexture:ImageResource;
      
      private var _redRay:ImageResource;
      
      private var _redRayTip:ImageResource;
      
      public function DominationResources(param1:ImageResource = null, param2:ImageResource = null, param3:ImageResource = null, param4:ImageResource = null, param5:ImageResource = null, param6:ImageResource = null, param7:ImageResource = null, param8:Tanks3DSResource = null, param9:ImageResource = null, param10:ImageResource = null, param11:ImageResource = null, param12:ImageResource = null)
      {
         super();
         this._bigLetters = param1;
         this._blueCircle = param2;
         this._bluePedestalTexture = param3;
         this._blueRay = param4;
         this._blueRayTip = param5;
         this._neutralCircle = param6;
         this._neutralPedestalTexture = param7;
         this._pedestal = param8;
         this._redCircle = param9;
         this._redPedestalTexture = param10;
         this._redRay = param11;
         this._redRayTip = param12;
      }
      
      public function get bigLetters() : ImageResource
      {
         return this._bigLetters;
      }
      
      public function set bigLetters(param1:ImageResource) : void
      {
         this._bigLetters = param1;
      }
      
      public function get blueCircle() : ImageResource
      {
         return this._blueCircle;
      }
      
      public function set blueCircle(param1:ImageResource) : void
      {
         this._blueCircle = param1;
      }
      
      public function get bluePedestalTexture() : ImageResource
      {
         return this._bluePedestalTexture;
      }
      
      public function set bluePedestalTexture(param1:ImageResource) : void
      {
         this._bluePedestalTexture = param1;
      }
      
      public function get blueRay() : ImageResource
      {
         return this._blueRay;
      }
      
      public function set blueRay(param1:ImageResource) : void
      {
         this._blueRay = param1;
      }
      
      public function get blueRayTip() : ImageResource
      {
         return this._blueRayTip;
      }
      
      public function set blueRayTip(param1:ImageResource) : void
      {
         this._blueRayTip = param1;
      }
      
      public function get neutralCircle() : ImageResource
      {
         return this._neutralCircle;
      }
      
      public function set neutralCircle(param1:ImageResource) : void
      {
         this._neutralCircle = param1;
      }
      
      public function get neutralPedestalTexture() : ImageResource
      {
         return this._neutralPedestalTexture;
      }
      
      public function set neutralPedestalTexture(param1:ImageResource) : void
      {
         this._neutralPedestalTexture = param1;
      }
      
      public function get pedestal() : Tanks3DSResource
      {
         return this._pedestal;
      }
      
      public function set pedestal(param1:Tanks3DSResource) : void
      {
         this._pedestal = param1;
      }
      
      public function get redCircle() : ImageResource
      {
         return this._redCircle;
      }
      
      public function set redCircle(param1:ImageResource) : void
      {
         this._redCircle = param1;
      }
      
      public function get redPedestalTexture() : ImageResource
      {
         return this._redPedestalTexture;
      }
      
      public function set redPedestalTexture(param1:ImageResource) : void
      {
         this._redPedestalTexture = param1;
      }
      
      public function get redRay() : ImageResource
      {
         return this._redRay;
      }
      
      public function set redRay(param1:ImageResource) : void
      {
         this._redRay = param1;
      }
      
      public function get redRayTip() : ImageResource
      {
         return this._redRayTip;
      }
      
      public function set redRayTip(param1:ImageResource) : void
      {
         this._redRayTip = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DominationResources [";
         _loc1_ += "bigLetters = " + this.bigLetters + " ";
         _loc1_ += "blueCircle = " + this.blueCircle + " ";
         _loc1_ += "bluePedestalTexture = " + this.bluePedestalTexture + " ";
         _loc1_ += "blueRay = " + this.blueRay + " ";
         _loc1_ += "blueRayTip = " + this.blueRayTip + " ";
         _loc1_ += "neutralCircle = " + this.neutralCircle + " ";
         _loc1_ += "neutralPedestalTexture = " + this.neutralPedestalTexture + " ";
         _loc1_ += "pedestal = " + this.pedestal + " ";
         _loc1_ += "redCircle = " + this.redCircle + " ";
         _loc1_ += "redPedestalTexture = " + this.redPedestalTexture + " ";
         _loc1_ += "redRay = " + this.redRay + " ";
         _loc1_ += "redRayTip = " + this.redRayTip + " ";
         return _loc1_ + "]";
      }
   }
}

