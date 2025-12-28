package scpacker.networking.protocol.packets.login
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoginFailedInPacket extends AbstractPacket
   {
      public static const id:int = 103812952;
      
      public function LoginFailedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoginFailedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 0;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

