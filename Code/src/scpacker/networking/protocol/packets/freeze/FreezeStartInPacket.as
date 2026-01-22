package scpacker.networking.protocol.packets.freeze
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class FreezeStartInPacket extends AbstractPacket
   {
      public static const id:int = -1171353580;
      
      public var shooter:String;
      
      public function FreezeStartInPacket(param1:String = "")
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
         return new FreezeStartInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 56;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

