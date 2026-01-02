package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShowGarageCategoryInPacket extends AbstractPacket
   {
      public static const id:int = 1318061480;
      
      public var categoryId:String;
      
      public function ShowGarageCategoryInPacket(param1:String = "")
      {
         super();
         this.categoryId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.categoryId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShowGarageCategoryInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
