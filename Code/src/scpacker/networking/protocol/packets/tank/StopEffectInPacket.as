package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class StopEffectInPacket extends AbstractPacket
   {
      public static const id:int = -1994318624;

      public var tankId:String;
      
      public var effectId:int;
      
      public function StopEffectInPacket(param1:String = "", param2:int = 0)
      {
         super();
         this.tankId = param1;
         this.effectId = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.effectId = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StopEffectInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 39;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

