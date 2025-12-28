package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadResourcesInPacket extends AbstractPacket
   {
      public static const id:int = -1797047325;
      
      public var resourcesJson:String;
      
      public var callbackId:int;
      
      public function LoadResourcesInPacket(param1:String = "", param2:int = 0)
      {
         super();
         this.resourcesJson = param1;
         this.callbackId = param2;
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
               this.resourcesJson = param1 as String;
               break;
            case 1:
               this.callbackId = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadResourcesInPacket();
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
