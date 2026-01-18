package scpacker.networking.protocol.packets.capturetheflag
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class DropFlagInPacket extends AbstractPacket
   {
      public static const id:int = 1925237062;
      
      public var position:Vector3d;
      
      public var flagTeam:BattleTeam;
      
      public function DropFlagInPacket(param1:Vector3d = null, param2:BattleTeam = null)
      {
         super();
         this.position = param1;
         this.flagTeam = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.position = param1 as Vector3d;
               break;
            case 1:
               this.flagTeam = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new DropFlagInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 42;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

