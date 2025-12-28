package scpacker.networking.protocol.packets.login
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoginSuccessInPacket extends AbstractPacket
   {
      public static const id:int = -1923286328;
      
      public function LoginSuccessInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoginSuccessInPacket();
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

