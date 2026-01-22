package scpacker.networking.protocol.packets.machinegun
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class MachineGunStopFireOutPacket extends AbstractPacket
   {
      public static const id:int = 1794372798;
      
      public var time:int;
      
      public function MachineGunStopFireOutPacket(param1:int = 0)
      {
         super();
         this.time = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.time = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new MachineGunStopFireOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 74;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

