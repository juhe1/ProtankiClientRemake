package controls
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class VKButton extends DefaultIconButton
   {
      
      private static const bitmapVK:Class = VKButton_bitmapVK;
      
      private static const iconVK:BitmapData = (new bitmapVK() as Bitmap).bitmapData;
      
      public function VKButton()
      {
         super(iconVK);
      }
   }
}

