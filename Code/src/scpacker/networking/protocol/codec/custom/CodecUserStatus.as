package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.OptionalCodec;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.chat.types.UserStatus;
   
   public class CodecUserStatus extends OptionalCodec implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserStatus;
      
      private var newname_4327__END:ICodec;
      
      private var newname_4464__END:ICodec;
      
      private var newname_4465__END:ICodec;
      
      private var newname_4321__END:ICodec;
      
      private var newname_4098__END:ICodec;
      
      public function CodecUserStatus(param1:ProtocolInitializer)
      {
         super();
         this.newname_4327__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecChatModeratorLevel");
         this.newname_4464__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4465__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4321__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4098__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         if(getBool(param1))
         {
            return null;
         }
         var _loc2_:UserStatus = new UserStatus();
         _loc2_.chatModeratorLevel = this.newname_4327__END.decode(param1) as ChatModeratorLevel;
         _loc2_.ip = this.newname_4464__END.decode(param1) as String;
         _loc2_.rankIndex = this.newname_4465__END.decode(param1) as int;
         var _loc3_:* = this.newname_4321__END.decode(param1) as String;
         _loc2_.uid = _loc3_;
         _loc2_.userId = _loc3_;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UserStatus = UserStatus(param2);
         this.newname_4327__END.encode(param1,_loc3_.chatModeratorLevel);
         this.newname_4464__END.encode(param1,_loc3_.ip);
         this.newname_4465__END.encode(param1,_loc3_.rankIndex);
         this.newname_4321__END.encode(param1,_loc3_.uid);
         this.newname_4098__END.encode(param1,_loc3_.userId);
         return 4;
      }
   }
}

