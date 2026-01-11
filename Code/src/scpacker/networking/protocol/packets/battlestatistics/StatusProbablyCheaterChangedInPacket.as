package scpacker.networking.protocol.packets.battlestatistics
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class StatusProbablyCheaterChangedInPacket extends AbstractPacket
   {
      public static const id:int = 446781737;
      
      public var userId:String;
      
      public var suspicious:Boolean;
      
      public function StatusProbablyCheaterChangedInPacket(param1:String = "", param2:Boolean = false)
      {
         super();
         this.userId = param1;
         this.suspicious = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userId = param1 as String;
               break;
            case 1:
               this.suspicious = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StatusProbablyCheaterChangedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 37;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

