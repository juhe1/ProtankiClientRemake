package scpacker.networking.protocol.packets.gold
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class GoldTakenInPacket extends AbstractPacket
   {
      public static const id:int = 463494974;
      
      public var username:String;
      
      public function GoldTakenInPacket(param1:String = "")
      {
         super();
         this.username = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.username = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new GoldTakenInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 65;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

