package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMine;
   import projects.tanks.client.battlefield.types.Vector3d;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleMine implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleMine;
      
      private var newname_4258__END:ICodec;
      
      private var newname_4259__END:ICodec;
      
      private var newname_4260__END:ICodec;
      
      private var newname_4241__END:ICodec;
      
      public function CodecBattleMine(param1:ProtocolInitializer)
      {
         super();
         this.newname_4258__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4259__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4260__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4241__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleMine = new BattleMine();
         _loc2_.activated = true;
         _loc2_.mineId = this.newname_4259__END.decode(param1) as String;
         _loc2_.ownerId = this.newname_4260__END.decode(param1) as String;
         _loc2_.position = this.newname_4241__END.decode(param1) as Vector3d;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleMine = BattleMine(param2);
         this.newname_4258__END.encode(param1,_loc3_.activated);
         this.newname_4259__END.encode(param1,_loc3_.mineId);
         this.newname_4260__END.encode(param1,_loc3_.ownerId);
         this.newname_4241__END.encode(param1,_loc3_.position);
         return 4;
      }
   }
}

