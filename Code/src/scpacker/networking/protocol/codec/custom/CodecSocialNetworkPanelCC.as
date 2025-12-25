package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.socialnetwork.SocialNetworkPanelCC;
   import projects.tanks.client.panel.model.socialnetwork.SocialNetworkPanelParams;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecSocialNetworkPanelCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = SocialNetworkPanelCC;
      
      private var newname_4340__END:ICodec;
      
      private var newname_4341__END:ICodec;
      
      public function CodecSocialNetworkPanelCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4340__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4341__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecSocialNetworkPanelParams");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:SocialNetworkPanelCC = new SocialNetworkPanelCC();
         _loc2_.passwordCreated = this.newname_4340__END.decode(param1) as Boolean;
         _loc2_.socialNetworkParams = this.newname_4341__END.decode(param1) as Vector.<SocialNetworkPanelParams>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:SocialNetworkPanelCC = SocialNetworkPanelCC(param2);
         this.newname_4340__END.encode(param1,_loc3_.passwordCreated);
         this.newname_4341__END.encode(param1,_loc3_.socialNetworkParams);
         return 4;
      }
   }
}

