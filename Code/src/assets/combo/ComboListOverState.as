package assets.combo
{
   import controls.ButtonState;
   import flash.display.Graphics;
   
   public class ComboListOverState extends ButtonState
   {
      
      public function ComboListOverState()
      {
         super();
         bmpLeft = new combolist_OVER_LEFT(1,1);
         bmpCenter = new combolist_OVER_CENTER(1,1);
         bmpRight = new combolist_OVER_RIGHT(1,1);
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

