package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.garage.GarageItemInfo;
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.impl.GameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecGarageItemInfo implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = GarageItemInfo;
      
      private var newname_4246__END:ICodec;
      
      private var newname_4247__END:ICodec;
      
      private var newname_4248__END:ICodec;
      
      private var newname_4249__END:ICodec;
      
      private var newname_4250__END:ICodec;
      
      private var newname_4117__END:ICodec;
      
      private var newname_4241__END:ICodec;
      
      private var newname_4251__END:ICodec;
      
      private var newname_4252__END:ICodec;
      
      private var newname_4253__END:ICodec;
      
      public function CodecGarageItemInfo(param1:ProtocolInitializer)
      {
         super();
         this.newname_4246__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecItemCategoryEnum");
         this.newname_4248__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecItemViewCategoryEnum");
         this.newname_4249__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4250__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4117__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4241__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4251__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4252__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4253__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:GarageItemInfo = new GarageItemInfo();
         _loc2_.category = this.newname_4246__END.decode(param1) as ItemCategoryEnum;
         _loc2_.itemViewCategory = this.newname_4248__END.decode(param1) as ItemViewCategoryEnum;
         _loc2_.modificationIndex = this.newname_4249__END.decode(param1) as int;
         _loc2_.mounted = this.newname_4250__END.decode(param1) as Boolean;
         _loc2_.name = this.newname_4117__END.decode(param1) as String;
         _loc2_.position = this.newname_4241__END.decode(param1) as int;
         _loc2_.premiumItem = this.newname_4251__END.decode(param1) as Boolean;
         _loc2_.preview = this.newname_4252__END.decode(param1) as ImageResource;
         _loc2_.remainingTimeInMS = this.newname_4253__END.decode(param1) as int;
         var _loc3_:* = _loc2_.preview;
         _loc2_.item = new GameObject(_loc3_.resourceInfo.id,null,String(this.newname_4117__END.decode(param1)),SpaceRegistry(OSGi.getInstance().getService(SpaceRegistry)).getSpace(Long.getLong(884380667,214)));
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:GarageItemInfo = GarageItemInfo(param2);
         this.newname_4246__END.encode(param1,_loc3_.category);
         this.newname_4247__END.encode(param1,_loc3_.item);
         this.newname_4248__END.encode(param1,_loc3_.itemViewCategory);
         this.newname_4249__END.encode(param1,_loc3_.modificationIndex);
         this.newname_4250__END.encode(param1,_loc3_.mounted);
         this.newname_4117__END.encode(param1,_loc3_.name);
         this.newname_4241__END.encode(param1,_loc3_.position);
         this.newname_4251__END.encode(param1,_loc3_.premiumItem);
         this.newname_4252__END.encode(param1,_loc3_.preview);
         this.newname_4253__END.encode(param1,_loc3_.remainingTimeInMS);
         return 4;
      }
   }
}

