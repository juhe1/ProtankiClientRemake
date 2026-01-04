package scpacker.networking.protocol.packets.loginbyhash
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RememberUserHashInPakcet extends AbstractPacket
   {
      public static const id:int = 932564569;
      
      public var userHash:String;
      
      public function RememberUserHashInPakcet(param1:String = "")
      {
         super();
         this.userHash = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userHash = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RememberUserHashInPakcet();
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

