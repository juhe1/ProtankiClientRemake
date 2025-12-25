package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.entrance.model.entrance.externalentrance.SocialNetworkEntranceParams;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecSocialNetworkEntranceParams implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = SocialNetworkEntranceParams;
      
      private var newname_4176__END:ICodec;
      
      private var newname_4178__END:ICodec;
      
      public function CodecSocialNetworkEntranceParams(param1:ProtocolInitializer)
      {
         super();
         this.newname_4176__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4178__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:SocialNetworkEntranceParams = new SocialNetworkEntranceParams();
         _loc2_.authorizationUrl = this.newname_4176__END.decode(param1) as String;
         _loc2_.snId = this.newname_4178__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc4_:SocialNetworkEntranceParams = SocialNetworkEntranceParams(param2);
         _loc3_ += this.newname_4176__END.encode(param1,_loc4_.authorizationUrl);
         return _loc3_ + this.newname_4178__END.encode(param1,_loc4_.snId);
      }
   }
}

