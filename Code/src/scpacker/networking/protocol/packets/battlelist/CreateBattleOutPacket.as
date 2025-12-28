package scpacker.networking.protocol.packets.battlelist
{
   import projects.tanks.client.battleservice.newname_4109__END;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CreateBattleOutPacket extends AbstractPacket
   {
      public var newname_8012__END:newname_4109__END;
      
      public function CreateBattleOutPacket(param1:newname_4109__END = null)
      {
         super();
         this.newname_8012__END = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.Codecc6b8c37");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newname_8012__END = param1 as newname_4109__END;
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

