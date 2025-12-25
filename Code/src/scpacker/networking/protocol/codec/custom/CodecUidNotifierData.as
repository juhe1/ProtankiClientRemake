package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierData;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecUidNotifierData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UidNotifierData;
      
      private var newname_4321__END:ICodec;
      
      private var newname_4098__END:ICodec;
      
      public function CodecUidNotifierData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4321__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4098__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:UidNotifierData = new UidNotifierData();
         _loc2_.uid = this.newname_4321__END.decode(param1) as String;
         _loc2_.userId = this.newname_4098__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UidNotifierData = UidNotifierData(param2);
         this.newname_4321__END.encode(param1,_loc3_.uid);
         this.newname_4098__END.encode(param1,_loc3_.userId);
         return 4;
      }
   }
}

