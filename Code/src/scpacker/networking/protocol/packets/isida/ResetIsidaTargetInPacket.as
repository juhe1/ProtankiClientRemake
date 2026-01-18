package scpacker.networking.protocol.packets.isida
{
   import scpacker.networking.protocol.AbstractPacket;

   public class ResetIsidaTargetInPacket extends AbstractPacket
   {
      public static const id:int = -1271729363;

      public var shooter:String;

      public function ResetIsidaTargetInPacket(param1:String = "")
      {
         super();
         this.shooter = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }

      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
         }
      }

      override public function initializeSelf() : AbstractPacket
      {
         return new ResetIsidaTargetInPacket();
      }

      override public function getPacketHandlerId() : int
      {
         return 55;
      }

      override public function getId() : int
      {
         return id;
      }
   }
}
