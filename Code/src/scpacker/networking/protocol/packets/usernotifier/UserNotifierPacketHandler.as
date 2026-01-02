package scpacker.networking.protocol.packets.usernotifier
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.rank.RankNotifierModel;
   import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierData;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online.OnlineNotifierModel;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.premium.PremiumNotifierModel;
   import alternativa.types.Long;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifierModel;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleNotifierModel;
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierCC;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierData;
   import scpacker.networking.protocol.packets.usernotifier.InBattleStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.NotInBattleStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.OnlineStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.PremiumStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.RankStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.UserStringStatusInPacket;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.uid.UidNotifierModel;
   import projects.tanks.client.tanksservices.model.listener.UserNotifierModelBase;
   import controls.Rank;
   import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
   import alternativa.osgi.OSGi;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierData;
   
   public class UserNotifierPacketHandler extends AbstractPacketHandler
   {
      private var userNotifierModel:UserNotifierModel;
      private var rankNotifierModel:RankNotifierModel;
      private var uidNotifierModel:UidNotifierModel;
      private var onlineNotifierModel:OnlineNotifierModel;
      private var battleNotifierModel:BattleNotifierModel;

      private var battleUserPremiumService:BattleUserPremiumService;
      
      public function UserNotifierPacketHandler()
      {
         super();
         this.id = 18;
         this.userNotifierModel = UserNotifierModel(modelRegistry.getModel(UserNotifierModelBase.modelId));
         this.userNotifierModel.objectLoaded();
         this.rankNotifierModel = RankNotifierModel(modelRegistry.getModel(RankNotifierModelBase.modelId));
         this.uidNotifierModel = UidNotifierModel(modelRegistry.getModel(UidNotifierModelBase.modelId));
         this.onlineNotifierModel = OnlineNotifierModel(modelRegistry.getModel(OnlineNotifierModelBase.modelId));
         this.battleNotifierModel = BattleNotifierModel(modelRegistry.getModel(BattleNotifierModelBase.modelId));
         this.battleNotifierModel.objectLoaded();

         this.battleUserPremiumService = OSGi.getInstance().getService(BattleUserPremiumService) as BattleUserPremiumService;
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case RankStatusInPacket.id:
               this.setRank(param1 as RankStatusInPacket);
               break;
            case OnlineStatusInPacket.id:
               this.setOnline(param1 as OnlineStatusInPacket);
               break;
            case UserStringStatusInPacket.id:
               this.newname_8545__END(param1 as UserStringStatusInPacket);
               break;
            case PremiumStatusInPacket.id:
               this.setPremiumTimeLeft(param1 as PremiumStatusInPacket);
               break;
            case InBattleStatusInPacket.id:
               this.setBattle(param1 as InBattleStatusInPacket);
               break;
            case NotInBattleStatusInPacket.id:
               this.leaveBattle(param1 as NotInBattleStatusInPacket);
         }
      }
      
      private function setRank(param1:RankStatusInPacket) : void
      {
         this.rankNotifierModel.setRank(new <RankNotifierData>[param1.userInfo]);
      }
      
      private function setOnline(param1:OnlineStatusInPacket) : void
      {
         this.onlineNotifierModel.setOnline(new <OnlineNotifierData>[param1.userInfo]);
      }
      
      private function newname_8545__END(param1:UserStringStatusInPacket) : void
      {
         throw new ArgumentError();
      }
      
      private function setPremiumTimeLeft(param1:PremiumStatusInPacket) : void
      {
         this.battleUserPremiumService.setUsersPremiumProtanki(new <PremiumNotifierData>[param1.premiumData]);
      }
      
      private function setBattle(param1:InBattleStatusInPacket) : void
      {
         this.battleNotifierModel.setBattle(new <BattleNotifierData>[param1.userInfo]);
      }
      
      private function leaveBattle(param1:NotInBattleStatusInPacket) : void
      {
         this.battleNotifierModel.leaveBattle(param1.userId);
      }
   }
}

