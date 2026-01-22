package scpacker.networking.protocol.packets.gold
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NotificationBonusContainsUidInPacket extends AbstractPacket
   {
      public static const id:int = 1382076950;
      
      public var reason:String;
      
      public var username:String;
      
      public var uid:String;
      
      public function NotificationBonusContainsUidInPacket(param1:String = "", param2:String = "", param3:String = "")
      {
         super();
         this.reason = param1;
         this.username = param2;
         this.uid = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.reason = param1 as String;
               break;
            case 1:
               this.username = param1 as String;
               break;
            case 2:
               this.uid = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new NotificationBonusContainsUidInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 65;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

