package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RenameSuccessfulInPacket extends AbstractPacket
   {
      public static const id:int = -1968445033;
      
      public var newName:String;
      
      public var userId:String;
      
      public function RenameSuccessfulInPacket(param1:String = "", param2:String = "")
      {
         super();
         this.newName = param1;
         this.userId = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newName = param1 as String;
               break;
            case 1:
               this.userId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RenameSuccessfulInPacket();
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
