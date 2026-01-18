package scpacker.networking.protocol.packets.battlemine
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ExplodeMineInPacket extends AbstractPacket
   {
      public static const id:int = 1387974401;
      
      public var mineId:String;
      
      public var targetId:String;
      
      public function ExplodeMineInPacket(param1:String = "", param2:String = "")
      {
         super();
         this.mineId = param1;
         this.targetId = param2;
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
               this.mineId = param1 as String;
               break;
            case 1:
               this.targetId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ExplodeMineInPacket();
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

