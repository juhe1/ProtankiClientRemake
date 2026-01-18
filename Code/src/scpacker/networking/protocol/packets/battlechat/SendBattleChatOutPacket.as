package scpacker.networking.protocol.packets.battlechat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SendBattleChatOutPacket extends AbstractPacket
   {
      public static const id:int = 945463181;
      
      public var message:String;
      
      public var teamOnly:Boolean;
      
      public function SendBattleChatOutPacket(param1:String = "", param2:Boolean = false)
      {
         super();
         this.message = param1;
         this.teamOnly = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.message = param1 as String;
               break;
            case 1:
               this.teamOnly = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SendBattleChatOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 61;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
