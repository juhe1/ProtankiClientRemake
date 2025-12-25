package controls.statassets
{
   import controls.resultassets.ResultWindowBase;
   import flash.display.Graphics;
   
   public class StatLineBase extends ResultWindowBase
   {
      
      protected var frameColor:uint = 0;
      
      public function StatLineBase()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         super.draw();
         if(this.frameColor != 0)
         {
            _loc1_ = this.graphics;
            _loc1_.beginFill(this.frameColor);
            _loc1_.drawRect(4,0,_width - 8,1);
            _loc1_.drawRect(4,_height - 1,_width - 8,1);
            _loc1_.drawRect(0,4,1,_height - 8);
            _loc1_.drawRect(_width - 1,4,1,_height - 8);
            _loc1_.endFill();
         }
      }
   }
}

