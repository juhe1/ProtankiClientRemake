package scpacker.networking.protocol.packets.usernotifier
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NotInBattleStatusInPacket extends AbstractPacket
   {
      public static const id:int = 1941694508;
      
      public var userId:String;
      
      public function NotInBattleStatusInPacket(param1:String = "")
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
         return new NotInBattleStatusInPacket();
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
