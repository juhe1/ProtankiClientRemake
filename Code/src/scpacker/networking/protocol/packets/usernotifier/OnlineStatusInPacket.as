package scpacker.networking.protocol.packets.usernotifier
{
   import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class OnlineStatusInPacket extends AbstractPacket
   {
      public static const id:int = 2041598093;
      
      public var userInfo:OnlineNotifierData;
      
      public function OnlineStatusInPacket(param1:OnlineNotifierData = null)
      {
         super();
         this.userInfo = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecOnlineNotifierData");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userInfo = param1 as OnlineNotifierData;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new OnlineStatusInPacket();
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
