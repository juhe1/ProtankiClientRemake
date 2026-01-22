package scpacker.networking.protocol.packets.friends
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class OutgoingOnAddingInPacket extends AbstractPacket
   {
      public static const id:int = -1241704092;
      
      public var userId:String;
      
      public function OutgoingOnAddingInPacket(param1:String = "")
      {
         super();
         this.userId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new OutgoingOnAddingInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 13;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

