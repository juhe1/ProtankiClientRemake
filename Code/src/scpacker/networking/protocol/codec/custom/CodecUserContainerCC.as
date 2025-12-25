package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.users.model.friends.container.UserContainerCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecUserContainerCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserContainerCC;
      
      private var newname_4351__END:ICodec;
      
      public function CodecUserContainerCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4351__END = param1.getCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:UserContainerCC = new UserContainerCC();
         _loc2_.users = this.newname_4351__END.decode(param1) as Vector.<String>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UserContainerCC = UserContainerCC(param2);
         this.newname_4351__END.encode(param1,_loc3_.users);
         return 4;
      }
   }
}

