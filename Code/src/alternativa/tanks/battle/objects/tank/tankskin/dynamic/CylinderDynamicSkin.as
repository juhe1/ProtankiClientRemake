package alternativa.tanks.battle.objects.tank.tankskin.dynamic
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Vertex;
   
   public class CylinderDynamicSkin extends CommonDynamicSkin
   {
      
      private var real2UVratio:Number;
      
      private var radius:Number;
      
      private var uvPeriod:Number;
      
      public function CylinderDynamicSkin(param1:Number)
      {
         super();
         this.uvPeriod = param1;
      }
      
      private static function get2UVRatio(param1:Face) : Number
      {
         var _loc2_:Vector.<Vertex> = param1.vertices;
         return get2UVRatioForVertices(_loc2_[0],_loc2_[1]);
      }
      
      private static function get2UVRatioForVertices(param1:Vertex, param2:Vertex) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         var _loc5_:Number = param1.z - param2.z;
         var _loc6_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_ + _loc5_ * _loc5_);
         var _loc7_:Number = param1.u - param2.u;
         var _loc8_:Number = param1.v - param2.v;
         var _loc9_:Number = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
         return _loc9_ / _loc6_;
      }
      
      override public function init() : void
      {
         var _loc1_:Face = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Vertex = null;
         var _loc7_:Vertex = null;
         super.init();
         this.real2UVratio = 0;
         for each(_loc1_ in faces)
         {
            this.real2UVratio += get2UVRatio(_loc1_);
         }
         this.real2UVratio /= faces.length;
         _loc2_ = Number.POSITIVE_INFINITY;
         _loc3_ = Number.POSITIVE_INFINITY;
         _loc4_ = Number.NEGATIVE_INFINITY;
         _loc5_ = Number.NEGATIVE_INFINITY;
         for each(_loc6_ in vertices)
         {
            _loc7_ = _loc6_;
            if(_loc7_.x < _loc2_)
            {
               _loc2_ = Number(_loc7_.x);
            }
            if(_loc7_.z < _loc3_)
            {
               _loc3_ = Number(_loc7_.z);
            }
            if(_loc7_.x > _loc4_)
            {
               _loc4_ = Number(_loc7_.x);
            }
            if(_loc7_.z > _loc5_)
            {
               _loc5_ = Number(_loc7_.z);
            }
         }
         this.radius = (_loc4_ - _loc2_ + _loc5_ - _loc3_) / 4;
         rotation = 0;
         this.rotate(0);
      }
      
      override public function rotate(param1:Number) : void
      {
         super.rotate(param1);
      }
   }
}

