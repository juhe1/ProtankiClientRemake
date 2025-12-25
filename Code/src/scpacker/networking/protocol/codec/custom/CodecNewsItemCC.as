package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import projects.tanks.client.panel.model.news.item.NewsItemCC;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecNewsItemCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = NewsItemCC;
      
      private var newname_4439__END:ICodec;
      
      private var newname_4440__END:ICodec;
      
      private var newname_4441__END:ICodec;
      
      public function CodecNewsItemCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4439__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4440__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4441__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:NewsItemCC = new NewsItemCC();
         _loc2_.imageUrl = this.newname_4439__END.decode(param1) as String;
         _loc2_.newsDate = this.newname_4440__END.decode(param1) as String;
         _loc2_.newsText = this.newname_4441__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:NewsItemCC = NewsItemCC(param2);
         this.newname_4439__END.encode(param1,_loc3_.imageUrl);
         this.newname_4440__END.encode(param1,_loc3_.newsDate);
         this.newname_4441__END.encode(param1,_loc3_.newsText);
         return 4;
      }
   }
}

