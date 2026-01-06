package alternativa.tanks.models.sfx.colortransform
{
   import alternativa.object.ClientObject;

   [ModelInterface]
   public interface ColorTransformConsumer
   {
      
      function initColorTransform(clientObject:ClientObject, param1:Vector.<ColorTransformEntry>) : void;
   }
}

