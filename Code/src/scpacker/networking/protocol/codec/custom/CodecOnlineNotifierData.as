package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierData;
   
   public class CodecOnlineNotifierData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = OnlineNotifierData;
      
      private var newname_4360__END:ICodec;
      
      private var newname_4228__END:ICodec;
      
      private var newname_4098__END:ICodec;
      
      public function CodecOnlineNotifierData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4360__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4228__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4098__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:OnlineNotifierData = new OnlineNotifierData();
         _loc2_.online = this.newname_4360__END.decode(param1) as Boolean;
         _loc2_.serverNumber = this.newname_4228__END.decode(param1) as int;
         _loc2_.userId = this.newname_4098__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:OnlineNotifierData = OnlineNotifierData(param2);
         this.newname_4360__END.encode(param1,_loc3_.online);
         this.newname_4228__END.encode(param1,_loc3_.serverNumber);
         this.newname_4098__END.encode(param1,_loc3_.userId);
         return 4;
      }
   }
}

