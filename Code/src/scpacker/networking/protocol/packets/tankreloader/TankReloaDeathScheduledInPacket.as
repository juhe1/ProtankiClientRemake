package scpacker.networking.protocol.packets.tankreloader
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TankReloaDeathScheduledInPacket extends AbstractPacket
   {
      public static const id:int = -911983090;
      
      public var suicideDelayMS:int;
      
      public function TankReloaDeathScheduledInPacket(param1:int = 0)
      {
         super();
         this.suicideDelayMS = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.suicideDelayMS = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TankReloaDeathScheduledInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 59;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

