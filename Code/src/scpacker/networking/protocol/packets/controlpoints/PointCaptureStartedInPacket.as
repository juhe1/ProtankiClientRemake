package scpacker.networking.protocol.packets.controlpoints
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class PointCaptureStartedInPacket extends AbstractPacket
   {
      public static const id:int = -1346883037;
      
      public var team:BattleTeam;
      
      public function PointCaptureStartedInPacket(param1:BattleTeam = null)
      {
         super();
         this.team = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.team = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new PointCaptureStartedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 60;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

