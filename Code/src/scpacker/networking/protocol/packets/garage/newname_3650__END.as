package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3650__END extends AbstractPacket
   {
      public var newname_6579__END:String;
      
      public var newname_6509__END:String;
      
      public var Reason:String;
      
      public var Base_cost:int;
      
      public function newname_3650__END(param1:String = "", param2:String = "", param3:String = "", param4:int = 0)
      {
         super();
         this.newname_6579__END = param1;
         this.newname_6509__END = param2;
         this.Reason = param3;
         this.Base_cost = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newname_6579__END = param1 as String;
               break;
            case 1:
               this.newname_6509__END = param1 as String;
               break;
            case 2:
               this.Reason = param1 as String;
               break;
            case 3:
               this.Base_cost = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3650__END();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -1518850075;
      }
   }
}

