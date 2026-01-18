package scpacker.networking.protocol.packets.battlechat
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.battle.gui.chat.BattleChatModel;
   import projects.tanks.client.battlefield.models.battle.gui.chat.BattleChatModelBase;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   
   public class BattleChatPacketHandler extends AbstractPacketHandler
   {
      private var battleChatModel:BattleChatModel;
      
      public function BattleChatPacketHandler()
      {
         super();
         this.id = 61;
         this.battleChatModel = BattleChatModel(modelRegistry.getModel(BattleChatModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ReceiveBattleChatInPacket.id:
               this.handleReceiveBattleChat(param1 as ReceiveBattleChatInPacket);
               break;
            case AddSpectatorTeamMessageInPacket.id:
               this.handleAddSpectatorTeamMessage(param1 as AddSpectatorTeamMessageInPacket);
               break;
            case ReceiveBattleSystemChatInPacket.id:
               this.handleReceiveBattleSystemChat(param1 as ReceiveBattleSystemChatInPacket);
               break;
            case AddTeamMessageInPacket.id:
               this.handleAddTeamMessage(param1 as AddTeamMessageInPacket);
               break;
            case BattleChatLoadedInPacket.id:
               this.handleBattleChatLoaded();
               break;
            case BattleChatUpdateTeamHeaderInPacket.id:
               this.handleUpdateTeamHeader(param1 as BattleChatUpdateTeamHeaderInPacket);
         }
      }
      
      private function handleReceiveBattleChat(param1:ReceiveBattleChatInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleChatModel.addMessage(param1.userId,param1.message,param1.team);
         Model.popObject();
      }
      
      private function handleAddSpectatorTeamMessage(param1:AddSpectatorTeamMessageInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleChatModel.addSpectatorTeamMessage(param1.username,param1.message);
         Model.popObject();
      }
      
      private function handleReceiveBattleSystemChat(param1:ReceiveBattleSystemChatInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleChatModel.addSystemMessage(param1.message);
         Model.popObject();
      }
      
      private function handleAddTeamMessage(param1:AddTeamMessageInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleChatModel.addTeamMessage(param1.userId,param1.message,param1.team);
         Model.popObject();
      }
      
      private function handleBattleChatLoaded() : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleChatModel.objectLoaded();
         Model.popObject();
      }
      
      private function handleUpdateTeamHeader(param1:BattleChatUpdateTeamHeaderInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.battleChatModel.updateTeamHeader(param1.header);
         Model.popObject();
      }
   }
}

