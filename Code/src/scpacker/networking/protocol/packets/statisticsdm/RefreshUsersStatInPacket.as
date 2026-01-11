package scpacker.networking.protocol.packets.statisticsdm
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   
   public class RefreshUsersStatInPacket extends AbstractPacket
   {
      public static const id:int = 1061006142;

      public var userStats:Vector.<UserStat>;
      
      public function RefreshUsersStatInPacket(param1:Vector.<UserStat> = null)
      {
         super();
         this.userStats = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserStat");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userStats = param1 as Vector.<UserStat>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RefreshUsersStatInPacket();
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

