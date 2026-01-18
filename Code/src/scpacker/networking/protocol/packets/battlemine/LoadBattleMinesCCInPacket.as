package scpacker.networking.protocol.packets.battlemine
{
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMineCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadBattleMinesCCInPacket extends AbstractPacket
   {
      public static const id:int = -226978906;
      
      public var cc:BattleMineCC;
      
      public function LoadBattleMinesCCInPacket(param1:BattleMineCC = null)
      {
         super();
         this.cc = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleMineCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.cc = param1 as BattleMineCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadBattleMinesCCInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 62;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

