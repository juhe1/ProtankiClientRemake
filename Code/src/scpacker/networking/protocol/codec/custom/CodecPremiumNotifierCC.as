package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecPremiumNotifierCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = PremiumNotifierCC;
      
      private var newname_4216__END:ICodec;
      
      public function CodecPremiumNotifierCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4216__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:PremiumNotifierCC = new PremiumNotifierCC();
         _loc2_.lifeTimeInSeconds = this.newname_4216__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:PremiumNotifierCC = PremiumNotifierCC(param2);
         this.newname_4216__END.encode(param1,_loc3_.lifeTimeInSeconds);
         return 4;
      }
   }
}

