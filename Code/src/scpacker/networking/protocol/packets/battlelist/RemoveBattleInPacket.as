package scpacker.networking.protocol.packets.battlelist
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RemoveBattleInPacket extends AbstractPacket
   {
      public static const id:int = -1848001147;
      
      public var battleId:String;
      
      public function RemoveBattleInPacket(param1:String = "")
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
         return new RemoveBattleInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 31;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
