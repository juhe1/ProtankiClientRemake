package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetClientLang extends AbstractPacket
   {
      public var Lang:String;
      
      public function SetClientLang(param1:String = "")
      {
         super();
         this.Lang = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.Lang = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetClientLang();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return -1864333717;
      }
   }
}

