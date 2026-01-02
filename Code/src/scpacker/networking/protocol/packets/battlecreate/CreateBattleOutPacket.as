package scpacker.networking.protocol.packets.battlecreate
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   
   public class CreateBattleOutPacket extends AbstractPacket
   {
      public var battleCreateParameters:BattleCreateParameters;
      
      public function CreateBattleOutPacket(param1:BattleCreateParameters = null)
      {
         super();
         this.battleCreateParameters = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleCreateParameters");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleCreateParameters = param1 as BattleCreateParameters;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CreateBattleOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 30;
      }
      
      override public function getId() : int
      {
         return -2135234426;
      }
   }
}

