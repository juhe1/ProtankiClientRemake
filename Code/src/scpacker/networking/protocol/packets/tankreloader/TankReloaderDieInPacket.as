package scpacker.networking.protocol.packets.tankreloader
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TankReloaderDieInPacket extends AbstractPacket
   {
      public static const id:int = -173682854;
      
      public var tank:String;
      
      public var delay:int;
      
      public function TankReloaderDieInPacket(param1:String = "", param2:int = 0)
      {
         super();
         this.tank = param1;
         this.delay = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tank = param1 as String;
               break;
            case 1:
               this.delay = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TankReloaderDieInPacket();
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

