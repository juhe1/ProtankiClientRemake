package alternativa.protocol.impl
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.*;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.codec.complex.ByteArrayCodec;
   import alternativa.protocol.codec.complex.StringCodec;
   import alternativa.protocol.codec.primitive.BooleanCodec;
   import alternativa.protocol.codec.primitive.ByteCodec;
   import alternativa.protocol.codec.primitive.DoubleCodec;
   import alternativa.protocol.codec.primitive.FloatCodec;
   import alternativa.protocol.codec.primitive.IntCodec;
   import alternativa.protocol.codec.primitive.LongCodec;
   import alternativa.protocol.codec.primitive.ShortCodec;
   import alternativa.protocol.codec.primitive.UIntCodec;
   import alternativa.protocol.codec.primitive.UShortCodec;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import alternativa.types.UShort;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
   import _codec.platform.client.core.general.resourcelocale.format.CodecLocalizedFileFormat;
   import platform.client.core.general.resourcelocale.format.StringPair;
   import _codec.platform.client.core.general.resourcelocale.format.CodecStringPair;
   import platform.client.core.general.resourcelocale.format.ImagePair;
   import _codec.platform.client.core.general.resourcelocale.format.CodecImagePair;
   import _codec.platform.client.core.general.resourcelocale.format.VectorCodecStringPairLevel1;
   import alternativa.protocol.info.CollectionCodecInfo;
   import _codec.platform.client.core.general.resourcelocale.format.VectorCodecImagePairLevel1;
   
   public class Protocol implements IProtocol
   {
      
      [Inject] // added
      public static var clientLog:IClientLog;
      
      private static const LOG_CHANNEL:String = "protocol";
      
      public static var defaultInstance:IProtocol = new Protocol();
      
      private var info2codec:Object = new Object();
      
      private var listInitCodec:Dictionary = new Dictionary(false);
      
      public function Protocol()
      {
         super();
         this.registerCodec(new TypeCodecInfo(int,false),new IntCodec());
         this.registerCodec(new TypeCodecInfo(Short,false),new ShortCodec());
         this.registerCodec(new TypeCodecInfo(Byte,false),new ByteCodec());
         this.registerCodec(new TypeCodecInfo(UShort,false),new UShortCodec());
         this.registerCodec(new TypeCodecInfo(uint,false),new UIntCodec());
         this.registerCodec(new TypeCodecInfo(Number,false),new DoubleCodec());
         this.registerCodec(new TypeCodecInfo(Float,false),new FloatCodec());
         this.registerCodec(new TypeCodecInfo(Boolean,false),new BooleanCodec());
         this.registerCodec(new TypeCodecInfo(Long,false),new LongCodec());
         this.registerCodec(new TypeCodecInfo(String,false),new StringCodec());
         this.registerCodec(new TypeCodecInfo(ByteArray,false),new ByteArrayCodec());
         this.registerCodec(new TypeCodecInfo(int,true),new OptionalCodecDecorator(new IntCodec()));
         this.registerCodec(new TypeCodecInfo(Short,true),new OptionalCodecDecorator(new ShortCodec()));
         this.registerCodec(new TypeCodecInfo(Byte,true),new OptionalCodecDecorator(new ByteCodec()));
         this.registerCodec(new TypeCodecInfo(UShort,true),new OptionalCodecDecorator(new UShortCodec()));
         this.registerCodec(new TypeCodecInfo(uint,true),new OptionalCodecDecorator(new UIntCodec()));
         this.registerCodec(new TypeCodecInfo(Number,true),new OptionalCodecDecorator(new DoubleCodec()));
         this.registerCodec(new TypeCodecInfo(Float,true),new OptionalCodecDecorator(new FloatCodec()));
         this.registerCodec(new TypeCodecInfo(Boolean,true),new OptionalCodecDecorator(new BooleanCodec()));
         this.registerCodec(new TypeCodecInfo(Long,true),new OptionalCodecDecorator(new LongCodec()));
         this.registerCodec(new TypeCodecInfo(String,true),new OptionalCodecDecorator(new StringCodec()));
         this.registerCodec(new TypeCodecInfo(ByteArray,true),new OptionalCodecDecorator(new ByteArrayCodec()));

         // localization
         this.registerCodec(new TypeCodecInfo(LocalizedFileFormat,false),new CodecLocalizedFileFormat());
         this.registerCodec(new TypeCodecInfo(StringPair,false),new CodecStringPair());
         this.registerCodec(new TypeCodecInfo(ImagePair,false),new CodecImagePair());
         this.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair,false),false,1), new VectorCodecStringPairLevel1(false));
         this.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair,false),false,1), new VectorCodecImagePairLevel1(false));
      }
      
      public function registerCodec(param1:ICodecInfo, param2:ICodec) : void
      {
         this.info2codec[param1] = param2;
      }
      
      public function registerCodecForType(param1:Class, param2:ICodec) : void
      {
         this.info2codec[new TypeCodecInfo(param1,false)] = param2;
         this.info2codec[new TypeCodecInfo(param1,true)] = new OptionalCodecDecorator(param2);
      }
      
      public function getCodec(param1:ICodecInfo) : ICodec
      {
         var _loc2_:ICodec = this.info2codec[param1];
         if(_loc2_ == null)
         {
            throw Error("Codec not found for  " + param1);
         }
         if(this.listInitCodec[_loc2_] == null)
         {
            this.listInitCodec[_loc2_] = _loc2_;
            _loc2_.init(this);
         }
         return _loc2_;
      }
      
      public function makeCodecInfo(param1:Class) : ICodecInfo
      {
         return new TypeCodecInfo(param1,false);
      }
      
      public function wrapPacket(param1:IDataOutput, param2:ProtocolBuffer, param3:CompressionType) : void
      {
         PacketHelper.wrapPacket(param1,param2,param3);
      }
      
      public function unwrapPacket(param1:IDataInput, param2:ProtocolBuffer, param3:CompressionType) : Boolean
      {
         return PacketHelper.unwrapPacket(param1,param2,param3);
      }
      
      public function decode(param1:Class, param2:ByteArray) : *
      {
         var _loc3_:ICodec = this.getCodec(this.makeCodecInfo(param1));
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:ProtocolBuffer = new ProtocolBuffer(_loc4_,_loc4_,new OptionalMap());
         this.unwrapPacket(param2,_loc5_,CompressionType.DEFLATE_AUTO);
         return _loc3_.decode(_loc5_);
      }
   }
}

