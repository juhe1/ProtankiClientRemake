package scpacker.networking.protocol.packets.panel
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetDoubleCrystalStateInPacket extends AbstractPacket
   {
      public static const id:int = 150222118;
      
      public var enabled:Boolean;
      
      public function SetDoubleCrystalStateInPacket(param1:Boolean = false)
      {
         super();
         this.enabled = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.enabled = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetDoubleCrystalStateInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 10;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
