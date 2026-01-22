package scpacker.networking.protocol.packets.machinegun
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class MachineGunStopFireInPacket extends AbstractPacket
   {
      public static const id:int = 133452238;
      
      public var shooter:String;
      
      public function MachineGunStopFireInPacket(param1:String = "")
      {
         super();
         this.shooter = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new MachineGunStopFireInPacket();
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

