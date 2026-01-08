package projects.tanks.client.battlefield.models.map
{
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class SkyboxSides
   {
      
      private var _back:ImageResource;
      
      private var _bottom:ImageResource;
      
      private var _front:ImageResource;
      
      private var _left:ImageResource;
      
      private var _right:ImageResource;
      
      private var _top:ImageResource;
      
      public function SkyboxSides(param1:ImageResource = null, param2:ImageResource = null, param3:ImageResource = null, param4:ImageResource = null, param5:ImageResource = null, param6:ImageResource = null)
      {
         super();
         this._back = param1;
         this._bottom = param2;
         this._front = param3;
         this._left = param4;
         this._right = param5;
         this._top = param6;
      }
      
      public function get back() : ImageResource
      {
         return this._back;
      }
      
      public function set back(param1:ImageResource) : void
      {
         this._back = param1;
      }
      
      public function get bottom() : ImageResource
      {
         return this._bottom;
      }
      
      public function set bottom(param1:ImageResource) : void
      {
         this._bottom = param1;
      }
      
      public function get front() : ImageResource
      {
         return this._front;
      }
      
      public function set front(param1:ImageResource) : void
      {
         this._front = param1;
      }
      
      public function get left() : ImageResource
      {
         return this._left;
      }
      
      public function set left(param1:ImageResource) : void
      {
         this._left = param1;
      }
      
      public function get right() : ImageResource
      {
         return this._right;
      }
      
      public function set right(param1:ImageResource) : void
      {
         this._right = param1;
      }
      
      public function get top() : ImageResource
      {
         return this._top;
      }
      
      public function set top(param1:ImageResource) : void
      {
         this._top = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "SkyboxSides [";
         _loc1_ += "back = " + this.back + " ";
         _loc1_ += "bottom = " + this.bottom + " ";
         _loc1_ += "front = " + this.front + " ";
         _loc1_ += "left = " + this.left + " ";
         _loc1_ += "right = " + this.right + " ";
         _loc1_ += "top = " + this.top + " ";
         return _loc1_ + "]";
      }
   }
}

