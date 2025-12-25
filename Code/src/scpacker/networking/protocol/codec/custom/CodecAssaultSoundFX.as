package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.assault.AssaultSoundFX;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.SoundResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecAssaultSoundFX implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = AssaultSoundFX;
      
      private var newname_4185__END:ICodec;
      
      private var newname_4187__END:ICodec;
      
      private var newname_4189__END:ICodec;
      
      private var newname_4191__END:ICodec;
      
      public function CodecAssaultSoundFX(param1:ProtocolInitializer)
      {
         super();
         this.newname_4185__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4187__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4189__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4191__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:AssaultSoundFX = new AssaultSoundFX();
         _loc2_.flagDropSound = this.newname_4185__END.decode(param1) as SoundResource;
         _loc2_.flagReturnSound = this.newname_4187__END.decode(param1) as SoundResource;
         _loc2_.flagTakeSound = this.newname_4189__END.decode(param1) as SoundResource;
         _loc2_.winSound = this.newname_4191__END.decode(param1) as SoundResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:AssaultSoundFX = AssaultSoundFX(param2);
         this.newname_4185__END.encode(param1,_loc3_.flagDropSound);
         this.newname_4187__END.encode(param1,_loc3_.flagReturnSound);
         this.newname_4189__END.encode(param1,_loc3_.flagTakeSound);
         this.newname_4191__END.encode(param1,_loc3_.winSound);
         return 4;
      }
   }
}

