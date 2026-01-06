package projects.tanks.client.battlefield.models.ultimate.effects.hornet
{
   import alternativa.types.Long;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   
   public class HornetUltimateCC
   {
      
      private var _effectStartSound:SoundResource;
      
      private var _effectTimeMs:Long;
      
      private var _ring:TextureResource;
      
      public function HornetUltimateCC(param1:SoundResource = null, param2:Long = null, param3:TextureResource = null)
      {
         super();
         this._effectStartSound = param1;
         this._effectTimeMs = param2;
         this._ring = param3;
      }
      
      public function get effectStartSound() : SoundResource
      {
         return this._effectStartSound;
      }
      
      public function set effectStartSound(param1:SoundResource) : void
      {
         this._effectStartSound = param1;
      }
      
      public function get effectTimeMs() : Long
      {
         return this._effectTimeMs;
      }
      
      public function set effectTimeMs(param1:Long) : void
      {
         this._effectTimeMs = param1;
      }
      
      public function get ring() : TextureResource
      {
         return this._ring;
      }
      
      public function set ring(param1:TextureResource) : void
      {
         this._ring = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "HornetUltimateCC [";
         _loc1_ += "effectStartSound = " + this.effectStartSound + " ";
         _loc1_ += "effectTimeMs = " + this.effectTimeMs + " ";
         _loc1_ += "ring = " + this.ring + " ";
         return _loc1_ + "]";
      }
   }
}

