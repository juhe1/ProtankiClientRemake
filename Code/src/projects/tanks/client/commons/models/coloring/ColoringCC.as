package projects.tanks.client.commons.models.coloring
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class ColoringCC
   {
      
      private var _animatedColoring:MultiframeImageResource;
      
      private var _coloring:ImageResource;
      
      public function ColoringCC(param1:MultiframeImageResource = null, param2:ImageResource = null)
      {
         super();
         this._animatedColoring = param1;
         this._coloring = param2;
      }
      
      public function get animatedColoring() : MultiframeImageResource
      {
         return this._animatedColoring;
      }
      
      public function set animatedColoring(param1:MultiframeImageResource) : void
      {
         this._animatedColoring = param1;
      }
      
      public function get coloring() : ImageResource
      {
         return this._coloring;
      }
      
      public function set coloring(param1:ImageResource) : void
      {
         this._coloring = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ColoringCC [";
         _loc1_ += "animatedColoring = " + this.animatedColoring + " ";
         _loc1_ += "coloring = " + this.coloring + " ";
         return _loc1_ + "]";
      }
   }
}

