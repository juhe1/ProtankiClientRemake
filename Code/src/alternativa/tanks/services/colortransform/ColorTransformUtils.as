package alternativa.tanks.services.colortransform
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.Color;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   
   public class ColorTransformUtils
   {
      
      public function ColorTransformUtils()
      {
         super();
      }
      
      public static function transformBitmap(param1:BitmapData, param2:ColorTransform) : BitmapData
      {
         var _loc3_:BitmapData = param1.clone();
         _loc3_.colorTransform(_loc3_.rect,param2);
         return _loc3_;
      }
      
      public static function equal(param1:ColorTransform, param2:ColorTransform) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1 == null || param2 == null)
         {
            return false;
         }
         return param1.redMultiplier == param2.redMultiplier && param1.greenMultiplier == param2.greenMultiplier && param1.blueMultiplier == param2.blueMultiplier && param1.alphaMultiplier == param2.alphaMultiplier && param1.redOffset == param2.redOffset && param1.greenOffset == param2.greenOffset && param1.blueOffset == param2.blueOffset && param1.alphaOffset == param2.alphaOffset;
      }
      
      public static function clone(param1:ColorTransform) : ColorTransform
      {
         if(param1 == null)
         {
            return null;
         }
         return new ColorTransform(param1.redMultiplier,param1.greenMultiplier,param1.blueMultiplier,param1.alphaMultiplier,param1.redOffset,param1.greenOffset,param1.blueOffset,param1.alphaOffset);
      }
      
      public static function toString(param1:ColorTransform) : String
      {
         if(param1 == null)
         {
            return "null";
         }
         return param1.toString();
      }
      
      public static function calculateColorTransform(param1:DynamicShadowParams, param2:Number) : ColorTransform
      {
         var _loc3_:Color = null;
         var _loc4_:Color = null;
         var _loc5_:Matrix3 = null;
         var _loc6_:Vector3 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:ColorTransform = null;
         if(!GPUCapabilities.gpuEnabled || Boolean(GPUCapabilities.constrained))
         {
            _loc3_ = new Color(param1.lightColor);
            _loc4_ = new Color(param1.shadowColor);
            _loc3_.subtract(_loc4_);
            _loc5_ = new Matrix3();
            _loc5_.setRotationMatrix(param1.angleX,0,param1.angleZ);
            _loc6_ = new Vector3(0,1,0);
            _loc6_.transform3(_loc5_);
            _loc6_.normalize();
            _loc7_ = Math.abs(_loc6_.z) * param2;
            _loc8_ = (_loc4_.getColor() >> 16 & 0xFF) / 255;
            _loc9_ = (_loc4_.getColor() >> 8 & 0xFF) / 255;
            _loc10_ = (_loc4_.getColor() & 0xFF) / 255;
            _loc11_ = (_loc3_.getColor() >> 16 & 0xFF) / 255;
            _loc12_ = (_loc3_.getColor() >> 8 & 0xFF) / 255;
            _loc13_ = (_loc3_.getColor() & 0xFF) / 255;
            _loc14_ = new ColorTransform();
            _loc14_.redMultiplier = 2 * (_loc8_ + _loc11_ * _loc7_);
            _loc14_.greenMultiplier = 2 * (_loc9_ + _loc12_ * _loc7_);
            _loc14_.blueMultiplier = 2 * (_loc10_ + _loc13_ * _loc7_);
            return _loc14_;
         }
         return null;
      }
   }
}

