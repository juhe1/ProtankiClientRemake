package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.assault.AssaultSoundFX;
   import projects.tanks.client.battlefield.models.battle.assault.AssaultCC;
   import projects.tanks.client.battlefield.models.battle.assault.AssaultBase;
   import projects.tanks.client.battlefield.models.battle.assault.newname_1852__END;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.battlefield.models.battle.assault.ClientAssaultFlag;
   
   public class CodecAssaultCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = AssaultCC;
      
      private var newname_4567__END:ICodec;
      
      private var newname_4568__END:ICodec;
      
      private var newname_4569__END:ICodec;
      
      private var newname_4570__END:ICodec;
      
      private var newname_4571__END:ICodec;
      
      private var newname_4572__END:ICodec;
      
      private var newname_4573__END:ICodec;
      
      private var newname_4206__END:ICodec;
      
      public function CodecAssaultCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4567__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecClientAssaultFlag");
         this.newname_4568__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4569__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4570__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4571__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4572__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4573__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecAssaultBase");
         this.newname_4206__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecAssaultSoundFX");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:AssaultCC = new AssaultCC();
         _loc2_.blueFlags = this.newname_4567__END.decode(param1) as Vector.<ClientAssaultFlag>;
         _loc2_.flagPedestalModel = this.newname_4569__END.decode(param1) as Tanks3DSResource;
         _loc2_.flagSprite = this.newname_4570__END.decode(param1) as ImageResource;
         _loc2_.pointCircleTexture = this.newname_4571__END.decode(param1) as ImageResource;
         _loc2_.pointPedestalModel = this.newname_4572__END.decode(param1) as Tanks3DSResource;
         _loc2_.redBases = this.newname_4573__END.decode(param1) as Vector.<AssaultBase>;
         _loc2_.sounds = this.newname_4206__END.decode(param1) as AssaultSoundFX;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:AssaultCC = AssaultCC(param2);
         this.newname_4567__END.encode(param1,_loc3_.blueFlags);
         this.newname_4568__END.encode(param1,_loc3_.flagModel);
         this.newname_4569__END.encode(param1,_loc3_.flagPedestalModel);
         this.newname_4570__END.encode(param1,_loc3_.flagSprite);
         this.newname_4571__END.encode(param1,_loc3_.pointCircleTexture);
         this.newname_4572__END.encode(param1,_loc3_.pointPedestalModel);
         this.newname_4573__END.encode(param1,_loc3_.redBases);
         this.newname_4206__END.encode(param1,_loc3_.sounds);
         return 4;
      }
   }
}

