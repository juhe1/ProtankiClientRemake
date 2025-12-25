package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadResources extends AbstractPacket
   {
      public var BattlesJson:String;
      
      public var CallbackID:int;
      
      public function LoadResources(param1:String = "", param2:int = 0)
      {
         super();
         this.BattlesJson = param1;
         this.CallbackID = param2;
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
               this.BattlesJson = param1 as String;
               break;
            case 1:
               this.CallbackID = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadResources();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return -1797047325;
      }
   }
}

