package scpacker.networking.protocol.packets.userproperties
{
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ChangeCrystalCountInPacket extends AbstractPacket
   {
      public static const id:int = -593513288;
      
      public var crystalCount:int;
      
      public function ChangeCrystalCountInPacket(param1:int = 0)
      {
         super();
         this.crystalCount = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.crystalCount = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ChangeCrystalCountInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 29;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
