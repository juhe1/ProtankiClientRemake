package scpacker.networking.protocol.packets.battleitem
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.tanks.model.info.BattleInfoModel;
   import projects.tanks.client.battleselect.model.battle.BattleInfoModelBase;
   import projects.tanks.client.battleselect.model.battle.dm.BattleDMInfoModelBase;
   import alternativa.tanks.model.info.dm.BattleDmInfoModel;
   import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoModelBase;
   import alternativa.tanks.model.info.team.BattleTeamInfoModel;
   import scpacker.SpaceAndGameObjectIds;
   import platform.client.fp10.core.type.ISpace;
   
   public class BattleItemPacketHandler extends AbstractPacketHandler
   {
      private var battleInfoModel:BattleInfoModel;
      private var battleDmInfoModel:BattleDmInfoModel;
      private var battleTeamInfoModel:BattleTeamInfoModel;
      
      private var battleSelectSpace:ISpace;
     
      public function BattleItemPacketHandler()
      {
         super();
         this.id = 32;
         this.battleInfoModel = BattleInfoModel(modelRegistry.getModel(BattleInfoModelBase.modelId));
         this.battleDmInfoModel = BattleDmInfoModel(modelRegistry.getModel(BattleDMInfoModelBase.modelId));
         this.battleTeamInfoModel = BattleTeamInfoModel(modelRegistry.getModel(TeamBattleInfoModelBase.modelId));
         this.battleSelectSpace = ISpace(spaceRegistry.getSpace(SpaceAndGameObjectIds.BATTLE_SELECT_SPACE_ID));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ItemBattleMadePrivateInPacket.id:
               this.madePrivate(param1 as ItemBattleMadePrivateInPacket);
               break;
            case ItemLeftDmBattleInPacket.id:
               this.onReleaseSlotDm(param1 as ItemLeftDmBattleInPacket);
               break;
            case ItemLeftTeamBattleInPacket.id:
               this.onReleaseSlotTeam(param1 as ItemLeftTeamBattleInPacket);
               break;
            case ItemJoinedDmBattleInPacket.id:
               this.onReserveSlotDm(param1 as ItemJoinedDmBattleInPacket);
               break;
            case ItemJoinedTeamBattleInPacket.id:
               this.onReserveSlotTeam(param1 as ItemJoinedTeamBattleInPacket);
               break;
            case ItemSwapTeamsInPacket.id:
               this.swapTeams(param1 as ItemSwapTeamsInPacket);
               break;
            case ItemUpdateBattleNameInPacket.id:
               this.updateName(param1 as ItemUpdateBattleNameInPacket);
               break;
            case ItemUpdateBattleSuspicionInPacket.id:
               this.updateSuspicious(param1 as ItemUpdateBattleSuspicionInPacket);
         }
      }
      
      private function madePrivate(param1:ItemBattleMadePrivateInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            //this.newname_5446__END.madePrivate();
            Model.popObject();
         }
      }
      
      private function updateName(param1:ItemUpdateBattleNameInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleInfoModel.setBattleName(param1.battleName);
            Model.popObject();
         }
      }
      
      private function updateSuspicious(param1:ItemUpdateBattleSuspicionInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleInfoModel.updateSuspicion(param1.suspicionLevel);
            Model.popObject();
         }
      }
      
      private function onReserveSlotDm(param1:ItemJoinedDmBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            var userInfo:BattleInfoUser = new BattleInfoUser();
            userInfo.user = param1.userId;

            Model.object = _loc2_;
            this.battleDmInfoModel.addUser(userInfo);
            Model.popObject();
         }
      }
      
      private function onReleaseSlotDm(param1:ItemLeftDmBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleDmInfoModel.removeUser(param1.userId);
            Model.popObject();
         }
      }
      
      private function onReleaseSlotTeam(param1:ItemLeftTeamBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleTeamInfoModel.removeUser(param1.userId);
            Model.popObject();
         }
      }
      
      private function onReserveSlotTeam(param1:ItemJoinedTeamBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            var userInfo:BattleInfoUser = new BattleInfoUser();
            userInfo.user = param1.userId;

            Model.object = _loc2_;
            this.battleTeamInfoModel.addUser(userInfo,param1.team);
            Model.popObject();
         }
      }
      
      private function swapTeams(param1:ItemSwapTeamsInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleTeamInfoModel.swapTeams();
            Model.popObject();
         }
      }
   }
}

