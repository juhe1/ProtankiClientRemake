package projects.tanks.client.battlefield.models.drone.demoman
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   
   public class DroneExplosionCC
   {
      
      private var _explosionTexture:MultiframeImageResource;
      
      public function DroneExplosionCC(param1:MultiframeImageResource = null)
      {
         super();
         this._explosionTexture = param1;
      }
      
      public function get explosionTexture() : MultiframeImageResource
      {
         return this._explosionTexture;
      }
      
      public function set explosionTexture(param1:MultiframeImageResource) : void
      {
         this._explosionTexture = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DroneExplosionCC [";
         _loc1_ += "explosionTexture = " + this.explosionTexture + " ";
         return _loc1_ + "]";
      }
   }
}

