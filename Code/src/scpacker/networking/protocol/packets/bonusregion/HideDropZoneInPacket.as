package scpacker.networking.protocol.packets.bonusregion
{
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class HideDropZoneInPacket extends AbstractPacket
   {
      public static const id:int = -1524095870;

      public var bonusRegion:BonusRegionData;
      
      public function HideDropZoneInPacket(param1:BonusRegionData = null)
      {
         super();
         this.bonusRegion = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBonusRegionData");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.bonusRegion = param1 as BonusRegionData;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new HideDropZoneInPacket();
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

