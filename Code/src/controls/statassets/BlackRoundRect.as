package controls.statassets
{
   import assets.resultwindow.bres_BG_BLACKCORNER;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class BlackRoundRect extends StatLineBase
   {
      
      public function BlackRoundRect()
      {
         super();
         tl = new bres_BG_BLACKCORNER(1,1);
         px = new BitmapData(1,1,true,2566914048);
      }
      
      override protected function draw() : void
      {
         var _loc2_:Matrix = null;
         var _loc1_:Graphics = this.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(tl);
         _loc1_.drawRect(0,0,8,8);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.rotate(Math.PI * 0.5);
         _loc2_.translate(_width - 8,0);
         _loc1_.beginBitmapFill(tl,_loc2_);
         _loc1_.drawRect(_width - 8,0,8,8);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.rotate(Math.PI);
         _loc2_.translate(_width - 8,_height - 8);
         _loc1_.beginBitmapFill(tl,_loc2_);
         _loc1_.drawRect(_width - 8,_height - 8,8,8);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.rotate(Math.PI * 1.5);
         _loc2_.translate(0,_height - 8);
         _loc1_.beginBitmapFill(tl,_loc2_);
         _loc1_.drawRect(0,_height - 8,8,8);
         _loc1_.endFill();
         _loc1_.beginBitmapFill(px);
         _loc1_.drawRect(8,0,_width - 16,_height);
         _loc1_.drawRect(0,8,8,_height - 16);
         _loc1_.drawRect(_width - 8,8,8,_height - 16);
         _loc1_.endFill();
      }
   }
}

