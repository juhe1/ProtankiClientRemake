package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ResourcesLoaded extends AbstractPacket
   {
      public var CallbackID:int;
      
      public function ResourcesLoaded(param1:int = 0)
      {
         super();
         this.CallbackID = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.CallbackID = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ResourcesLoaded();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return -82304134;
      }
   }
}

