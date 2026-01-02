package scpacker.networking.protocol.packets.battleInfo
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadBattleInfoInPacket extends AbstractPacket
   {
      public static const id:int = 546722394;
      
      public var battlesJson:String;
      
      public function LoadBattleInfoInPacket(param1:String = "")
      {
         super();
         this.battlesJson = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battlesJson = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadBattleInfoInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 33;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
