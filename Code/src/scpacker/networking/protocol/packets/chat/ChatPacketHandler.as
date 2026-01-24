package scpacker.networking.protocol.packets.chat
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.chat.models.chat.chat.ChatModelBase;
   import alternativa.tanks.model.chat.ChatModel;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.protocol.packets.panel.PanelPacketHandler;
   import platform.client.fp10.core.model.impl.Model;
   import alternativa.tanks.model.CommunicationPanelModel;
   import projects.tanks.client.chat.models.CommunicationPanelModelBase;
   
   public class ChatPacketHandler extends AbstractPacketHandler
   {
      private var chatModel:ChatModel;
      private var communicationPanelModel:CommunicationPanelModel;

      private var chatGameObject:IGameObject;
      
      public function ChatPacketHandler()
      {
         super();
         this.id = 28;
         this.chatModel = ChatModel(modelRegistry.getModel(ChatModelBase.modelId));
         this.communicationPanelModel = CommunicationPanelModel(modelRegistry.getModel(CommunicationPanelModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadChatModelInPacket.id:
               this.load(param1 as LoadChatModelInPacket);
               break;
            case UpdateTypingAntifloodParamsInPacket.id:
               this.updateTypingSpeedAntifloodParams(param1 as UpdateTypingAntifloodParamsInPacket);
               break;
            case ShowMessagesInPacket.id:
               this.showMessages(param1 as ShowMessagesInPacket);
               break;
            case CleanUsersMessagesInPacket.id:
               this.cleanUsersMessages(param1 as CleanUsersMessagesInPacket);
               break;
            case ClearAllMessagesInPacket.id:
               this.clearAllMessages();
               break;
            case UnloadChatInPacket.id:
               this.unload(param1 as UnloadChatInPacket);
         }
      }
      
      private function load(param1:LoadChatModelInPacket) : void
      {
         var modelVector:Vector.<Long> = new Vector.<Long>();
         modelVector.push(this.chatModel.id);
         modelVector.push(this.communicationPanelModel.id);
         var chatGameClass:IGameClass = this.gameTypeRegistry.createClass(Long.getLong(12443678,87454321), modelVector);
         this.chatGameObject = PanelPacketHandler.panelSpace.createObject(Long.getLong(11545678,87654342), chatGameClass, "Chat");

         param1.cc.channels = new Vector.<String>();
         param1.cc.channels.push("Main");

         Model.object = this.chatGameObject;
         this.chatModel.putInitParams(param1.cc);
         this.chatModel.objectLoaded();
         this.communicationPanelModel.objectLoaded();
         Model.popObject();
      }
      
      private function updateTypingSpeedAntifloodParams(param1:UpdateTypingAntifloodParamsInPacket) : void
      {
         this.chatModel.updateTypingSpeedAntifloodParams(param1.symbolCost, param1.messageCost);
      }
      
      private function showMessages(param1:ShowMessagesInPacket) : void
      {
         this.chatModel.showMessages(param1.messages);
      }
      
      private function cleanUsersMessages(param1:CleanUsersMessagesInPacket) : void
      {
         this.chatModel.cleanUsersMessages(param1.username);
      }
      
      private function clearAllMessages() : void
      {
         //this.chatModel.clearAllMessages();
      }
      
      private function unload(param1:UnloadChatInPacket) : void
      {
         PanelPacketHandler.panelSpace.destroyObject(this.chatGameObject.id);
      }
   }
}

