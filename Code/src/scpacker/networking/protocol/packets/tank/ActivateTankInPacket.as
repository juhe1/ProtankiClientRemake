package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ActivateTankInPacket extends AbstractPacket
   {
      public static const id:int = 1868573511;

      public var tankId:String;
      
      public function ActivateTankInPacket(param1:String = "")
      {
         super();
         this.tankId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ActivateTankInPacket();
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

