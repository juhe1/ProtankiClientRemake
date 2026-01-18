package scpacker.networking.protocol.packets.tankreloader
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ReloadTankInPacket extends AbstractPacket
   {
      public static const id:int = -1767633906;
      
      public var tank:String;
      
      public function ReloadTankInPacket(param1:String = "")
      {
         super();
         this.tank = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tank = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ReloadTankInPacket();
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

