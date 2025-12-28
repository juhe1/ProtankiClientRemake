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
   import scpacker.networking.protocol.packets.battlelist.BattlelistPacketHandler;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedDisabledInPacket;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedServerHaltingInPacket;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedTooManyBattlesInPacket;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedBannedInPacket;
   import scpacker.networking.protocol.packets.battlelist.InitMapsInPacket;
   import scpacker.networking.protocol.packets.battlelist.SetFilteredBattleNameInPacket;
   import scpacker.networking.protocol.packets.battlelist.CreateBattleOutPacket;
   import scpacker.networking.protocol.packets.battlelist.CheckBattleNameOutPacket;
   
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

         // Battlelist Packets
         packetInvoker.registerPacketHandler(new BattlelistPacketHandler());
         packetRegistry.registerPacket(new BattleCreateFailedDisabledInPacket());
         packetRegistry.registerPacket(new BattleCreateFailedServerHaltingInPacket());
         packetRegistry.registerPacket(new BattleCreateFailedTooManyBattlesInPacket());
         packetRegistry.registerPacket(new BattleCreateFailedBannedInPacket());
         packetRegistry.registerPacket(new InitMapsInPacket());
         packetRegistry.registerPacket(new SetFilteredBattleNameInPacket());
         packetRegistry.registerPacket(new CreateBattleOutPacket());
         packetRegistry.registerPacket(new CheckBattleNameOutPacket());

      }
   }
}

