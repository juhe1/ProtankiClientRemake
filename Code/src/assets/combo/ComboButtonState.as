package assets.combo
{
   import controls.ButtonState;
   import flash.display.Graphics;
   
   public class ComboButtonState extends ButtonState
   {
      
      public function ComboButtonState()
      {
         super();
      }
      
      override public function draw() : void
      {
         var _loc1_:Graphics = null;
         _loc1_ = l.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpLeft);
         _loc1_.drawRect(0,0,7,30);
         _loc1_.endFill();
         l.x = 0;
         l.y = 0;
         _loc1_ = c.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpCenter);
         _loc1_.drawRect(0,0,_width - 40,30);
         _loc1_.endFill();
         c.x = 7;
         c.y = 0;
         _loc1_ = r.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(bmpRight);
         _loc1_.drawRect(0,0,33,30);
         _loc1_.endFill();
         r.x = _width - 33;
         r.y = 0;
      }
   }
}

