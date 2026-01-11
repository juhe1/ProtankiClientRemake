package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CollectCryBox extends AbstractPacket
   {
      public var BonusId:String;
      
      public function CollectCryBox(param1:String = "")
      {
         super();
         this.BonusId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.BonusId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CollectCryBox();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 36;
      }
      
      override public function getId() : int
      {
         return -1047185003;
      }
   }
}

