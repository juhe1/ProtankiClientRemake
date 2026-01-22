package scpacker.networking.protocol.packets.gold
{
   import scpacker.networking.protocol.AbstractPacket;
   import platform.client.fp10.core.resource.types.SoundResource;
   
   public class NotificationBonusInPacket extends AbstractPacket
   {
      public static const id:int = -666893269;
      
      public var reason:String;
      
      public var soundId:SoundResource;
      
      public function NotificationBonusInPacket(param1:String = "", param2:SoundResource = null)
      {
         super();
         this.reason = param1;
         this.soundId = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.reason = param1 as String;
               break;
            case 1:
               this.soundId = param1 as SoundResource;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new NotificationBonusInPacket();
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

