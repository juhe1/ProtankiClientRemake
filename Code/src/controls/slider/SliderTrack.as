package controls.slider
{
   import assets.slider.slider_TRACK_CENTER;
   import assets.slider.slider_TRACK_LEFT;
   import assets.slider.slider_TRACK_RIGHT;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class SliderTrack extends Sprite
   {
      
      protected var track_bmpLeft:slider_TRACK_LEFT = new slider_TRACK_LEFT(1,1);
      
      protected var track_bmpCenter:slider_TRACK_CENTER = new slider_TRACK_CENTER(1,1);
      
      protected var track_bmpRight:slider_TRACK_RIGHT = new slider_TRACK_RIGHT(1,1);
      
      protected var _width:int;
      
      protected var _showTrack:Boolean;
      
      protected var _minValue:Number = 0;
      
      protected var _maxValue:Number = 100;
      
      protected var _tick:Number = 10;
      
      public function SliderTrack(param1:Boolean = true)
      {
         super();
         this._showTrack = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         this.draw();
      }
      
      protected function draw() : void
      {
         var _loc2_:Matrix = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:Graphics = this.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(this.track_bmpLeft);
         _loc1_.drawRect(0,0,5,30);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.translate(5,0);
         _loc1_.beginBitmapFill(this.track_bmpCenter,_loc2_);
         _loc1_.drawRect(5,0,this._width - 11,30);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.translate(this._width - 6,0);
         _loc1_.beginBitmapFill(this.track_bmpRight,_loc2_);
         _loc1_.drawRect(this._width - 6,0,6,30);
         _loc1_.endFill();
         if(this._showTrack)
         {
            _loc3_ = width / ((this._maxValue - this._minValue) / this._tick);
            _loc4_ = _loc3_;
            while(_loc4_ < this._width)
            {
               _loc1_.lineStyle(0,16777215,0.4);
               _loc1_.moveTo(_loc4_,5);
               _loc1_.lineTo(_loc4_,25);
               _loc4_ += _loc3_;
            }
         }
      }
      
      public function set minValue(param1:Number) : void
      {
         this._minValue = param1;
         this.draw();
      }
      
      public function set maxValue(param1:Number) : void
      {
         this._maxValue = param1;
         this.draw();
      }
      
      public function set tickInterval(param1:Number) : void
      {
         this._tick = param1;
         this.draw();
      }
   }
}

