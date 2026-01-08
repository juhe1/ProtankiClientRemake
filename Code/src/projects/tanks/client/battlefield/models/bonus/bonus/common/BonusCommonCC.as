package projects.tanks.client.battlefield.models.bonus.bonus.common
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class BonusCommonCC
   {
      
      private var _boxResource:Tanks3DSResource;
      
      private var _cordResource:ImageResource;
      
      private var _parachuteInnerResource:Tanks3DSResource;
      
      private var _parachuteResource:Tanks3DSResource;
      
      private var _pickupSoundResource:SoundResource;
      
      public function BonusCommonCC(param1:Tanks3DSResource = null, param2:ImageResource = null, param3:Tanks3DSResource = null, param4:Tanks3DSResource = null, param5:SoundResource = null)
      {
         super();
         this._boxResource = param1;
         this._cordResource = param2;
         this._parachuteInnerResource = param3;
         this._parachuteResource = param4;
         this._pickupSoundResource = param5;
      }
      
      public function get boxResource() : Tanks3DSResource
      {
         return this._boxResource;
      }
      
      public function set boxResource(param1:Tanks3DSResource) : void
      {
         this._boxResource = param1;
      }
      
      public function get cordResource() : ImageResource
      {
         return this._cordResource;
      }
      
      public function set cordResource(param1:ImageResource) : void
      {
         this._cordResource = param1;
      }
      
      public function get parachuteInnerResource() : Tanks3DSResource
      {
         return this._parachuteInnerResource;
      }
      
      public function set parachuteInnerResource(param1:Tanks3DSResource) : void
      {
         this._parachuteInnerResource = param1;
      }
      
      public function get parachuteResource() : Tanks3DSResource
      {
         return this._parachuteResource;
      }
      
      public function set parachuteResource(param1:Tanks3DSResource) : void
      {
         this._parachuteResource = param1;
      }
      
      public function get pickupSoundResource() : SoundResource
      {
         return this._pickupSoundResource;
      }
      
      public function set pickupSoundResource(param1:SoundResource) : void
      {
         this._pickupSoundResource = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BonusCommonCC [";
         _loc1_ += "boxResource = " + this.boxResource + " ";
         _loc1_ += "cordResource = " + this.cordResource + " ";
         _loc1_ += "parachuteInnerResource = " + this.parachuteInnerResource + " ";
         _loc1_ += "parachuteResource = " + this.parachuteResource + " ";
         _loc1_ += "pickupSoundResource = " + this.pickupSoundResource + " ";
         return _loc1_ + "]";
      }
   }
}

