package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class KillTankInPacket extends AbstractPacket
   {
      public static const id:int = -42520728;

      public var tankId:String;
      
      public var killer:String;
      
      public var delay:int;
      
      public function KillTankInPacket(param1:String = "", param2:String = "", param3:int = 0)
      {
         super();
         this.tankId = param1;
         this.killer = param2;
         this.delay = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.killer = param1 as String;
               break;
            case 2:
               this.delay = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new KillTankInPacket();
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

