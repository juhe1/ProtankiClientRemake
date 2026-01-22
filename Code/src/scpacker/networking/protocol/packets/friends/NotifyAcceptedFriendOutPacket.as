package scpacker.networking.protocol.packets.friends
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NotifyAcceptedFriendOutPacket extends AbstractPacket
   {
      public static const id:int = 837875576;
      
      public var userId:String;
      
      public function NotifyAcceptedFriendOutPacket(param1:String = "")
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
         return new NotifyAcceptedFriendOutPacket();
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
