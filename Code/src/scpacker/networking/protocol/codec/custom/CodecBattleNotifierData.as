package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleNotifierData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleNotifierData;
      
      private var newname_4097__END:ICodec;
      
      private var stringCodec:ICodec;
      
      public function CodecBattleNotifierData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4097__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBattleInfoData");
         this.stringCodec = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleNotifierData = new BattleNotifierData();
         _loc2_.battleData = this.newname_4097__END.decode(param1) as BattleInfoData;
         _loc2_.UserId = this.stringCodec.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleNotifierData = BattleNotifierData(param2);
         this.newname_4097__END.encode(param1,_loc3_.battleData);
         this.stringCodec.encode(param1,_loc3_.UserId);
         return 4;
      }
   }
}

