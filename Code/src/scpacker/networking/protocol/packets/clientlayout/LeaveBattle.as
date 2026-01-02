package scpacker.networking.protocol.packets.clientlayout
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.commons.models.layout.LayoutState;
   
   public class LeaveBattle extends AbstractPacket
   {
      public var Layout:LayoutState;
      
      public function LeaveBattle(param1:LayoutState = null)
      {
         super();
         this.Layout = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecLayoutState");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.Layout = param1 as LayoutState;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LeaveBattle();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 17;
      }
      
      override public function getId() : int
      {
         return 377959142;
      }
   }
}

