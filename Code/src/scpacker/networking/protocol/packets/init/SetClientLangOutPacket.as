package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetClientLangOutPacket extends AbstractPacket
   {
      public static const id:int = -1864333717;
      
      public var lang:String;
      
      public function SetClientLangOutPacket(param1:String = "")
      {
         super();
         this.lang = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.lang = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetClientLangOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

