package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.chat.types.ChatMessage;
   import projects.tanks.client.chat.types.UserStatus;
   
   public class CodecChatMessage implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ChatMessage;
      
      private var newname_4165__END:ICodec;
      
      private var newname_4166__END:ICodec;
      
      private var newname_4167__END:ICodec;
      
      private var newname_4168__END:ICodec;
      
      private var newname_4169__END:ICodec;
      
      public function CodecChatMessage(param1:ProtocolInitializer)
      {
         super();
         this.newname_4165__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecUserStatus");
         this.newname_4166__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4167__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecUserStatus");
         this.newname_4168__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4169__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ChatMessage = new ChatMessage();
         _loc2_.sourceUserStatus = this.newname_4165__END.decode(param1) as UserStatus;
         _loc2_.system = this.newname_4166__END.decode(param1) as Boolean;
         _loc2_.targetUserStatus = this.newname_4167__END.decode(param1) as UserStatus;
         _loc2_.text = this.newname_4168__END.decode(param1) as String;
         _loc2_.warning = this.newname_4169__END.decode(param1) as Boolean;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ChatMessage = ChatMessage(param2);
         this.newname_4165__END.encode(param1,_loc3_.sourceUserStatus);
         this.newname_4166__END.encode(param1,_loc3_.system);
         this.newname_4167__END.encode(param1,_loc3_.targetUserStatus);
         this.newname_4168__END.encode(param1,_loc3_.text);
         this.newname_4169__END.encode(param1,_loc3_.warning);
         return 4;
      }
   }
}

