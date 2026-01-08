package projects.tanks.client.battlefield.models.battle.battlefield.billboard
{
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class BillboardCC
   {
      
      private var _defaultBillboardImage:ImageResource;
      
      public function BillboardCC(param1:ImageResource = null)
      {
         super();
         this._defaultBillboardImage = param1;
      }
      
      public function get defaultBillboardImage() : ImageResource
      {
         return this._defaultBillboardImage;
      }
      
      public function set defaultBillboardImage(param1:ImageResource) : void
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

