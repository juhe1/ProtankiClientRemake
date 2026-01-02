package scpacker.networking.protocol
{
   import scpacker.networking.protocol.packets.init.*;
   import scpacker.networking.protocol.PacketFactory;
   import scpacker.networking.protocol.PacketInvoker;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.externalentrance.LoadExternalEntranceInPacket;
   import scpacker.networking.protocol.packets.externalentrance.CreateLinkForExistingUserOutPacket;
   import projects.tanks.client.entrance.model.entrance.externalentrance.ExternalEntranceCC;
   import scpacker.networking.protocol.packets.externalentrance.ExternalEntrancePacketHandler;
   import scpacker.networking.protocol.packets.externalentrance.LinkAlreadyExistsInPacket;
   import scpacker.networking.protocol.packets.externalentrance.SetLoginDataOutPacket;
   import scpacker.networking.protocol.packets.externalentrance.ValidationFailedInPacket;
   import scpacker.networking.protocol.packets.externalentrance.ValidationSuccessInPacket;
   import scpacker.networking.protocol.packets.registration.RegistrationPacketHandler;
   import scpacker.networking.protocol.packets.registration.CheckNameAvailabilityOutPacket;
   import scpacker.networking.protocol.packets.externalentrance.ExternalRegisterNewUserOutPacket;
   import scpacker.networking.protocol.packets.registration.CreateAccountOutPacket;
   import scpacker.networking.protocol.packets.registration.EnteredUidIsIncorrectInPacket;
   import scpacker.networking.protocol.packets.registration.InitializeRegistrationInPacket;
   import scpacker.networking.protocol.packets.registration.NameAvailableInPacket;
   import scpacker.networking.protocol.packets.registration.NameUnavailableInPacket;
   import scpacker.networking.protocol.packets.captcha.CaptchaPacketHandler;
   import scpacker.networking.protocol.packets.captcha.SetCaptchaKeysInPacket;
   import scpacker.networking.protocol.packets.captcha.CaptchaCorrectInPacket;
   import scpacker.networking.protocol.packets.captcha.ReceiveCaptchaInPacket;
   import scpacker.networking.protocol.packets.captcha.CaptchaFailedInPacket;
   import scpacker.networking.protocol.packets.captcha.AnswerCaptchaOutPacket;
   import scpacker.networking.protocol.packets.captcha.RequestCaptchaOutPacket;
   import scpacker.networking.protocol.packets.login.LoginPacketHandler;
   import scpacker.networking.protocol.packets.login.LoginSuccessInPacket;
   import scpacker.networking.protocol.packets.login.LoginFailedInPacket;
   import scpacker.networking.protocol.packets.login.LoginOutPacket;
   import scpacker.networking.protocol.packets.ping.PingPacketHandler;
   import scpacker.networking.protocol.packets.ping.PingInPacket;
   import scpacker.networking.protocol.packets.ping.PongOutPacket;
   import scpacker.networking.protocol.packets.layoutswitch.LayoutSwitchPacketHandler;
   import scpacker.networking.protocol.packets.layoutswitch.BeginLayoutSwitchInPacket;
   import scpacker.networking.protocol.packets.layoutswitch.EndLayoutSwitchInPacket;
   import scpacker.networking.protocol.packets.panel.PanelPacketHandler;
   import scpacker.networking.protocol.packets.panel.LoadAccountStatsInPacket;
   import scpacker.networking.protocol.packets.panel.SetDoubleCrystalStateInPacket;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreatePacketHandler;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedDisabledInPacket;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedServerHaltingInPacket;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedTooManyBattlesInPacket;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedBannedInPacket;
   import scpacker.networking.protocol.packets.battlecreate.InitBattleSelectInPacket;
   import scpacker.networking.protocol.packets.battlecreate.SetFilteredBattleNameInPacket;
   import scpacker.networking.protocol.packets.battlecreate.CreateBattleOutPacket;
   import scpacker.networking.protocol.packets.battlecreate.CheckBattleNameOutPacket;
   import scpacker.networking.protocol.packets.battlelist.BattleListPacketHandler;
   import scpacker.networking.protocol.packets.battlelist.BattleCreatedInPacket;
   import scpacker.networking.protocol.packets.battlelist.LoadAllBattlesInPacket;
   import scpacker.networking.protocol.packets.battlelist.RemoveBattleInPacket;
   import scpacker.networking.protocol.packets.battlelist.SelectBattleInOutPacket;
   import scpacker.networking.protocol.packets.battlelist.UnloadBattleSelectSpaceInPacket;
   import scpacker.networking.protocol.packets.usernotifier.UserNotifierPacketHandler;
   import scpacker.networking.protocol.packets.usernotifier.InBattleStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.NotInBattleStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.OnlineStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.PremiumStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.RankStatusInPacket;
   import scpacker.networking.protocol.packets.usernotifier.UserStringStatusInPacket;
   import scpacker.networking.protocol.packets.battleInfo.BattleInfoPacketHandler;
   import scpacker.networking.protocol.packets.battleInfo.JoinedDmBattleInPacket;
   import scpacker.networking.protocol.packets.battleInfo.JoinedTeamBattleInPacket;
   import scpacker.networking.protocol.packets.battleInfo.BattleStoppedInPacket;
   import scpacker.networking.protocol.packets.battleInfo.EquipmentNotMatchConstraintsInPacket;
   import scpacker.networking.protocol.packets.battleInfo.EquipmentNotMatchTeamConstraintsInPacket;
   import scpacker.networking.protocol.packets.battleInfo.FightFailedServerHaltingInPacket;
   import scpacker.networking.protocol.packets.battleInfo.UnloadBattleInfoInPacket;
   import scpacker.networking.protocol.packets.battleInfo.LeftPacketInPacket;
   import scpacker.networking.protocol.packets.battleInfo.RoundFinishedInPacket;
   import scpacker.networking.protocol.packets.battleInfo.RoundStartedInPacket;
   import scpacker.networking.protocol.packets.battleInfo.LoadBattleInfoInPacket;
   import scpacker.networking.protocol.packets.battleInfo.SwapTeamsInPacket;
   import scpacker.networking.protocol.packets.battleInfo.UpdateBattleNameInPacket;
   import scpacker.networking.protocol.packets.battleInfo.UpdateTeamScoreInPacket;
   import scpacker.networking.protocol.packets.battleInfo.UpdatePlayerDmKillsInPacket;
   import scpacker.networking.protocol.packets.battleInfo.UpdatePlayerTeamScoreInPacket;
   import scpacker.networking.protocol.packets.battleInfo.UpdatePlayerSuspiciousStateInPacket;
   import scpacker.networking.protocol.packets.usernotifier.SubscribeStatusOutPacket;
   import scpacker.networking.protocol.packets.usernotifier.UnsubscribeOutPacket;
   import scpacker.networking.protocol.packets.battleitem.BattleItemPacketHandler;
   import scpacker.networking.protocol.packets.garage.GaragePacketHandler;
   import scpacker.networking.protocol.packets.garage.CheckItemMountedInPacket;
   import scpacker.networking.protocol.packets.garage.LoadOwnedGarageItemsInPacket;
   import scpacker.networking.protocol.packets.garage.LoadPurchasableItemsInPacket;
   import scpacker.networking.protocol.packets.garage.RenameFailedInPacket;
   import scpacker.networking.protocol.packets.garage.RenameSuccessfulInPacket;
   import scpacker.networking.protocol.packets.garage.SelectFirstDepotItemInPacket;
   import scpacker.networking.protocol.packets.garage.SelectItemInPacket;
   import scpacker.networking.protocol.packets.garage.ShowGarageCategoryInPacket;
   import scpacker.networking.protocol.packets.garage.ShowNewPresentsAlertInPacket;
   import scpacker.networking.protocol.packets.garage.UnloadGarageSpaceInPacket;
   
   public class PacketInitializer
   {
      private var packetRegistry:PacketFactory;
      
      private var packetInvoker:PacketInvoker;
      
      public function PacketInitializer()
      {
         super();
      }
      
      public function init(param1:OSGi) : void
      {
         packetInvoker = PacketInvoker(param1.getService(PacketInvoker));
         packetRegistry = PacketFactory(param1.getService(PacketFactory));

         // External Entrance Packets
         packetInvoker.registerPacketHandler(new ExternalEntrancePacketHandler());
         packetRegistry.registerPacket(new CreateLinkForExistingUserOutPacket());
         packetRegistry.registerPacket(new LinkAlreadyExistsInPacket());
         packetRegistry.registerPacket(new LoadExternalEntranceInPacket());
         packetRegistry.registerPacket(new SetLoginDataOutPacket());
         packetRegistry.registerPacket(new ValidationFailedInPacket());
         packetRegistry.registerPacket(new ValidationSuccessInPacket());
         packetRegistry.registerPacket(new ExternalRegisterNewUserOutPacket());

         // Init Packets
         packetInvoker.registerPacketHandler(new InitPacketHandler());
         packetRegistry.registerPacket(new ActivateProtectionInPacket());
         packetRegistry.registerPacket(new LoadResourcesInPacket());
         packetRegistry.registerPacket(new HideLoaderInPacket());
         packetRegistry.registerPacket(new ResourcesLoadedOutPacket());
         packetRegistry.registerPacket(new SetClientLangOutPacket());

         // Registration Packets
         packetInvoker.registerPacketHandler(new RegistrationPacketHandler());
         packetRegistry.registerPacket(new CheckNameAvailabilityOutPacket());
         packetRegistry.registerPacket(new CreateAccountOutPacket());
         packetRegistry.registerPacket(new EnteredUidIsIncorrectInPacket());
         packetRegistry.registerPacket(new InitializeRegistrationInPacket());
         packetRegistry.registerPacket(new NameAvailableInPacket());
         packetRegistry.registerPacket(new NameUnavailableInPacket());

         // Captcha Packets
         packetInvoker.registerPacketHandler(new CaptchaPacketHandler());
         packetRegistry.registerPacket(new SetCaptchaKeysInPacket());
         packetRegistry.registerPacket(new CaptchaCorrectInPacket());
         packetRegistry.registerPacket(new ReceiveCaptchaInPacket());
         packetRegistry.registerPacket(new CaptchaFailedInPacket());
         packetRegistry.registerPacket(new AnswerCaptchaOutPacket());
         packetRegistry.registerPacket(new RequestCaptchaOutPacket());

         // Login Packets
         packetInvoker.registerPacketHandler(new LoginPacketHandler());
         packetRegistry.registerPacket(new LoginSuccessInPacket());
         packetRegistry.registerPacket(new LoginFailedInPacket());
         packetRegistry.registerPacket(new LoginOutPacket());

         // Ping Packets
         packetInvoker.registerPacketHandler(new PingPacketHandler());
         packetRegistry.registerPacket(new PingInPacket());
         packetRegistry.registerPacket(new PongOutPacket());

         // Layout Switch Packets
         packetInvoker.registerPacketHandler(new LayoutSwitchPacketHandler());
         packetRegistry.registerPacket(new BeginLayoutSwitchInPacket());
         packetRegistry.registerPacket(new EndLayoutSwitchInPacket());

         // Panel Packets
         packetInvoker.registerPacketHandler(new PanelPacketHandler());
         packetRegistry.registerPacket(new LoadAccountStatsInPacket());
         packetRegistry.registerPacket(new SetDoubleCrystalStateInPacket());

         // BattleCreate Packets
         packetInvoker.registerPacketHandler(new BattleCreatePacketHandler());
         packetRegistry.registerPacket(new BattleCreateFailedDisabledInPacket());
         packetRegistry.registerPacket(new BattleCreateFailedServerHaltingInPacket());
         packetRegistry.registerPacket(new BattleCreateFailedTooManyBattlesInPacket());
         packetRegistry.registerPacket(new BattleCreateFailedBannedInPacket());
         packetRegistry.registerPacket(new InitBattleSelectInPacket());
         packetRegistry.registerPacket(new SetFilteredBattleNameInPacket());
         packetRegistry.registerPacket(new CreateBattleOutPacket());
         packetRegistry.registerPacket(new CheckBattleNameOutPacket());

         // BattleList Packets
         packetInvoker.registerPacketHandler(new BattleListPacketHandler());
         packetRegistry.registerPacket(new BattleCreatedInPacket());
         packetRegistry.registerPacket(new LoadAllBattlesInPacket());
         packetRegistry.registerPacket(new RemoveBattleInPacket());
         packetRegistry.registerPacket(new SelectBattleInOutPacket());
         packetRegistry.registerPacket(new UnloadBattleSelectSpaceInPacket());

         // UserNotifier Packets
         packetInvoker.registerPacketHandler(new UserNotifierPacketHandler());
         packetRegistry.registerPacket(new RankStatusInPacket());
         packetRegistry.registerPacket(new OnlineStatusInPacket());
         packetRegistry.registerPacket(new UserStringStatusInPacket());
         packetRegistry.registerPacket(new PremiumStatusInPacket());
         packetRegistry.registerPacket(new InBattleStatusInPacket());
         packetRegistry.registerPacket(new NotInBattleStatusInPacket());
         packetRegistry.registerPacket(new SubscribeStatusOutPacket());
         packetRegistry.registerPacket(new UnsubscribeOutPacket());

         // BattleInfo Packets
         packetInvoker.registerPacketHandler(new BattleInfoPacketHandler());
         packetRegistry.registerPacket(new JoinedDmBattleInPacket());
         packetRegistry.registerPacket(new JoinedTeamBattleInPacket());
         packetRegistry.registerPacket(new BattleStoppedInPacket());
         packetRegistry.registerPacket(new EquipmentNotMatchConstraintsInPacket());
         packetRegistry.registerPacket(new EquipmentNotMatchTeamConstraintsInPacket());
         packetRegistry.registerPacket(new FightFailedServerHaltingInPacket());
         packetRegistry.registerPacket(new UnloadBattleInfoInPacket());
         packetRegistry.registerPacket(new LeftPacketInPacket());
         packetRegistry.registerPacket(new RoundFinishedInPacket());
         packetRegistry.registerPacket(new RoundStartedInPacket());
         packetRegistry.registerPacket(new LoadBattleInfoInPacket());
         packetRegistry.registerPacket(new SwapTeamsInPacket());
         packetRegistry.registerPacket(new UpdateBattleNameInPacket());
         packetRegistry.registerPacket(new UpdateTeamScoreInPacket());
         packetRegistry.registerPacket(new UpdatePlayerDmKillsInPacket());
         packetRegistry.registerPacket(new UpdatePlayerTeamScoreInPacket());
         packetRegistry.registerPacket(new UpdatePlayerSuspiciousStateInPacket());

         // BattleItem Packets
         packetInvoker.registerPacketHandler(new BattleItemPacketHandler());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.BattleMadePrivateInPacket());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.LeftDmBattleInPacket());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.LeftTeamBattleInPacket());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.JoinedDmBattleInPacket());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.JoinedTeamBattleInPacket());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.SwapTeamsInPacket());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.UpdateBattleNameInPacket());
         packetRegistry.registerPacket(new scpacker.networking.protocol.packets.battleitem.UpdateBattleSuspicionInPacket());

         // Garage Packets
         packetInvoker.registerPacketHandler(new GaragePacketHandler());
         packetRegistry.registerPacket(new LoadOwnedGarageItemsInPacket());
         packetRegistry.registerPacket(new LoadPurchasableItemsInPacket());
         packetRegistry.registerPacket(new UnloadGarageSpaceInPacket());
         packetRegistry.registerPacket(new CheckItemMountedInPacket());
         packetRegistry.registerPacket(new RenameFailedInPacket());
         packetRegistry.registerPacket(new RenameSuccessfulInPacket());
         packetRegistry.registerPacket(new SelectFirstDepotItemInPacket());
         packetRegistry.registerPacket(new SelectItemInPacket());
         packetRegistry.registerPacket(new ShowGarageCategoryInPacket());
         packetRegistry.registerPacket(new ShowNewPresentsAlertInPacket());

      }
   }
}

