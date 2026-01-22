package scpacker.networking.protocol.packets.bonusregion
{
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionsCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadBonusRegionsModelInPacket extends AbstractPacket
   {
      public static const id:int = -959048700;

      public var cc:BonusRegionsCC;
      
      public function LoadBonusRegionsModelInPacket(param1:BonusRegionsCC = null)
      {
         super();
         this.cc = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBonusRegionsCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.cc = param1 as BonusRegionsCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadBonusRegionsModelInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 78;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

