package alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim
{
   import alternativa.tanks.utils.MathUtils;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class AimShape extends Sprite
   {
      
      private static const halfSquareClass:Class = AimShape_halfSquareClass;
      
      private static const halfSquare:BitmapData = new halfSquareClass().bitmapData;
      
      private static const OFFSET_BETWEEN_SQUARES:int = 9;
      
      private static const CIRCLE_FILL_COLOR:uint = 8056625;
      
      private static const CIRCLE_BACKGROUND_COLOR:uint = 2456322;
      
      private static const CIRCLE_THICKNESS:Number = 3;
      
      private static const CIRCLE_RADIUS:Number = 28;
      
      private const matrix:Matrix = new Matrix();
      
      private var circleShape:Shape;
      
      private var texture:BitmapData;
      
      private var rectForClearing:Rectangle;
      
      public function AimShape()
      {
         super();
         this.createSquare();
         this.createCircleShape();
         this.rectForClearing = new Rectangle(0,0,this.width,this.height);
      }
      
      private function createSquare() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.beginBitmapFill(halfSquare);
         _loc1_.drawRect(0,0,halfSquare.width,halfSquare.height);
         _loc1_.endFill();
         this.matrix.tx = -OFFSET_BETWEEN_SQUARES;
         this.matrix.ty = -OFFSET_BETWEEN_SQUARES;
         this.matrix.rotate(Math.PI);
         _loc1_.beginBitmapFill(halfSquare,this.matrix);
         _loc1_.drawRect(OFFSET_BETWEEN_SQUARES,OFFSET_BETWEEN_SQUARES,halfSquare.width,halfSquare.height);
         _loc1_.endFill();
      }
      
      private function createCircleShape() : void
      {
         this.circleShape = new Shape();
         this.circleShape.filters = [new GlowFilter(0,0.6,2,2,2,BitmapFilterQuality.HIGH)];
         this.circleShape.x = halfSquare.width + OFFSET_BETWEEN_SQUARES >> 1;
         this.circleShape.y = halfSquare.height + OFFSET_BETWEEN_SQUARES >> 1;
         this.circleShape.visible = false;
         addChild(this.circleShape);
         this.matrix.identity();
         this.matrix.tx = this.circleShape.x;
         this.matrix.ty = this.circleShape.y;
      }
      
      public function setTexture(param1:BitmapData) : void
      {
         this.texture = param1;
      }
      
      public function update(param1:Boolean, param2:Number = 0) : void
      {
         this.texture.fillRect(this.rectForClearing,0);
         this.circleShape.visible = !param1;
         this.drawCircle(param2);
         this.texture.draw(this);
      }
      
      private function drawCircle(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(!this.circleShape.visible)
         {
            return;
         }
         param1 = MathUtils.clamp(param1,0,1);
         var _loc2_:Graphics = this.circleShape.graphics;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_.clear();
         _loc2_.lineStyle(CIRCLE_THICKNESS,CIRCLE_BACKGROUND_COLOR);
         _loc2_.drawCircle(_loc3_,_loc4_,CIRCLE_RADIUS);
         if(param1 > 0)
         {
            _loc2_.lineStyle(CIRCLE_THICKNESS,CIRCLE_FILL_COLOR);
            _loc5_ = Math.PI / 2;
            _loc6_ = _loc5_ + MathUtils.PI2 * param1;
            this.drawCircleSegment(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,CIRCLE_RADIUS);
         }
      }
      
      private function drawCircleSegment(param1:Graphics, param2:int, param3:int, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         param1.moveTo(param2 + Math.cos(param4) * param6,param3 + Math.sin(param4) * param6);
         var _loc7_:uint = 8;
         var _loc8_:Number = (param5 - param4) / _loc7_;
         var _loc9_:Number = param4;
         var _loc10_:Number = param6 / Math.cos(_loc8_ / 2);
         var _loc11_:int = 0;
         while(_loc11_ < _loc7_)
         {
            _loc9_ += _loc8_;
            _loc12_ = _loc9_ - _loc8_ / 2;
            _loc13_ = param2 + Math.cos(_loc12_) * _loc10_;
            _loc14_ = param3 + Math.sin(_loc12_) * _loc10_;
            _loc15_ = param2 + Math.cos(_loc9_) * param6;
            _loc16_ = param3 + Math.sin(_loc9_) * param6;
            param1.curveTo(_loc13_,_loc14_,_loc15_,_loc16_);
            _loc11_++;
         }
      }
   }
}

