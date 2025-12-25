package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.cp.ClientPointData;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointsCC;
   import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;
   import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecControlPointsCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ControlPointsCC;
      
      private var newname_4433__END:ICodec;
      
      private var newname_4434__END:ICodec;
      
      private var newname_4435__END:ICodec;
      
      private var newname_4436__END:ICodec;
      
      private var newname_4437__END:ICodec;
      
      private var newname_4206__END:ICodec;
      
      public function CodecControlPointsCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4433__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4434__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4435__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4436__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecClientPointData");
         this.newname_4437__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecDominationResources");
         this.newname_4206__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecDominationSounds");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ControlPointsCC = new ControlPointsCC();
         _loc2_.keypointTriggerRadius = this.newname_4433__END.decode(param1) as Number;
         _loc2_.keypointVisorHeight = this.newname_4434__END.decode(param1) as Number;
         _loc2_.minesRestrictionRadius = this.newname_4435__END.decode(param1) as Number;
         _loc2_.points = this.newname_4436__END.decode(param1) as Vector.<ClientPointData>;
         _loc2_.resources = this.newname_4437__END.decode(param1) as DominationResources;
         _loc2_.sounds = this.newname_4206__END.decode(param1) as DominationSounds;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ControlPointsCC = ControlPointsCC(param2);
         this.newname_4433__END.encode(param1,_loc3_.keypointTriggerRadius);
         this.newname_4434__END.encode(param1,_loc3_.keypointVisorHeight);
         this.newname_4435__END.encode(param1,_loc3_.minesRestrictionRadius);
         this.newname_4436__END.encode(param1,_loc3_.points);
         this.newname_4437__END.encode(param1,_loc3_.resources);
         this.newname_4206__END.encode(param1,_loc3_.sounds);
         return 4;
      }
   }
}

