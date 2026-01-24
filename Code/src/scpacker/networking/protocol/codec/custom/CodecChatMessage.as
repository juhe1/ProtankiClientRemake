package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.chat.types.ChatMessage;
   import projects.tanks.client.chat.types.UserStatus;
   import projects.tanks.client.chat.types.MessageType;
   
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
         var chatMessage:ChatMessage = new ChatMessage();
         chatMessage.sourceUser = this.newname_4165__END.decode(param1) as UserStatus;
         var system:Boolean = this.newname_4166__END.decode(param1) as Boolean;
         chatMessage.messageType = system ? MessageType.SYSTEM : MessageType.USER;
         chatMessage.targetUser = this.newname_4167__END.decode(param1) as UserStatus;
         chatMessage.text = this.newname_4168__END.decode(param1) as String;
         var warning:Boolean = this.newname_4169__END.decode(param1) as Boolean;
         chatMessage.messageType = warning ? MessageType.WARNING : chatMessage.messageType;
         return chatMessage;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var chatMessage:ChatMessage = ChatMessage(param2);
         this.newname_4165__END.encode(param1,chatMessage.sourceUser);
         this.newname_4166__END.encode(param1,chatMessage.messageType == MessageType.SYSTEM);
         this.newname_4167__END.encode(param1,chatMessage.targetUser);
         this.newname_4168__END.encode(param1,chatMessage.text);
         this.newname_4169__END.encode(param1,chatMessage.messageType == MessageType.WARNING);
         return 4;
      }
   }
}

