package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.SoundResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecDominationSounds implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = DominationSounds;
      
      private var newname_4528__END:ICodec;
      
      private var newname_4529__END:ICodec;
      
      private var newname_4530__END:ICodec;
      
      private var newname_4531__END:ICodec;
      
      private var newname_4532__END:ICodec;
      
      private var newname_4533__END:ICodec;
      
      private var newname_4534__END:ICodec;
      
      private var newname_4535__END:ICodec;
      
      private var newname_4536__END:ICodec;
      
      private var newname_4537__END:ICodec;
      
      public function CodecDominationSounds(param1:ProtocolInitializer)
      {
         super();
         this.newname_4528__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4529__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4530__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4531__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4532__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4533__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4534__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4535__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4536__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4537__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:DominationSounds = new DominationSounds();
         _loc2_.pointCaptureStartNegativeSound = this.newname_4528__END.decode(param1) as SoundResource;
         _loc2_.pointCaptureStartPositiveSound = this.newname_4529__END.decode(param1) as SoundResource;
         _loc2_.pointCaptureStopNegativeSound = this.newname_4530__END.decode(param1) as SoundResource;
         _loc2_.pointCaptureStopPositiveSound = this.newname_4531__END.decode(param1) as SoundResource;
         _loc2_.pointCapturedNegativeSound = this.newname_4532__END.decode(param1) as SoundResource;
         _loc2_.pointCapturedPositiveSound = this.newname_4533__END.decode(param1) as SoundResource;
         _loc2_.pointNeutralizedNegativeSound = this.newname_4534__END.decode(param1) as SoundResource;
         _loc2_.pointNeutralizedPositiveSound = this.newname_4535__END.decode(param1) as SoundResource;
         _loc2_.pointScoreDecreasingSound = this.newname_4536__END.decode(param1) as SoundResource;
         _loc2_.pointScoreIncreasingSound = this.newname_4537__END.decode(param1) as SoundResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:DominationSounds = DominationSounds(param2);
         this.newname_4528__END.encode(param1,_loc3_.pointCaptureStartNegativeSound);
         this.newname_4529__END.encode(param1,_loc3_.pointCaptureStartPositiveSound);
         this.newname_4530__END.encode(param1,_loc3_.pointCaptureStopNegativeSound);
         this.newname_4531__END.encode(param1,_loc3_.pointCaptureStopPositiveSound);
         this.newname_4532__END.encode(param1,_loc3_.pointCapturedNegativeSound);
         this.newname_4533__END.encode(param1,_loc3_.pointCapturedPositiveSound);
         this.newname_4534__END.encode(param1,_loc3_.pointNeutralizedNegativeSound);
         this.newname_4535__END.encode(param1,_loc3_.pointNeutralizedPositiveSound);
         this.newname_4536__END.encode(param1,_loc3_.pointScoreDecreasingSound);
         this.newname_4537__END.encode(param1,_loc3_.pointScoreIncreasingSound);
         return 4;
      }
   }
}

