package controls.cellrenderer
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   
   public class CellNormalSelected extends CellRendererDefault
   {
      
      private static const normalLeft:Class = CellNormalSelected_normalLeft;
      
      private static const normalLeftData:BitmapData = Bitmap(new normalLeft()).bitmapData;
      
      private static const normalCenter:Class = CellNormalSelected_normalCenter;
      
      private static const normalCenterData:BitmapData = Bitmap(new normalCenter()).bitmapData;
      
      private static const normalRight:Class = CellNormalSelected_normalRight;
      
      private static const normalRightData:BitmapData = Bitmap(new normalRight()).bitmapData;
      
      public function CellNormalSelected()
      {
         super();
         bmpLeft = normalLeftData;
         bmpCenter = normalCenterData;
         bmpRight = normalRightData;
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
         l.y = 1;
         _loc1_ = c.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpCenter);
         _loc1_.drawRect(0,0,_width - 10,20);
         _loc1_.endFill();
         c.x = 5;
         c.y = 1;
         _loc1_ = r.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpRight);
         _loc1_.drawRect(0,0,5,20);
         _loc1_.endFill();
         r.x = _width - 5;
         r.y = 1;
      }
   }
}

