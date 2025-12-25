package controls
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class FBButton extends DefaultIconButton
   {
      
      private static const bitmapFB:Class = FBButton_bitmapFB;
      
      private static const iconFB:BitmapData = (new bitmapFB() as Bitmap).bitmapData;
      
      public function FBButton()
      {
         super(iconFB);
      }
   }
}

