package scpacker.networking.protocol.codec.custom
{
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.Resource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class ResourceGetterCodec implements ICodec
   {
      private var newname_122__END:ResourceRegistry;
      
      private var newname_4575__END:ICodec;
      
      public function ResourceGetterCodec(param1:ProtocolInitializer, param2:ResourceRegistry)
      {
         super();
         this.newname_122__END = param2;
         this.newname_4575__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.LongCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:Long = Long(this.newname_4575__END.decode(param1));
         var _loc3_:Resource = this.newname_122__END.getResource(_loc2_);
         if(_loc3_ == null)
         {
            throw new Error("Resource " + _loc2_ + " not found");
         }
         return _loc3_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc3_:int = int(param2.value);
         param1.writeInt(_loc3_);
         return 4;
      }
   }
}

