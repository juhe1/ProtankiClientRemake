package scpacker.networking.protocol.packets.statisticsdm
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   
   public class DmStatisticsUserConnectInPacket extends AbstractPacket
   {
      public static const id:int = 862913394;

      public var userId:String;

      public var userInfos:Vector.<UserInfo>;
      
      public function DmStatisticsUserConnectInPacket(param1:String = "", param2:Vector.<UserInfo> = null)
      {
         super();
         this.userId = param1;
         this.userInfos = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserInfo");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userId = param1 as String;
               break;
            case 1:
               this.userInfos = param1 as Vector.<UserInfo>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new DmStatisticsUserConnectInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 48;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

