package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.socialnetwork.SocialNetworkPanelParams;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecSocialNetworkPanelParams implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = SocialNetworkPanelParams;
      
      private var newname_4176__END:ICodec;
      
      private var newname_4177__END:ICodec;
      
      private var newname_4178__END:ICodec;
      
      public function CodecSocialNetworkPanelParams(param1:ProtocolInitializer)
      {
         super();
         this.newname_4176__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4177__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4178__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:SocialNetworkPanelParams = new SocialNetworkPanelParams();
         _loc2_.authorizationUrl = this.newname_4176__END.decode(param1) as String;
         _loc2_.linkExists = this.newname_4177__END.decode(param1) as Boolean;
         _loc2_.snId = this.newname_4178__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:SocialNetworkPanelParams = SocialNetworkPanelParams(param2);
         this.newname_4176__END.encode(param1,_loc3_.authorizationUrl);
         this.newname_4177__END.encode(param1,_loc3_.linkExists);
         this.newname_4178__END.encode(param1,_loc3_.snId);
         return 4;
      }
   }
}

