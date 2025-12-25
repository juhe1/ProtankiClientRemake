package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecDominationResources implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = DominationResources;
      
      private var newname_4370__END:ICodec;
      
      private var newname_4371__END:ICodec;
      
      private var newname_4372__END:ICodec;
      
      private var newname_4373__END:ICodec;
      
      private var newname_4374__END:ICodec;
      
      private var newname_4375__END:ICodec;
      
      private var newname_4376__END:ICodec;
      
      private var newname_4377__END:ICodec;
      
      private var newname_4378__END:ICodec;
      
      private var newname_4379__END:ICodec;
      
      private var newname_4380__END:ICodec;
      
      private var newname_4381__END:ICodec;
      
      public function CodecDominationResources(param1:ProtocolInitializer)
      {
         super();
         this.newname_4370__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4371__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4372__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4373__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4374__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4375__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4376__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4377__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4378__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4379__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4380__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4381__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:DominationResources = new DominationResources();
         _loc2_.bigLetters = this.newname_4370__END.decode(param1) as ImageResource;
         _loc2_.blueCircle = this.newname_4371__END.decode(param1) as ImageResource;
         _loc2_.bluePedestalTexture = this.newname_4372__END.decode(param1) as ImageResource;
         _loc2_.blueRay = this.newname_4373__END.decode(param1) as ImageResource;
         _loc2_.blueRayTip = this.newname_4374__END.decode(param1) as ImageResource;
         _loc2_.neutralCircle = this.newname_4375__END.decode(param1) as ImageResource;
         _loc2_.neutralPedestalTexture = this.newname_4376__END.decode(param1) as ImageResource;
         _loc2_.pedestal = this.newname_4377__END.decode(param1) as Tanks3DSResource;
         _loc2_.redCircle = this.newname_4378__END.decode(param1) as ImageResource;
         _loc2_.redPedestalTexture = this.newname_4379__END.decode(param1) as ImageResource;
         _loc2_.redRay = this.newname_4380__END.decode(param1) as ImageResource;
         _loc2_.redRayTip = this.newname_4381__END.decode(param1) as ImageResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:DominationResources = DominationResources(param2);
         this.newname_4370__END.encode(param1,_loc3_.bigLetters);
         this.newname_4371__END.encode(param1,_loc3_.blueCircle);
         this.newname_4372__END.encode(param1,_loc3_.bluePedestalTexture);
         this.newname_4373__END.encode(param1,_loc3_.blueRay);
         this.newname_4374__END.encode(param1,_loc3_.blueRayTip);
         this.newname_4375__END.encode(param1,_loc3_.neutralCircle);
         this.newname_4376__END.encode(param1,_loc3_.neutralPedestalTexture);
         this.newname_4377__END.encode(param1,_loc3_.pedestal);
         this.newname_4378__END.encode(param1,_loc3_.redCircle);
         this.newname_4379__END.encode(param1,_loc3_.redPedestalTexture);
         this.newname_4380__END.encode(param1,_loc3_.redRay);
         this.newname_4381__END.encode(param1,_loc3_.redRayTip);
         return 4;
      }
   }
}

