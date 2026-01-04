package scpacker.networking.protocol.packets.loginbyhash
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoginByHashFailedInPacket extends AbstractPacket
   {
      public static const id:int = 655372891;
      
      public function LoginByHashFailedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoginByHashFailedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 1;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

