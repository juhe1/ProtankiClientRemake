package alternativa.protocol.osgi
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.codec.primitive.ByteCodec;
   import alternativa.protocol.codec.primitive.DoubleCodec;
   import alternativa.protocol.codec.primitive.FloatCodec;
   import alternativa.protocol.codec.primitive.IntCodec;
   import alternativa.protocol.codec.primitive.LongCodec;
   import alternativa.protocol.codec.primitive.ShortCodec;
   import alternativa.protocol.codec.primitive.UByteCodec;
   import alternativa.protocol.codec.primitive.UIntCodec;
   import alternativa.protocol.codec.primitive.UShortCodec;
   import alternativa.protocol.impl.Protocol;
   import alternativa.types.Byte;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import alternativa.types.UByte;
   import alternativa.types.UShort;
   
   public class ProtocolActivator implements IBundleActivator
   {
      
      public function ProtocolActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         var _loc2_:IProtocol = Protocol.defaultInstance;
         param1.registerService(IProtocol,_loc2_);
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

