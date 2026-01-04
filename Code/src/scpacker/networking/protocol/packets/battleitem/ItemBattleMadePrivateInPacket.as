package scpacker.networking.protocol.packets.battleitem
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ItemBattleMadePrivateInPacket extends AbstractPacket
   {
      public static const id:int = 1149131596;
      
      public var battleId:String;
      
      public function ItemBattleMadePrivateInPacket(param1:String = "")
      {
         super();
         this.battleId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ItemBattleMadePrivateInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 32;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
