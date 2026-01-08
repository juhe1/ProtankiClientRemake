package projects.tanks.client.battlefield.models.ultimate.effects.mammoth
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class MammothUltimateCC
   {
      
      private var _effectStartSound:SoundResource;
      
      private var _heart:ImageResource;
      
      private var _shine:ImageResource;
      
      private var _sparkles:ImageResource;
      
      public function MammothUltimateCC(param1:SoundResource = null, param2:ImageResource = null, param3:ImageResource = null, param4:ImageResource = null)
      {
         super();
         this._effectStartSound = param1;
         this._heart = param2;
         this._shine = param3;
         this._sparkles = param4;
      }
      
      public function get effectStartSound() : SoundResource
      {
         return this._effectStartSound;
      }
      
      public function set effectStartSound(param1:SoundResource) : void
      {
         this._effectStartSound = param1;
      }
      
      public function get heart() : ImageResource
      {
         return this._heart;
      }
      
      public function set heart(param1:ImageResource) : void
      {
         this._heart = param1;
      }
      
      public function get shine() : ImageResource
      {
         return this._shine;
      }
      
      public function set shine(param1:ImageResource) : void
      {
         this._shine = param1;
      }
      
      public function get sparkles() : ImageResource
      {
         return this._sparkles;
      }
      
      public function set sparkles(param1:ImageResource) : void
      {
         this._sparkles = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "MammothUltimateCC [";
         _loc1_ += "effectStartSound = " + this.effectStartSound + " ";
         _loc1_ += "heart = " + this.heart + " ";
         _loc1_ += "shine = " + this.shine + " ";
         _loc1_ += "sparkles = " + this.sparkles + " ";
         return _loc1_ + "]";
      }
   }
}

