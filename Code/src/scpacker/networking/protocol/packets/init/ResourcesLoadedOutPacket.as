package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ResourcesLoadedOutPacket extends AbstractPacket
   {
      public static const id:int = -82304134;
      
      public var callbackID:int;
      
      public function ResourcesLoadedOutPacket(param1:int = 0)
      {
         super();
         this.callbackID = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.callbackID = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ResourcesLoadedOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

