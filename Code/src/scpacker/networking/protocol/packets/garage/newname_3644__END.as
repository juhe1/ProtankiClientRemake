package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3644__END extends AbstractPacket
   {
      public var BattleID:String;
      
      public function newname_3644__END(param1:String = "")
      {
         super();
         this.BattleID = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.BattleID = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3644__END();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return 1091756732;
      }
   }
}

