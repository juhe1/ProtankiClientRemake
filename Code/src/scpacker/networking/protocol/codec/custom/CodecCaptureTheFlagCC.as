package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagSoundFX;
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.battlefield.models.battle.ctf.ClientFlag;
   
   public class CodecCaptureTheFlagCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = CaptureTheFlagCC;
      
      private var newname_4198__END:ICodec;
      
      private var newname_4199__END:ICodec;
      
      private var newname_4200__END:ICodec;
      
      private var newname_4201__END:ICodec;
      
      private var newname_4202__END:ICodec;
      
      private var newname_4203__END:ICodec;
      
      private var newname_4204__END:ICodec;
      
      private var newname_4205__END:ICodec;
      
      private var newname_4206__END:ICodec;
      
      public function CodecCaptureTheFlagCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4198__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecClientFlag");
         this.newname_4199__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4200__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4201__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4202__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecClientFlag");
         this.newname_4203__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4204__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4205__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4206__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecCaptureTheFlagSoundFX");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:CaptureTheFlagCC = new CaptureTheFlagCC();
         _loc2_.blueFlag = this.newname_4198__END.decode(param1) as ClientFlag;
         _loc2_.blueFlagSprite = this.newname_4200__END.decode(param1) as ImageResource;
         _loc2_.bluePedestalModel = this.newname_4201__END.decode(param1) as Tanks3DSResource;
         _loc2_.redFlag = this.newname_4202__END.decode(param1) as ClientFlag;
         _loc2_.redFlagSprite = this.newname_4204__END.decode(param1) as ImageResource;
         _loc2_.redPedestalModel = this.newname_4205__END.decode(param1) as Tanks3DSResource;
         _loc2_.sounds = this.newname_4206__END.decode(param1) as CaptureTheFlagSoundFX;
         return _loc2_;
      }

      public function encode(param1:ByteArray, param2:Object) : int
      {
         throw new Error("Not implemented");
      }
   }
}

