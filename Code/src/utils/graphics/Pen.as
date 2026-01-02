package utils.graphics
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class Pen
   {
      
      private var _gTarget:Graphics;
      
      private var _bLineStyleSet:Boolean;
      
      public function Pen(param1:Graphics)
      {
         super();
         this._gTarget = param1;
      }
      
      public function set target(param1:Graphics) : void
      {
         this._gTarget = param1;
      }
      
      public function get target() : Graphics
      {
         return this._gTarget;
      }
      
      public function lineStyle(param1:Number = 1, param2:Number = 0, param3:Number = 1, param4:Boolean = false, param5:String = "normal", param6:String = null, param7:String = null, param8:Number = 3) : void
      {
         this._gTarget.lineStyle(param1,param2,param3,param4,param5,param6,param7,param8);
         this._bLineStyleSet = true;
      }
      
      public function lineGradientStyle(param1:String, param2:Array, param3:Array, param4:Array, param5:Matrix = null, param6:String = "pad", param7:String = "rgb", param8:Number = 0) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.lineGradientStyle(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function beginFill(param1:Number, param2:Number = 1) : void
      {
         this._gTarget.beginFill(param1,param2);
      }
      
      public function beginGradientFill(param1:String, param2:Array, param3:Array, param4:Array, param5:Matrix = null, param6:String = "pad", param7:String = "rgb", param8:Number = 0) : void
      {
         this._gTarget.beginGradientFill(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function beginBitmapFill(param1:BitmapData, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false) : void
      {
         this._gTarget.beginBitmapFill(param1,param2,param3,param4);
      }
      
      public function endFill() : void
      {
         this._gTarget.endFill();
      }
      
      public function clear() : void
      {
         this._gTarget.clear();
         this._bLineStyleSet = false;
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         this._gTarget.moveTo(param1,param2);
      }
      
      public function lineTo(param1:Number, param2:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.lineTo(param1,param2);
      }
      
      public function curveTo(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.curveTo(param1,param2,param3,param4);
      }
      
      public function drawLine(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.moveTo(param1,param2);
         this._gTarget.lineTo(param3,param4);
      }
      
      public function drawCurve(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.moveTo(param1,param2);
         this._gTarget.curveTo(param3,param4,param5,param6);
      }
      
      public function drawRect(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.drawRect(param1,param2,param3,param4);
      }
      
      public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.drawRoundRect(param1,param2,param3,param4,param5);
      }
      
      public function drawRoundRectComplex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.drawRoundRectComplex(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function drawCircle(param1:Number, param2:Number, param3:Number) : void
      {
         if(!this._bLineStyleSet)
         {
            this.lineStyle();
         }
         this._gTarget.drawCircle(param1,param2,param3);
      }
      
      public function drawSlice(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.drawArc(param4,param5,param2,param1,param3,true);
      }
      
      public function drawArc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Boolean = false) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         if(param4 > 360)
         {
            param4 = 360;
         }
         param4 = Math.PI / 180 * param4;
         var _loc7_:Number = param4 / 8;
         var _loc8_:Number = param3 / Math.cos(_loc7_ / 2);
         param5 *= Math.PI / 180;
         var _loc9_:Number = param5;
         var _loc14_:Number = param1 + Math.cos(param5) * param3;
         var _loc15_:Number = param2 + Math.sin(param5) * param3;
         if(param6)
         {
            this.moveTo(param1,param2);
            this.lineTo(_loc14_,_loc15_);
         }
         else
         {
            this.moveTo(_loc14_,_loc15_);
         }
         var _loc16_:Number = 0;
         while(_loc16_ < 8)
         {
            _loc9_ += _loc7_;
            _loc10_ = param1 + Math.cos(_loc9_ - _loc7_ / 2) * _loc8_;
            _loc11_ = param2 + Math.sin(_loc9_ - _loc7_ / 2) * _loc8_;
            _loc12_ = param1 + Math.cos(_loc9_) * param3;
            _loc13_ = param2 + Math.sin(_loc9_) * param3;
            this.curveTo(_loc10_,_loc11_,_loc12_,_loc13_);
            _loc16_++;
         }
         if(param6)
         {
            this.lineTo(param1,param2);
         }
      }
      
      public function drawEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc5_:Number = Math.PI / 4;
         var _loc6_:Number = 0;
         var _loc7_:Number = param3 / Math.cos(_loc5_ / 2);
         var _loc8_:Number = param4 / Math.cos(_loc5_ / 2);
         this.moveTo(param1 + param3,param2);
         var _loc13_:Number = 0;
         while(_loc13_ < 8)
         {
            _loc6_ += _loc5_;
            _loc9_ = param1 + Math.cos(_loc6_ - _loc5_ / 2) * _loc7_;
            _loc10_ = param2 + Math.sin(_loc6_ - _loc5_ / 2) * _loc8_;
            _loc11_ = param1 + Math.cos(_loc6_) * param3;
            _loc12_ = param2 + Math.sin(_loc6_) * param4;
            this.curveTo(_loc9_,_loc10_,_loc11_,_loc12_);
            _loc13_++;
         }
      }
      
      public function drawTriangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : void
      {
         param6 = param6 * Math.PI / 180;
         param5 = param5 * Math.PI / 180;
         var _loc7_:Number = Math.cos(param5 - param6) * param3;
         var _loc8_:Number = Math.sin(param5 - param6) * param3;
         var _loc9_:Number = Math.cos(-param6) * param4;
         var _loc10_:Number = Math.sin(-param6) * param4;
         var _loc11_:Number = 0;
         var _loc12_:Number = 0;
         this.drawLine(-_loc11_ + param1,-_loc12_ + param2,_loc9_ - _loc11_ + param1,_loc10_ - _loc12_ + param2);
         this.lineTo(_loc7_ - _loc11_ + param1,_loc8_ - _loc12_ + param2);
         this.lineTo(-_loc11_ + param1,-_loc12_ + param2);
      }
      
      public function drawRegularPolygon(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0) : void
      {
         param5 = param5 * Math.PI / 180;
         var _loc6_:Number = 2 * Math.PI / param3;
         var _loc7_:Number = param4 / 2 / Math.sin(_loc6_ / 2);
         var _loc8_:Number = Math.cos(param5) * _loc7_ + param1;
         var _loc9_:Number = Math.sin(param5) * _loc7_ + param2;
         this.moveTo(_loc8_,_loc9_);
         var _loc10_:Number = 1;
         while(_loc10_ <= param3)
         {
            _loc8_ = Math.cos(_loc6_ * _loc10_ + param5) * _loc7_ + param1;
            _loc9_ = Math.sin(_loc6_ * _loc10_ + param5) * _loc7_ + param2;
            this.lineTo(_loc8_,_loc9_);
            _loc10_++;
         }
      }
      
      public function drawStar(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : void
      {
         if(param3 < 3)
         {
            return;
         }
         var _loc7_:Number = Math.PI * 2 / param3;
         param6 = Math.PI * (param6 - 90) / 180;
         var _loc8_:Number = param6;
         var _loc9_:Number = param1 + Math.cos(_loc8_ + _loc7_ / 2) * param4;
         var _loc10_:Number = param2 + Math.sin(_loc8_ + _loc7_ / 2) * param4;
         this.moveTo(_loc9_,_loc10_);
         _loc8_ += _loc7_;
         var _loc11_:Number = 0;
         while(_loc11_ < param3)
         {
            _loc9_ = param1 + Math.cos(_loc8_) * param5;
            _loc10_ = param2 + Math.sin(_loc8_) * param5;
            this.lineTo(_loc9_,_loc10_);
            _loc9_ = param1 + Math.cos(_loc8_ + _loc7_ / 2) * param4;
            _loc10_ = param2 + Math.sin(_loc8_ + _loc7_ / 2) * param4;
            this.lineTo(_loc9_,_loc10_);
            _loc8_ += _loc7_;
            _loc11_++;
         }
      }
   }
}

