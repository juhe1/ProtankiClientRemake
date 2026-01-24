package scpacker.networking.protocol.packets.chat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CleanUsersMessagesInPacket extends AbstractPacket
   {
      public static const id:int = 1993050216;
      
      public var username:String;
      
      public function CleanUsersMessagesInPacket(param1:String = "")
      {
         super();
         this.username = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.username = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CleanUsersMessagesInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 28;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

