package projects.tanks.client.battlefield.models.ultimate.effects.viking
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class VikingUltimateCC
   {
      
      private var _effectStartSound:SoundResource;
      
      private var _flame:ImageResource;
      
      private var _smoke:ImageResource;
      
      public function VikingUltimateCC(param1:SoundResource = null, param2:ImageResource = null, param3:ImageResource = null)
      {
         super();
         this._effectStartSound = param1;
         this._flame = param2;
         this._smoke = param3;
      }
      
      public function get effectStartSound() : SoundResource
      {
         return this._effectStartSound;
      }
      
      public function set effectStartSound(param1:SoundResource) : void
      {
         this._effectStartSound = param1;
      }
      
      public function get flame() : ImageResource
      {
         return this._flame;
      }
      
      public function set flame(param1:ImageResource) : void
      {
         this._flame = param1;
      }
      
      public function get smoke() : ImageResource
      {
         return this._smoke;
      }
      
      public function set smoke(param1:ImageResource) : void
      {
         this._smoke = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "VikingUltimateCC [";
         _loc1_ += "effectStartSound = " + this.effectStartSound + " ";
         _loc1_ += "flame = " + this.flame + " ";
         _loc1_ += "smoke = " + this.smoke + " ";
         return _loc1_ + "]";
      }
   }
}

