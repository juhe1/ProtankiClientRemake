package scpacker.networking.protocol.packets.loginbyhash
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoginByHashOutPacket extends AbstractPacket
   {
      public static const id:int = -845588810;
      
      public var hash:String;
      
      public function LoginByHashOutPacket(param1:String = "")
      {
         super();
         this.hash = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.hash = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoginByHashOutPacket();
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

