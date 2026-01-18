package scpacker.networking.protocol.packets.battlemine
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RemoveMinesInPacket extends AbstractPacket
   {
      public static const id:int = -1200619383;
      
      public var ownerId:String;
      
      public function RemoveMinesInPacket(param1:String = "")
      {
         super();
         this.ownerId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.ownerId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RemoveMinesInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 62;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

