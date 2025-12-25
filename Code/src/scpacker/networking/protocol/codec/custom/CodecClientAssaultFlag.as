package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.battle.assault.ClientAssaultFlag;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecClientAssaultFlag implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ClientAssaultFlag;
      
      private var newname_4237__END:ICodec;
      
      private var newname_4238__END:ICodec;
      
      private var newname_4239__END:ICodec;
      
      private var newname_4240__END:ICodec;
      
      public function CodecClientAssaultFlag(param1:ProtocolInitializer)
      {
         super();
         this.newname_4237__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4238__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4239__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4240__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ClientAssaultFlag = new ClientAssaultFlag();
         _loc2_.flagBasePosition = this.newname_4237__END.decode(param1) as Vector3d;
         _loc2_.flagCarrierId = this.newname_4238__END.decode(param1) as String;
         _loc2_.flagPosition = this.newname_4239__END.decode(param1) as Vector3d;
         _loc2_.id = this.newname_4240__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ClientAssaultFlag = ClientAssaultFlag(param2);
         this.newname_4237__END.encode(param1,_loc3_.flagBasePosition);
         this.newname_4238__END.encode(param1,_loc3_.flagCarrierId);
         this.newname_4239__END.encode(param1,_loc3_.flagPosition);
         this.newname_4240__END.encode(param1,_loc3_.id);
         return 4;
      }
   }
}

