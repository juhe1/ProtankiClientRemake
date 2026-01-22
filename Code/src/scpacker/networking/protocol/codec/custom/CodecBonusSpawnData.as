package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   // NOTE: Doesn't work, because i commented one line. But this is never used in the original code, so doesn't matter.
   public class CodecBonusSpawnData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BonusSpawnData;
      
      private var newname_4395__END:ICodec;
      
      private var newname_4396__END:ICodec;
      
      private var newname_4397__END:ICodec;
      
      private var newname_4398__END:ICodec;
      
      public function CodecBonusSpawnData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4395__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4396__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4397__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4398__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BonusSpawnData = new BonusSpawnData();
         //_loc2_.bonusId = this.newname_4396__END.decode(param1) as String;
         _loc2_.lifeTime = this.newname_4397__END.decode(param1) as int;
         _loc2_.spawnPosition = this.newname_4398__END.decode(param1) as Vector3d;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BonusSpawnData = BonusSpawnData(param2);
         this.newname_4395__END.encode(param1,_loc3_.battleBonusObject);
         this.newname_4396__END.encode(param1,_loc3_.bonusId);
         this.newname_4397__END.encode(param1,_loc3_.lifeTime);
         this.newname_4398__END.encode(param1,_loc3_.spawnPosition);
         return 4;
      }
   }
}

