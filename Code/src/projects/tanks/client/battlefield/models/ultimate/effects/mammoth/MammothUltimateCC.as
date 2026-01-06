package projects.tanks.client.battlefield.models.ultimate.effects.mammoth
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   
   public class MammothUltimateCC
   {
      
      private var _effectStartSound:SoundResource;
      
      private var _heart:TextureResource;
      
      private var _shine:TextureResource;
      
      private var _sparkles:TextureResource;
      
      public function MammothUltimateCC(param1:SoundResource = null, param2:TextureResource = null, param3:TextureResource = null, param4:TextureResource = null)
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
      
      public function get heart() : TextureResource
      {
         return this._heart;
      }
      
      public function set heart(param1:TextureResource) : void
      {
         this._heart = param1;
      }
      
      public function get shine() : TextureResource
      {
         return this._shine;
      }
      
      public function set shine(param1:TextureResource) : void
      {
         this._shine = param1;
      }
      
      public function get sparkles() : TextureResource
      {
         return this._sparkles;
      }
      
      public function set sparkles(param1:TextureResource) : void
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

