package alternativa.tanks.view.battleinfo.renderer
{
   import controls.cellrenderer.ButtonState;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   
   public class CellBlue extends ButtonState
   {
      
      private static const cellFullLeft:Class = CellBlue_cellFullLeft;
      
      private static const cellFullLeftData:BitmapData = Bitmap(new cellFullLeft()).bitmapData;
      
      private static const cellFullCenter:Class = CellBlue_cellFullCenter;
      
      private static const cellFullCenterData:BitmapData = Bitmap(new cellFullCenter()).bitmapData;
      
      private static const cellFullRight:Class = CellBlue_cellFullRight;
      
      private static const cellFullRightData:BitmapData = Bitmap(new cellFullRight()).bitmapData;
      
      public function CellBlue()
      {
         super();
         bmpLeft = cellFullLeftData;
         bmpCenter = cellFullCenterData;
         bmpRight = cellFullRightData;
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

