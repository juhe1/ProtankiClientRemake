package scpacker.networking.protocol.packets.usernotifier
{
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class PremiumStatusInPacket extends AbstractPacket
   {
      public static const id:int = -2069508071;
      
      public var premiumData:PremiumNotifierData;
      
      public function PremiumStatusInPacket(param1:PremiumNotifierData = null)
      {
         super();
         this.premiumData = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecPremiumNotifierData");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.premiumData = param1 as PremiumNotifierData;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new PremiumStatusInPacket();
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
