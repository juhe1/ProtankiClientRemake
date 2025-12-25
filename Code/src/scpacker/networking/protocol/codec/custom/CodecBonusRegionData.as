package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
   import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBonusRegionData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BonusRegionData;
      
      private var newname_4272__END:ICodec;
      
      private var newname_4387__END:ICodec;
      
      private var newname_4108__END:ICodec;
      
      public function CodecBonusRegionData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4272__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4387__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4108__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBonusType");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BonusRegionData = new BonusRegionData();
         _loc2_.position = this.newname_4272__END.decode(param1) as Vector3d;
         _loc2_.rotation = this.newname_4387__END.decode(param1) as Vector3d;
         _loc2_.regionType = this.newname_4108__END.decode(param1) as BonusesType;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BonusRegionData = BonusRegionData(param2);
         var _loc4_:int = 0;
         _loc4_ = _loc4_ + this.newname_4272__END.encode(param1,_loc3_.position);
         _loc4_ = _loc4_ + this.newname_4387__END.encode(param1,_loc3_.rotation);
         return _loc4_ + this.newname_4108__END.encode(param1,_loc3_.regionType);
      }
   }
}

