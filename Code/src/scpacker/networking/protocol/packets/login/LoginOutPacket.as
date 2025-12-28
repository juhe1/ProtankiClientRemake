package scpacker.networking.protocol.packets.login
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoginOutPacket extends AbstractPacket
   {
      public static const id:int = -739684591;
      
      public var username:String;
      
      public var password:String;
      
      public var rememberMe:Boolean;
      
      public function LoginOutPacket(param1:String = "", param2:String = "", param3:Boolean = false)
      {
         super();
         this.username = param1;
         this.password = param2;
         this.rememberMe = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.username = param1 as String;
               break;
            case 1:
               this.password = param1 as String;
               break;
            case 2:
               this.rememberMe = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoginOutPacket();
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

