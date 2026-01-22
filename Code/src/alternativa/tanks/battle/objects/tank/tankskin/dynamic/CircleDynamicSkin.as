package alternativa.tanks.battle.objects.tank.tankskin.dynamic
{
   import alternativa.engine3d.core.Vertex;
   import flash.geom.Point;
   
   public class CircleDynamicSkin extends CommonDynamicSkin
   {
      
      private var centerU:Number;
      
      private var centerV:Number;
      
      public function CircleDynamicSkin(param1:Number, param2:Number)
      {
         super();
         this.centerU = param1;
         this.centerV = param2;
      }
      
      override public function rotate(param1:Number) : void
      {
         var _loc5_:Vertex = null;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         super.rotate(param1);
         var _loc2_:Number = Math.cos(rotation);
         var _loc3_:Number = -Math.sin(rotation);
         var _loc4_:int = 0;
         while(_loc4_ < vertices.length)
         {
            _loc5_ = vertices[_loc4_];
            _loc6_ = originalUVs[_loc4_];
            _loc7_ = _loc6_.x - this.centerU;
            _loc8_ = _loc6_.y - this.centerV;
            _loc5_.u = _loc7_ * _loc2_ + _loc8_ * _loc3_ + this.centerU;
            _loc5_.v = _loc7_ * _loc3_ - _loc8_ * _loc2_ + this.centerV;
            _loc4_++;
         }
      }
   }
}

