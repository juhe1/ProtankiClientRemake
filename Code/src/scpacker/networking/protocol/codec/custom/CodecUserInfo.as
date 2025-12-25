package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   import flash.utils.ByteArray;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecUserInfo implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserInfo;
      
      private var newname_4327__END:ICodec;
      
      private var newname_4367__END:ICodec;
      
      private var newname_4274__END:ICodec;
      
      private var newname_4172__END:ICodec;
      
      private var newname_4242__END:ICodec;
      
      private var newname_4321__END:ICodec;
      
      public function CodecUserInfo(param1:ProtocolInitializer)
      {
         super();
         this.newname_4327__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecChatModeratorLevel");
         this.newname_4367__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         this.newname_4274__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         this.newname_4172__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
         this.newname_4242__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4321__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:UserInfo = new UserInfo();
         _loc2_.chatModeratorLevel = this.newname_4327__END.decode(param1) as ChatModeratorLevel;
         _loc2_.deaths = this.newname_4367__END.decode(param1) as int;
         _loc2_.kills = this.newname_4274__END.decode(param1) as int;
         _loc2_.rank = this.newname_4172__END.decode(param1) as int;
         _loc2_.score = this.newname_4242__END.decode(param1) as int;
         _loc2_.uid = this.newname_4321__END.decode(param1) as String;
         _loc2_.user = _loc2_.uid;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UserInfo = UserInfo(param2);
         this.newname_4327__END.encode(param1,_loc3_.chatModeratorLevel);
         this.newname_4367__END.encode(param1,_loc3_.deaths);
         this.newname_4274__END.encode(param1,_loc3_.kills);
         this.newname_4172__END.encode(param1,_loc3_.rank);
         this.newname_4242__END.encode(param1,_loc3_.score);
         this.newname_4321__END.encode(param1,_loc3_.uid);
         return 4;
      }
   }
}

