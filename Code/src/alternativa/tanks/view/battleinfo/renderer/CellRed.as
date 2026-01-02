package alternativa.tanks.view.battleinfo.renderer
{
   import controls.cellrenderer.ButtonState;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   
   public class CellRed extends ButtonState
   {
      
      private static const cellRedLeft:Class = CellRed_cellRedLeft;
      
      private static const cellRedLeftData:BitmapData = Bitmap(new cellRedLeft()).bitmapData;
      
      private static const cellRedCenter:Class = CellRed_cellRedCenter;
      
      private static const cellRedCentreData:BitmapData = Bitmap(new cellRedCenter()).bitmapData;
      
      private static const cellRedRight:Class = CellRed_cellRedRight;
      
      private static const cellRedRightData:BitmapData = Bitmap(new cellRedRight()).bitmapData;
      
      public function CellRed()
      {
         super();
         bmpLeft = cellRedLeftData;
         bmpCenter = cellRedCentreData;
         bmpRight = cellRedRightData;
      }
      
      override public function draw() : void
      {
         var _loc1_:Graphics = null;
         _loc1_ = l.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpLeft);
         _loc1_.drawRect(0,0,5,20);
         _loc1_.endFill();
         l.x = 0;
         l.y = 0;
         _loc1_ = c.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpCenter);
         _loc1_.drawRect(0,0,_width - 10,20);
         _loc1_.endFill();
         c.x = 5;
         c.y = 0;
         _loc1_ = r.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpRight);
         _loc1_.drawRect(0,0,5,20);
         _loc1_.endFill();
         r.x = _width - 5;
         r.y = 0;
      }
   }
}

