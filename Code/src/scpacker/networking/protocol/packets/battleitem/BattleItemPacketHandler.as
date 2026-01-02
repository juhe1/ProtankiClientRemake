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
            case BattleMadePrivateInPacket.id:
               this.madePrivate(param1 as BattleMadePrivateInPacket);
               break;
            case LeftDmBattleInPacket.id:
               this.onReleaseSlotDm(param1 as LeftDmBattleInPacket);
               break;
            case LeftTeamBattleInPacket.id:
               this.onReleaseSlotTeam(param1 as LeftTeamBattleInPacket);
               break;
            case JoinedDmBattleInPacket.id:
               this.onReserveSlotDm(param1 as JoinedDmBattleInPacket);
               break;
            case JoinedTeamBattleInPacket.id:
               this.onReserveSlotTeam(param1 as JoinedTeamBattleInPacket);
               break;
            case SwapTeamsInPacket.id:
               this.swapTeams(param1 as SwapTeamsInPacket);
               break;
            case UpdateBattleNameInPacket.id:
               this.updateName(param1 as UpdateBattleNameInPacket);
               break;
            case UpdateBattleSuspicionInPacket.id:
               this.updateSuspicious(param1 as UpdateBattleSuspicionInPacket);
         }
      }
      
      private function madePrivate(param1:BattleMadePrivateInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            //this.newname_5446__END.madePrivate();
            Model.popObject();
         }
      }
      
      private function updateName(param1:UpdateBattleNameInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleInfoModel.setBattleName(param1.battleName);
            Model.popObject();
         }
      }
      
      private function updateSuspicious(param1:UpdateBattleSuspicionInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleInfoModel.updateSuspicion(param1.suspicionLevel);
            Model.popObject();
         }
      }
      
      private function onReserveSlotDm(param1:JoinedDmBattleInPacket) : void
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
      
      private function onReleaseSlotDm(param1:LeftDmBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleDmInfoModel.removeUser(param1.userId);
            Model.popObject();
         }
      }
      
      private function onReleaseSlotTeam(param1:LeftTeamBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            Model.object = _loc2_;
            this.battleTeamInfoModel.removeUser(param1.userId);
            Model.popObject();
         }
      }
      
      private function onReserveSlotTeam(param1:JoinedTeamBattleInPacket) : void
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
      
      private function swapTeams(param1:SwapTeamsInPacket) : void
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

