package scpacker.networking.protocol.packets.layoutswitch
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.commons.models.layout.LayoutState;
   
   public class BeginLayoutSwitchInPacket extends AbstractPacket
   {
      public static const id:int = 1118835050;
      
      public var currentState:LayoutState;
      
      public function BeginLayoutSwitchInPacket(param1:LayoutState = null)
      {
         super();
         this.currentState = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecLayoutState");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.currentState = param1 as LayoutState;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BeginLayoutSwitchInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 12;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

