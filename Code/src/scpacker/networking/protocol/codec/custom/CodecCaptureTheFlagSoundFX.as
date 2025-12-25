package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagSoundFX;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.SoundResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecCaptureTheFlagSoundFX implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = CaptureTheFlagSoundFX;
      
      private var newname_4184__END:ICodec;
      
      private var newname_4185__END:ICodec;
      
      private var newname_4186__END:ICodec;
      
      private var newname_4187__END:ICodec;
      
      private var newname_4188__END:ICodec;
      
      private var newname_4189__END:ICodec;
      
      private var newname_4190__END:ICodec;
      
      private var newname_4191__END:ICodec;
      
      public function CodecCaptureTheFlagSoundFX(param1:ProtocolInitializer)
      {
         super();
         this.newname_4184__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4185__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4186__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4187__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4188__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4189__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4190__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4191__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:CaptureTheFlagSoundFX = new CaptureTheFlagSoundFX();
         _loc2_.flagDropSound = this.newname_4185__END.decode(param1) as SoundResource;
         _loc2_.flagReturnSound = this.newname_4187__END.decode(param1) as SoundResource;
         _loc2_.flagTakeSound = this.newname_4189__END.decode(param1) as SoundResource;
         _loc2_.winSound = this.newname_4191__END.decode(param1) as SoundResource;
         return _loc2_;
      }

      public function encode(param1:ByteArray, param2:Object) : int
      {
         throw new Error("Not implemented");
      }
   }
}

