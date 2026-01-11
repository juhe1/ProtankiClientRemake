package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RemoveBonusBoxInPacket extends AbstractPacket
   {
      public static const id:int = -2026749922;
      
      public var bonusId:String;
      
      public function RemoveBonusBoxInPacket(param1:String = "")
      {
         super();
         this.bonusId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.bonusId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RemoveBonusBoxInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 36;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

