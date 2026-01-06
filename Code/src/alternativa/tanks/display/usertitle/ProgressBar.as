package alternativa.tanks.display.usertitle
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ProgressBar
   {
      
      private static var matrix:Matrix = new Matrix();
      
      private var maxValue:int;
      
      private var barWidth:int;
      
      private var shadowTipWidth:int;
      
      private var shadowHeight:int;
      
      private var barOffsetX:int;
      
      private var barOffsetY:int;
      
      private var skin:ProgressBarSkin;
      
      private var barTipWidth:int;
      
      private var barHeight:int;
      
      private var _progress:int;
      
      private var canvas:Shape = new Shape();
      
      private var x:int;
      
      private var y:int;
      
      private var rect:Rectangle;
      
      public function ProgressBar(param1:int, param2:int, param3:int, param4:int, param5:ProgressBarSkin)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.maxValue = param3;
         this.barWidth = param4;
         this.setSkin(param5);
         this.rect = new Rectangle(param1,param2,2 * this.shadowTipWidth + param4,this.shadowHeight);
      }
      
      public function setSkin(param1:ProgressBarSkin) : void
      {
         this.skin = param1;
         this.barTipWidth = param1.leftTipBg.width;
         this.barHeight = param1.leftTipBg.height;
         this.shadowTipWidth = param1.shadowLeftTip.width;
         this.shadowHeight = param1.shadow.height;
         this.barOffsetX = this.shadowTipWidth - this.barTipWidth;
         this.barOffsetY = this.shadowHeight - this.barHeight >> 1;
      }
      
      public function get progress() : int
      {
         return this._progress;
      }
      
      public function set progress(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > this.maxValue)
         {
            param1 = this.maxValue;
         }
         this._progress = param1;
      }
      
      public function draw(param1:BitmapData) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Graphics = this.canvas.graphics;
         _loc2_.clear();
         _loc2_.beginBitmapFill(this.skin.shadowLeftTip);
         _loc2_.drawRect(0,0,this.shadowTipWidth,this.shadowHeight);
         _loc2_.beginBitmapFill(this.skin.shadow);
         _loc2_.drawRect(this.shadowTipWidth,0,this.barWidth - 2 * this.barTipWidth,this.shadowHeight);
         _loc2_.beginBitmapFill(this.skin.shadowRightTip);
         _loc2_.drawRect(this.shadowTipWidth + this.barWidth - 2 * this.barTipWidth,0,this.shadowTipWidth,this.shadowHeight);
         _loc2_.endFill();
         var _loc3_:int = this.barWidth * this._progress / this.maxValue;
         var _loc5_:int = this.barWidth - this.barTipWidth;
         if(_loc3_ >= this.barTipWidth)
         {
            if(_loc3_ == this.barWidth)
            {
               this.drawFullBar(_loc2_,this.skin.color,this.skin.leftTipFg,this.skin.rightTipFg);
               _loc4_ = _loc3_;
            }
            else
            {
               matrix.tx = this.barOffsetX;
               matrix.ty = this.barOffsetY;
               _loc2_.beginBitmapFill(this.skin.leftTipFg,matrix,false);
               _loc2_.drawRect(this.barOffsetX,this.barOffsetY,this.barTipWidth,this.barHeight);
               if(_loc3_ > this.barTipWidth)
               {
                  if(_loc3_ > _loc5_)
                  {
                     _loc3_ = _loc5_;
                  }
                  _loc4_ = _loc3_;
                  _loc2_.beginFill(this.skin.color);
                  _loc2_.drawRect(this.barOffsetX + this.barTipWidth,this.barOffsetY,_loc3_ - this.barTipWidth,this.barHeight);
               }
               else
               {
                  _loc4_ = this.barTipWidth;
               }
            }
         }
         if(_loc4_ == 0)
         {
            this.drawFullBar(_loc2_,this.skin.bgColor,this.skin.leftTipBg,this.skin.rightTipBg);
         }
         else if(_loc4_ < this.barWidth)
         {
            _loc2_.beginFill(this.skin.bgColor);
            _loc2_.drawRect(this.barOffsetX + _loc4_,this.barOffsetY,_loc5_ - _loc4_,this.barHeight);
            matrix.tx = this.barOffsetX + _loc5_;
            matrix.ty = this.barOffsetY;
            _loc2_.beginBitmapFill(this.skin.rightTipBg,matrix,false);
            _loc2_.drawRect(this.barOffsetX + _loc5_,this.barOffsetY,this.barTipWidth,this.barHeight);
         }
         _loc2_.endFill();
         param1.fillRect(this.rect,0);
         matrix.tx = this.x;
         matrix.ty = this.y;
         param1.draw(this.canvas,matrix);
      }
      
      private function drawFullBar(param1:Graphics, param2:uint, param3:BitmapData, param4:BitmapData) : void
      {
         var _loc5_:int = this.barWidth - this.barTipWidth;
         matrix.tx = this.barOffsetX;
         matrix.ty = this.barOffsetY;
         param1.beginBitmapFill(param3,matrix,false);
         param1.drawRect(this.barOffsetX,this.barOffsetY,this.barTipWidth,this.barHeight);
         param1.beginFill(param2);
         param1.drawRect(this.barOffsetX + this.barTipWidth,this.barOffsetY,_loc5_ - this.barTipWidth,this.barHeight);
         matrix.tx = this.barOffsetX + _loc5_;
         param1.beginBitmapFill(param4,matrix,false);
         param1.drawRect(this.barOffsetX + _loc5_,this.barOffsetY,this.barTipWidth,this.barHeight);
      }
   }
}

