package projects.tanks.client.battlefield.models.ultimate.effects.titan
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class TitanUltimateCC
   {
      
      private var _cell:ImageResource;
      
      private var _effectStartSound:SoundResource;
      
      private var _geosphere:Tanks3DSResource;
      
      public function TitanUltimateCC(param1:ImageResource = null, param2:SoundResource = null, param3:Tanks3DSResource = null)
      {
         super();
         this._cell = param1;
         this._effectStartSound = param2;
         this._geosphere = param3;
      }
      
      public function get cell() : ImageResource
      {
         return this._cell;
      }
      
      public function set cell(param1:ImageResource) : void
      {
         this._cell = param1;
      }
      
      public function get effectStartSound() : SoundResource
      {
         return this._effectStartSound;
      }
      
      public function set effectStartSound(param1:SoundResource) : void
      {
         this._effectStartSound = param1;
      }
      
      public function get geosphere() : Tanks3DSResource
      {
         return this._geosphere;
      }
      
      public function set geosphere(param1:Tanks3DSResource) : void
      {
         this._geosphere = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TitanUltimateCC [";
         _loc1_ += "cell = " + this.cell + " ";
         _loc1_ += "effectStartSound = " + this.effectStartSound + " ";
         _loc1_ += "geosphere = " + this.geosphere + " ";
         return _loc1_ + "]";
      }
   }
}

