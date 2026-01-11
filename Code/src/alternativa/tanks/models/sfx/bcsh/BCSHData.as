package alternativa.tanks.models.sfx.bcsh
{
   import alternativa.utils.filters.BCSHFilter;
   import flash.filters.BitmapFilter;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHStruct;
   
   public class BCSHData
   {
      
      private var brightness:Number;
      
      private var contrast:Number;
      
      private var saturation:Number;
      
      private var hue:Number;
      
      public function BCSHData(param1:BCSHStruct)
      {
         super();
         this.brightness = param1.brightness;
         this.contrast = param1.contrast;
         this.saturation = param1.saturation;
         this.hue = param1.hue;
      }
      
      public function createFilter() : BitmapFilter
      {
         return BCSHFilter.createFilter(this.brightness,this.contrast,this.saturation,this.hue);
      }
   }
}

