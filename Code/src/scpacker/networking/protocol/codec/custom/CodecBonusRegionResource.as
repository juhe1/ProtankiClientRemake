package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionResource;
   import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBonusRegionResource implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BonusRegionResource;
      
      private var newname_4107__END:ICodec;
      
      private var newname_4108__END:ICodec;
      
      public function CodecBonusRegionResource(param1:ProtocolInitializer)
      {
         super();
         this.newname_4107__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4108__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBonusType");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BonusRegionResource = new BonusRegionResource();
         _loc2_.dropZoneResource = this.newname_4107__END.decode(param1) as ImageResource;
         _loc2_.regionType = this.newname_4108__END.decode(param1) as BonusesType;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BonusRegionResource = BonusRegionResource(param2);
         var _loc4_:int = 0;
         _loc4_ = _loc4_ + this.newname_4107__END.encode(param1,_loc3_.dropZoneResource);
         return _loc4_ + this.newname_4108__END.encode(param1,_loc3_.regionType);
      }
   }
}

