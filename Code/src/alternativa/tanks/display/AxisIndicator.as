package alternativa.tanks.display
{
   import alternativa.engine3d.core.Camera3D;
   import flash.display.Shape;
   import alternativa.engine3d.alternativa3d;

   use namespace alternativa3d;
   
   public class AxisIndicator extends Shape
   {
      
      private const axis1:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0]);
      
      private var _size:int;
      
      public function AxisIndicator(param1:int)
      {
         super();
         this._size = param1;
      }
      
      public function update(param1:Camera3D) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         graphics.clear();
         param1.composeMatrix();
         this.axis1[0] = param1.ma;
         this.axis1[1] = param1.mb;
         this.axis1[2] = param1.me;
         this.axis1[3] = param1.mf;
         this.axis1[4] = param1.mi;
         this.axis1[5] = param1.mj;
         var _loc2_:int = this._size / 2;
         var _loc3_:int = 0;
         var _loc4_:int = 16;
         while(_loc3_ < 6)
         {
            _loc5_ = this.axis1[_loc3_] + 1;
            _loc6_ = this.axis1[int(_loc3_ + 1)] + 1;
            graphics.lineStyle(0,255 << _loc4_);
            graphics.moveTo(_loc2_,_loc2_);
            graphics.lineTo(_loc2_ * _loc5_,_loc2_ * _loc6_);
            _loc3_ += 2;
            _loc4_ -= 8;
         }
      }
      
      public function get size() : int
      {
         return this._size;
      }
   }
}

