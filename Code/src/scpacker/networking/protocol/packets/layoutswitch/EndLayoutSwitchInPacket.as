package scpacker.networking.protocol.packets.layoutswitch
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.commons.models.layout.LayoutState;
   
   public class EndLayoutSwitchInPacket extends AbstractPacket
   {
      public static const id:int = -593368100;
      
      public var origin:LayoutState;
      
      public var currentState:LayoutState;
      
      public function EndLayoutSwitchInPacket(param1:LayoutState = null, param2:LayoutState = null)
      {
         super();
         this.origin = param1;
         this.currentState = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecLayoutState");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecLayoutState");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.origin = param1 as LayoutState;
               break;
            case 1:
               this.currentState = param1 as LayoutState;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new EndLayoutSwitchInPacket();
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

