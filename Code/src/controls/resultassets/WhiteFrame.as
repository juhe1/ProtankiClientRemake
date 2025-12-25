package controls.resultassets
{
   import assets.resultwindow.items_mini_CENTER;
   import assets.resultwindow.items_mini_LEFT;
   import assets.resultwindow.items_mini_RIGHT;
   import controls.cellrenderer.ButtonState;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WhiteFrame extends ButtonState
   {
      
      public var bmpLeftSmall:BitmapData;
      
      public var bmpRightSmall:BitmapData;
      
      public function WhiteFrame()
      {
         super();
         bmpLeft = new items_mini_LEFT(1,1);
         bmpCenter = new items_mini_CENTER(1,1);
         bmpRight = new items_mini_RIGHT(1,1);
         this.bmpLeftSmall = new BitmapData(10,40);
         this.bmpRightSmall = new BitmapData(10,40);
         this.bmpLeftSmall.copyPixels(bmpLeft,new Rectangle(0,0,10,40),new Point());
         this.bmpRightSmall.copyPixels(bmpRight,new Rectangle(10,0,10,40),new Point());
      }
      
      override public function draw() : void
      {
         var _loc1_:Graphics = null;
         if(_width >= 40)
         {
            _loc1_ = l.graphics;
            _loc1_.clear();
            _loc1_.beginBitmapFill(bmpLeft);
            _loc1_.drawRect(0,0,20,40);
            _loc1_.endFill();
            l.x = 0;
            l.y = 0;
            _loc1_ = c.graphics;
            _loc1_.clear();
            _loc1_.beginBitmapFill(bmpCenter);
            _loc1_.drawRect(0,0,_width - 40,40);
            _loc1_.endFill();
            c.x = 20;
            c.y = 0;
            _loc1_ = r.graphics;
            _loc1_.clear();
            _loc1_.beginBitmapFill(bmpRight);
            _loc1_.drawRect(0,0,20,40);
            _loc1_.endFill();
            r.x = _width - 20;
            r.y = 0;
         }
         else
         {
            _loc1_ = l.graphics;
            _loc1_.clear();
            _loc1_.beginBitmapFill(this.bmpLeftSmall);
            _loc1_.drawRect(0,0,10,40);
            _loc1_.endFill();
            l.x = 0;
            l.y = 0;
            _loc1_ = c.graphics;
            _loc1_.clear();
            _loc1_.beginBitmapFill(bmpCenter);
            _loc1_.drawRect(0,0,_width - 20,40);
            _loc1_.endFill();
            c.x = 10;
            c.y = 0;
            _loc1_ = r.graphics;
            _loc1_.clear();
            _loc1_.beginBitmapFill(this.bmpRightSmall);
            _loc1_.drawRect(0,0,10,40);
            _loc1_.endFill();
            r.x = _width - 10;
            r.y = 0;
         }
      }
   }
}

