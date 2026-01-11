package alternativa.tanks.models.sfx.colortransform
{
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.ColorTransformModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.IColorTransformModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;
   
   [ModelInfo]
   public class ColorTransformModel extends ColorTransformModelBase implements IColorTransformModelBase, ObjectLoadPostListener
   {
      
      public function ColorTransformModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:Vector.<ColorTransformStruct> = getInitParam().colorTransforms;
         var _loc2_:uint = _loc1_.length;
         var _loc3_:Vector.<ColorTransformEntry> = new Vector.<ColorTransformEntry>(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = new ColorTransformEntry(_loc1_[_loc4_]);
            _loc4_++;
         }
         if(_loc3_.length != 0)
         {
            (object.event(ColorTransformConsumer) as ColorTransformConsumer).initColorTransform(_loc3_);
         }
      }
   }
}

