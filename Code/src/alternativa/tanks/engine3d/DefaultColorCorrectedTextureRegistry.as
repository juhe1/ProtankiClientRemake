package alternativa.tanks.engine3d
{
   import alternativa.tanks.services.colortransform.ColorTransformUtils;
   import alternativa.utils.clearDictionary;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   import org1.osflash.signals.Signal;
   
   public class DefaultColorCorrectedTextureRegistry implements ColorCorrectedTextureRegistry
   {
      
      private static const IDENTITY_COLOR_TRANSFORM:ColorTransform = new ColorTransform();
      
      private const onTextureChange:Signal = new Signal();
      
      private const textures:Dictionary = new Dictionary();
      
      private var colorTransform:ColorTransform;
      
      public function DefaultColorCorrectedTextureRegistry()
      {
         super();
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:BitmapData = null;
         if(this.colorTransform == null)
         {
            clearDictionary(this.textures);
         }
         else
         {
            _loc1_ = 0;
            for(_loc2_ in this.textures)
            {
               _loc3_ = this.textures[_loc2_];
               _loc3_.dispose();
               delete this.textures[_loc2_];
               _loc1_++;
            }
         }
      }
      
      public function getTexture(param1:BitmapData, param2:Boolean = true) : BitmapData
      {
         if(param1 == null)
         {
            throw new ArgumentError("Texture is null");
         }
         var _loc3_:BitmapData = this.textures[param1];
         if(_loc3_ == null)
         {
            _loc3_ = this.transformTexture(param1,param2);
            this.textures[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      private function transformTexture(param1:BitmapData, param2:Boolean = true) : BitmapData
      {
         if(this.colorTransform == null)
         {
            return param1;
         }
         if(param2)
         {
            return ColorTransformUtils.transformBitmap(param1,this.colorTransform);
         }
         return param1.clone();
      }
      
      public function addTextureChangeHandler(param1:Function) : void
      {
         this.onTextureChange.add(param1);
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
         var _loc2_:ColorTransform = this.getEffectiveColorTransform(param1);
         if(!ColorTransformUtils.equal(this.colorTransform,_loc2_))
         {
            this.colorTransform = _loc2_;
            this.updateTextures();
            this.onTextureChange.dispatch();
         }
      }
      
      private function getEffectiveColorTransform(param1:ColorTransform) : ColorTransform
      {
         var _loc2_:ColorTransform = ColorTransformUtils.clone(param1);
         if(ColorTransformUtils.equal(_loc2_,IDENTITY_COLOR_TRANSFORM))
         {
            return null;
         }
         return _loc2_;
      }
      
      private function updateTextures() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:BitmapData = null;
         var _loc1_:int = 0;
         for(_loc2_ in this.textures)
         {
            _loc3_ = this.textures[_loc2_];
            if(_loc3_ != _loc2_)
            {
               _loc3_.dispose();
               _loc1_++;
            }
            this.textures[_loc2_] = this.transformTexture(_loc2_);
         }
      }
   }
}

