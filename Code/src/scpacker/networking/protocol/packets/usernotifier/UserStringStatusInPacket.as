package scpacker.networking.protocol.packets.usernotifier
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UserStringStatusInPacket extends AbstractPacket
   {
      public static const id:int = -1353047954;
      
      public var userInfo:String;
      
      public function UserStringStatusInPacket(param1:String = "")
      {
         super();
         this.userInfo = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userInfo = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UserStringStatusInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 18;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
