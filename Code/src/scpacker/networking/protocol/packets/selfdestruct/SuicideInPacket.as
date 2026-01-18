package scpacker.networking.protocol.packets.selfdestruct
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SuicideInPacket extends AbstractPacket
   {
      public static const id:int = 162656882;
      
      public var tankId:String;
      
      public var delay:int;
      
      public function SuicideInPacket(param1:String = "", param2:int = 0)
      {
         super();
         this.tankId = param1;
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
               this.tankId = param1 as String;
               break;
            case 1:
               this.delay = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SuicideInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 40;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

