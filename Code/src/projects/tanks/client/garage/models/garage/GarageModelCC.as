package projects.tanks.client.garage.models.garage
{
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class GarageModelCC
   {
      
      private var _cameraAltitude:Number;
      
      private var _cameraDistance:Number;
      
      private var _cameraFov:Number;
      
      private var _cameraPitch:Number;
      
      private var _garageBox:Tanks3DSResource;
      
      private var _hideLinks:Boolean;
      
      private var _mountableCategories:Vector.<ItemCategoryEnum>;
      
      public function GarageModelCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Tanks3DSResource = null, param6:Boolean = false, param7:Vector.<ItemCategoryEnum> = null)
      {
         super();
         this._cameraAltitude = param1;
         this._cameraDistance = param2;
         this._cameraFov = param3;
         this._cameraPitch = param4;
         this._garageBox = param5;
         this._hideLinks = param6;
         this._mountableCategories = param7;
      }
      
      public function get cameraAltitude() : Number
      {
         return this._cameraAltitude;
      }
      
      public function set cameraAltitude(param1:Number) : void
      {
         this._cameraAltitude = param1;
      }
      
      public function get cameraDistance() : Number
      {
         return this._cameraDistance;
      }
      
      public function set cameraDistance(param1:Number) : void
      {
         this._cameraDistance = param1;
      }
      
      public function get cameraFov() : Number
      {
         return this._cameraFov;
      }
      
      public function set cameraFov(param1:Number) : void
      {
         this._cameraFov = param1;
      }
      
      public function get cameraPitch() : Number
      {
         return this._cameraPitch;
      }
      
      public function set cameraPitch(param1:Number) : void
      {
         this._cameraPitch = param1;
      }
      
      public function get garageBox() : Tanks3DSResource
      {
         return this._garageBox;
      }
      
      public function set garageBox(param1:Tanks3DSResource) : void
      {
         this._garageBox = param1;
      }
      
      public function get hideLinks() : Boolean
      {
         return this._hideLinks;
      }
      
      public function set hideLinks(param1:Boolean) : void
      {
         this._hideLinks = param1;
      }
      
      public function get mountableCategories() : Vector.<ItemCategoryEnum>
      {
         return this._mountableCategories;
      }
      
      public function set mountableCategories(param1:Vector.<ItemCategoryEnum>) : void
      {
         this._mountableCategories = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "GarageModelCC [";
         _loc1_ += "cameraAltitude = " + this.cameraAltitude + " ";
         _loc1_ += "cameraDistance = " + this.cameraDistance + " ";
         _loc1_ += "cameraFov = " + this.cameraFov + " ";
         _loc1_ += "cameraPitch = " + this.cameraPitch + " ";
         _loc1_ += "garageBox = " + this.garageBox + " ";
         _loc1_ += "hideLinks = " + this.hideLinks + " ";
         _loc1_ += "mountableCategories = " + this.mountableCategories + " ";
         return _loc1_ + "]";
      }
   }
}

