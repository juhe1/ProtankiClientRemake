package scpacker.networking.protocol.packets.missions
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SkipQuestForCrystalsOutPacket extends AbstractPacket
   {
      public static const id:int = 1642608662;
      
      public var missionId:int;
      
      public function SkipQuestForCrystalsOutPacket(param1:int = 0)
      {
         super();
         this.missionId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.missionId = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SkipQuestForCrystalsOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 19;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
