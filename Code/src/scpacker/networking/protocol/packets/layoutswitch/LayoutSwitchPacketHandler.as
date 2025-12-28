package scpacker.networking.protocol.packets.layoutswitch
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import projects.tanks.clients.flash.commons.models.layout.notify.LobbyLayoutNotifyModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.commons.models.layout.notify.LobbyLayoutNotifyModelBase;
   import scpacker.networking.protocol.packets.layoutswitch.BeginLayoutSwitchInPacket;
   import scpacker.networking.protocol.packets.layoutswitch.EndLayoutSwitchInPacket;
   
   public class LayoutSwitchPacketHandler extends AbstractPacketHandler
   {
      private var lobbyLayoutNotifyModel:LobbyLayoutNotifyModel;
      
      public function LayoutSwitchPacketHandler()
      {
         super();
         this.id = 12;
         this.lobbyLayoutNotifyModel = LobbyLayoutNotifyModel(modelRegistry.getModel(LobbyLayoutNotifyModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case BeginLayoutSwitchInPacket.id:
               this.handleBeginLayoutSwitch(param1 as BeginLayoutSwitchInPacket);
               break;
            case EndLayoutSwitchInPacket.id:
               this.handleEndLayoutSwitch(param1 as EndLayoutSwitchInPacket);
         }
      }
      
      private function handleBeginLayoutSwitch(param1:BeginLayoutSwitchInPacket) : void
      {
         this.lobbyLayoutNotifyModel.beginLayoutSwitch(param1.currentState);
      }
      
      private function handleEndLayoutSwitch(param1:EndLayoutSwitchInPacket) : void
      {
         this.lobbyLayoutNotifyModel.endLayoutSwitch(param1.origin,param1.currentState);
      }
   }
}

