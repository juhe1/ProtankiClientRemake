package projects.tanks.client.garage.models.item.present
{
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class PresentItemCC
   {
      
      private var _image:ImageResource;
      
      public function PresentItemCC(param1:ImageResource = null)
      {
         super();
         this._image = param1;
      }
      
      public function get image() : ImageResource
      {
         return this._image;
      }
      
      public function set image(param1:ImageResource) : void
      {
         this._image = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "PresentItemCC [";
         _loc1_ += "image = " + this.image + " ";
         return _loc1_ + "]";
      }
   }
}

