package scpacker.networking.protocol.packets.usernotifier
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3721__END extends AbstractPacket
   {
      public var UserInfo:String;
      
      public function newname_3721__END(param1:String = "")
      {
         super();
         this.UserInfo = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.UserInfo = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3721__END();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 18;
      }
      
      override public function getId() : int
      {
         return -1353047954;
      }
   }
}

