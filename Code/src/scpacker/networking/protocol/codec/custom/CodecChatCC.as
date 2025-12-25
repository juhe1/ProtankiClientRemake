package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   import projects.tanks.client.chat.models.chat.chat.ChatCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecChatCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ChatCC;
      
      private var newname_4323__END:ICodec;
      
      private var newname_4324__END:ICodec;
      
      private var newname_4325__END:ICodec;
      
      private var newname_4326__END:ICodec;
      
      private var newname_4327__END:ICodec;
      
      private var newname_4328__END:ICodec;
      
      private var newname_4329__END:ICodec;
      
      private var newname_4330__END:ICodec;
      
      private var newname_4331__END:ICodec;
      
      private var newname_4332__END:ICodec;
      
      private var newname_4333__END:ICodec;
      
      private var newname_4334__END:ICodec;
      
      public function CodecChatCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4323__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4324__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4325__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4326__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4327__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecChatModeratorLevel");
         this.newname_4328__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4329__END = param1.getCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
         this.newname_4330__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4331__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         this.newname_4332__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4333__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4334__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ChatCC = new ChatCC();
         _loc2_.admin = this.newname_4323__END.decode(param1) as Boolean;
         _loc2_.antifloodEnabled = this.newname_4324__END.decode(param1) as Boolean;
         _loc2_.bufferSize = this.newname_4325__END.decode(param1) as int;
         _loc2_.chatEnabled = this.newname_4326__END.decode(param1) as Boolean;
         _loc2_.chatModeratorLevel = this.newname_4327__END.decode(param1) as ChatModeratorLevel;
         _loc2_.linksWhiteList = this.newname_4329__END.decode(param1) as Vector.<String>;
         _loc2_.minChar = this.newname_4330__END.decode(param1) as int;
         _loc2_.minWord = this.newname_4331__END.decode(param1) as int;
         _loc2_.selfName = this.newname_4332__END.decode(param1) as String;
         _loc2_.showLinks = this.newname_4333__END.decode(param1) as Boolean;
         _loc2_.typingSpeedAntifloodEnabled = this.newname_4334__END.decode(param1) as Boolean;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ChatCC = ChatCC(param2);
         this.newname_4323__END.encode(param1,_loc3_.admin);
         this.newname_4324__END.encode(param1,_loc3_.antifloodEnabled);
         this.newname_4325__END.encode(param1,_loc3_.bufferSize);
         this.newname_4326__END.encode(param1,_loc3_.chatEnabled);
         this.newname_4327__END.encode(param1,_loc3_.chatModeratorLevel);
         this.newname_4329__END.encode(param1,_loc3_.linksWhiteList);
         this.newname_4330__END.encode(param1,_loc3_.minChar);
         this.newname_4331__END.encode(param1,_loc3_.minWord);
         this.newname_4332__END.encode(param1,_loc3_.selfName);
         this.newname_4333__END.encode(param1,_loc3_.showLinks);
         this.newname_4334__END.encode(param1,_loc3_.typingSpeedAntifloodEnabled);
         return 4;
      }
   }
}

