package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionResource;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionsCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBonusRegionsCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BonusRegionsCC;
      
      private var newname_4354__END:ICodec;
      
      private var newname_4355__END:ICodec;
      
      public function CodecBonusRegionsCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4354__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecBonusRegionResource");
         this.newname_4355__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecBonusRegionData");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BonusRegionsCC = new BonusRegionsCC();
         _loc2_.bonusRegionResources = this.newname_4354__END.decode(param1) as Vector.<BonusRegionResource>;
         _loc2_.bonusRegions = this.newname_4355__END.decode(param1) as Vector.<BonusRegionData>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         throw new Error("");
      }
   }
}

