package alternativa.tanks.utils
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.math.Vector3;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.engine3d.UVFrame;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import flash.filters.BitmapFilter;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   
   public class GraphicsUtils
   {
      
      private static var filteredImages:Dictionary = new Dictionary(true);
      
      public function GraphicsUtils()
      {
         super();
      }
      
      public static function setObjectTransform(param1:Object3D, param2:Vector3, param3:Vector3) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
         param1.z = param2.z;
         param1.rotationX = param3.x;
         param1.rotationY = param3.y;
         param1.rotationZ = param3.z;
      }
      
      public static function getTextureAnimationFromResource(param1:TextureMaterialRegistry, param2:MultiframeImageResource) : TextureAnimation
      {
         var _loc3_:TextureAnimation = getTextureAnimation(param1,param2.data,param2.frameWidth,param2.frameHeight,param2.numFrames);
         _loc3_.fps = param2.fps;
         return _loc3_;
      }
      
      public static function createFilteredImage(param1:BitmapData, param2:BitmapFilter) : BitmapData
      {
         var _loc3_:* = undefined;
         var _loc4_:BitmapData = null;
         var _loc5_:Object = null;
         for(_loc3_ in filteredImages)
         {
            _loc5_ = filteredImages[_loc3_];
            if(_loc5_.s == param1 && _loc5_.f == param2)
            {
               return _loc3_;
            }
         }
         _loc4_ = param1.clone();
         _loc4_.applyFilter(param1,param1.rect,new Point(),param2);
         filteredImages[_loc4_] = {
            "s":param1,
            "f":param2
         };
         return _loc4_;
      }
      
      public static function getTextureAnimation(param1:TextureMaterialRegistry, param2:BitmapData, param3:int, param4:int, param5:int = 0, param6:Boolean = true) : TextureAnimation
      {
         var _loc7_:TextureMaterial = param1.getMaterial(param2);
         var _loc8_:Vector.<UVFrame> = getUVFramesFromTexture(param2,param3,param4,param5);
         return new TextureAnimation(_loc7_,_loc8_);
      }
      
      public static function getUVFramesFromTexture(param1:BitmapData, param2:int, param3:int, param4:int = 0) : Vector.<UVFrame>
      {
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc5_:int = param1.width;
         var _loc6_:int = Math.min(param2,_loc5_);
         var _loc7_:int = _loc5_ / _loc6_;
         var _loc8_:int = param1.height;
         var _loc9_:int = Math.min(param3,_loc8_);
         var _loc10_:int = _loc8_ / _loc9_;
         var _loc11_:int = _loc7_ * _loc10_;
         if(param4 > 0 && _loc11_ > param4)
         {
            _loc11_ = param4;
         }
         var _loc12_:Vector.<UVFrame> = new Vector.<UVFrame>(_loc11_);
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         while(_loc14_ < _loc10_)
         {
            _loc15_ = _loc14_ * _loc9_;
            _loc16_ = _loc15_ + _loc9_;
            _loc17_ = 0;
            while(_loc17_ < _loc7_)
            {
               _loc18_ = _loc17_ * _loc6_;
               _loc19_ = _loc18_ + _loc6_;
               _loc12_[_loc13_++] = new UVFrame(_loc18_ / _loc5_,_loc15_ / _loc8_,_loc19_ / _loc5_,_loc16_ / _loc8_);
               if(_loc13_ == _loc11_)
               {
                  return _loc12_;
               }
               _loc17_++;
            }
            _loc14_++;
         }
         return _loc12_;
      }
      
      public static function getUVFramesFromTextureWithMirror(param1:BitmapData, param2:int, param3:int, param4:int = 0) : Vector.<UVFrame>
      {
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc5_:int = param1.width;
         var _loc6_:int = Math.min(param2,_loc5_);
         var _loc7_:int = _loc5_ / _loc6_;
         var _loc8_:int = param1.height;
         var _loc9_:int = Math.min(param3,_loc8_);
         var _loc10_:int = _loc8_ / _loc9_;
         var _loc11_:int = _loc7_ * _loc10_;
         if(param4 > 0 && _loc11_ > param4)
         {
            _loc11_ = param4;
         }
         var _loc12_:Vector.<UVFrame> = new Vector.<UVFrame>(_loc11_);
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         while(_loc14_ < _loc10_)
         {
            _loc15_ = _loc14_ * _loc9_;
            _loc16_ = _loc15_ + _loc9_;
            _loc17_ = 0;
            while(_loc17_ < _loc7_)
            {
               _loc18_ = _loc17_ * _loc6_;
               _loc19_ = _loc18_ + _loc6_;
               _loc20_ = _loc18_ / _loc5_;
               _loc21_ = _loc19_ / _loc5_;
               _loc12_[_loc13_++] = new UVFrame(_loc20_,_loc15_ / _loc8_,_loc21_,_loc16_ / _loc8_);
               if(_loc13_ == _loc11_)
               {
                  return _loc12_;
               }
               _loc12_[_loc13_++] = new UVFrame(_loc21_,_loc15_ / _loc8_,_loc20_,_loc16_ / _loc8_);
               if(_loc13_ == _loc11_)
               {
                  return _loc12_;
               }
               _loc17_++;
            }
            _loc14_++;
         }
         return _loc12_;
      }
   }
}

