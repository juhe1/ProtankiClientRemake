package scpacker.networking.protocol.packets.battlemine
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ActivateMineInPacket extends AbstractPacket
   {
      public static const id:int = -624217047;
      
      public var mineId:String;
      
      public function ActivateMineInPacket(param1:String = "")
      {
         super();
         this.mineId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.mineId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ActivateMineInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 62;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

