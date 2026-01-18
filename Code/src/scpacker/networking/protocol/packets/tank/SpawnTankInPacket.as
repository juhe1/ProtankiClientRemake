package scpacker.networking.protocol.packets.tank
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SpawnTankInPacket extends AbstractPacket
   {
      public static const id:int = 875259457;

      public var tankId:String;
      
      public var team:BattleTeam;
      
      public var position:Vector3d;
      
      public var orientation:Vector3d;
      
      public var health:int;
      
      public var incarnationId:int;
      
      public function SpawnTankInPacket(param1:String = "", param2:BattleTeam = null, param3:Vector3d = null, param4:Vector3d = null, param5:int = 0, param6:int = 0)
      {
         super();
         this.tankId = param1;
         this.team = param2;
         this.position = param3;
         this.orientation = param4;
         this.health = param5;
         this.incarnationId = param6;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param6);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.team = param1 as BattleTeam;
               break;
            case 2:
               this.position = param1 as Vector3d;
               break;
            case 3:
               this.orientation = param1 as Vector3d;
               break;
            case 4:
               this.health = param1 as int;
               break;
            case 5:
               this.incarnationId = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SpawnTankInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 39;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

