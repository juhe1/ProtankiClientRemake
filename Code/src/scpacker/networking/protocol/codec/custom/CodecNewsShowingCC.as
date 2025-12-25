package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.chat.models.news.showing.NewsShowingCC;
   import flash.utils.ByteArray;
   import projects.tanks.client.panel.model.news.item.NewsItemCC;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecNewsShowingCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = NewsShowingCC;
      
      private var newname_4266__END:ICodec;
      
      public function CodecNewsShowingCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4266__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecNewsItemCC");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:NewsShowingCC = new NewsShowingCC();
         _loc2_.newsItems = this.newname_4266__END.decode(param1) as Vector.<NewsItemCC>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:NewsShowingCC = NewsShowingCC(param2);
         this.newname_4266__END.encode(param1,_loc3_.newsItems);
         return 4;
      }
   }
}

