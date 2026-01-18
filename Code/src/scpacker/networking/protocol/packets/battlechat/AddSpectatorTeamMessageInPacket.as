package scpacker.networking.protocol.packets.battlechat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class AddSpectatorTeamMessageInPacket extends AbstractPacket
   {
      public static const id:int = 1532749363;
      
      public var username:String;
      
      public var message:String;
      
      public function AddSpectatorTeamMessageInPacket(param1:String = "", param2:String = "")
      {
         super();
         this.username = param1;
         this.message = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.username = param1 as String;
               break;
            case 1:
               this.message = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new AddSpectatorTeamMessageInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 61;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

