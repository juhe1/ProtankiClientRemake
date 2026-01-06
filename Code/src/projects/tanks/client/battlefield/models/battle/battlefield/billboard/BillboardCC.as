package projects.tanks.client.battlefield.models.battle.battlefield.billboard
{
   import platform.client.fp10.core.resource.types.TextureResource;
   
   public class BillboardCC
   {
      
      private var _defaultBillboardImage:TextureResource;
      
      public function BillboardCC(param1:TextureResource = null)
      {
         super();
         this._defaultBillboardImage = param1;
      }
      
      public function get defaultBillboardImage() : TextureResource
      {
         return this._defaultBillboardImage;
      }
      
      public function set defaultBillboardImage(param1:TextureResource) : void
      {
         this._defaultBillboardImage = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BillboardCC [";
         _loc1_ += "defaultBillboardImage = " + this.defaultBillboardImage + " ";
         return _loc1_ + "]";
      }
   }
}

