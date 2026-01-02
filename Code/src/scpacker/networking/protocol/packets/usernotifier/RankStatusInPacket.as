package scpacker.networking.protocol.packets.usernotifier
{
   import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RankStatusInPacket extends AbstractPacket
   {
      public static const id:int = -962759489;
      
      public var userInfo:RankNotifierData;
      
      public function RankStatusInPacket(param1:RankNotifierData = null)
      {
         super();
         this.userInfo = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecRankNotifierData");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userInfo = param1 as RankNotifierData;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RankStatusInPacket();
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
