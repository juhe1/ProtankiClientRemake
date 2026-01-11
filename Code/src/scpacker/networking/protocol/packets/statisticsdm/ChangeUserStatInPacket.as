package scpacker.networking.protocol.packets.statisticsdm
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   
   public class ChangeUserStatInPacket extends AbstractPacket
   {
      public static const id:int = 696140460;

      public var userStats:UserStat;
      
      public function ChangeUserStatInPacket(param1:UserStat = null)
      {
         super();
         this.userStats = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserStat");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userStats = param1 as UserStat;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ChangeUserStatInPacket();
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

