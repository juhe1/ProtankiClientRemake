package alternativa.tanks.display.usertitle
{
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   
   public class RadialBar extends Sprite
   {
      
      private const SEGMENTS_COUNT:int = 45;
      
      private var canvas:Shape = new Shape();
      
      private var value:Number;
      
      private var color:uint;
      
      private var backColor:uint;
      
      private var radius:int;
      
      private var thickness:Number;
      
      private var mirrored:Boolean;
      
      public function RadialBar(param1:uint, param2:uint, param3:int, param4:Number, param5:Boolean = false)
      {
         super();
         this.color = param1;
         this.backColor = param2;
         this.radius = param3;
         this.thickness = param4;
         this.mirrored = param5;
         this.canvas.filters = [new GlowFilter(0,0.6,3,3,2,BitmapFilterQuality.HIGH)];
         addChild(this.canvas);
      }
      
      public function setValue(param1:Number) : void
      {
         this.value = Math.max(0,Math.min(1,param1));
         this.draw();
      }
      
      public function draw() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc1_:Graphics = this.canvas.graphics;
         _loc1_.clear();
         _loc1_.moveTo(0,0 - this.radius);
         var _loc2_:int = this.SEGMENTS_COUNT * this.value;
         _loc1_.moveTo(0,0 - this.radius);
         _loc1_.lineStyle(this.thickness,this.backColor);
         _loc3_ = this.SEGMENTS_COUNT;
         while(_loc3_ >= 0)
         {
            _loc4_ = _loc3_ * 2 * Math.PI / 180;
            if(_loc3_ == _loc2_ - 1)
            {
               _loc1_.lineStyle(this.thickness,this.color);
            }
            _loc1_.lineTo(0 - Math.cos(_loc4_) * this.radius * (this.mirrored ? -1 : 1),0 - Math.sin(_loc4_) * this.radius);
            _loc3_--;
         }
      }
   }
}

