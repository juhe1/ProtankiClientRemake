package projects.tanks.client.battlefield.models.tankparts.armor.explosion
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   
   public class TankExplosionCC
   {
      
      private var _explosionTexture:MultiframeImageResource;
      
      private var _shockWaveTexture:MultiframeImageResource;
      
      private var _smokeTextureId:MultiframeImageResource;
      
      public function TankExplosionCC(param1:MultiframeImageResource = null, param2:MultiframeImageResource = null, param3:MultiframeImageResource = null)
      {
         super();
         this._explosionTexture = param1;
         this._shockWaveTexture = param2;
         this._smokeTextureId = param3;
      }
      
      public function get explosionTexture() : MultiframeImageResource
      {
         return this._explosionTexture;
      }
      
      public function set explosionTexture(param1:MultiframeImageResource) : void
      {
         this._explosionTexture = param1;
      }
      
      public function get shockWaveTexture() : MultiframeImageResource
      {
         return this._shockWaveTexture;
      }
      
      public function set shockWaveTexture(param1:MultiframeImageResource) : void
      {
         this._shockWaveTexture = param1;
      }
      
      public function get smokeTextureId() : MultiframeImageResource
      {
         return this._smokeTextureId;
      }
      
      public function set smokeTextureId(param1:MultiframeImageResource) : void
      {
         this._smokeTextureId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TankExplosionCC [";
         _loc1_ += "explosionTexture = " + this.explosionTexture + " ";
         _loc1_ += "shockWaveTexture = " + this.shockWaveTexture + " ";
         _loc1_ += "smokeTextureId = " + this.smokeTextureId + " ";
         return _loc1_ + "]";
      }
   }
}

