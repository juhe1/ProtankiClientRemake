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
   import scpacker.networking.protocol.packets.loginbyhash.LoginByHashPacketHandler;
   import scpacker.networking.protocol.packets.loginbyhash.LoginByHashFailedInPacket;
   import scpacker.networking.protocol.packets.loginbyhash.LoginByHashOutPacket;
   import scpacker.networking.protocol.packets.loginbyhash.RememberUserHashInPakcet;
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
   import scpacker.networking.protocol.packets.garage.MountItemOutPacket;
   import scpacker.networking.protocol.packets.garage.BuyKitOutPacket;
   import scpacker.networking.protocol.packets.garage.BuyMultipleItemsOutPacket;
   import scpacker.networking.protocol.packets.garage.FitItemOutPacket;
   import scpacker.networking.protocol.packets.garage.GarageEasterEggOutPacket;
   import scpacker.networking.protocol.packets.garage.RemovePresentOutPacket;
   import scpacker.networking.protocol.packets.garage.RenameOutPacket;
   import scpacker.networking.protocol.packets.battleInfo.JoinBattleOutPacket;
   import scpacker.networking.protocol.packets.battleInfo.SpectateBattleOutPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemBattleMadePrivateInPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemLeftDmBattleInPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemLeftTeamBattleInPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemJoinedDmBattleInPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemJoinedTeamBattleInPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemSwapTeamsInPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemUpdateBattleNameInPacket;
   import scpacker.networking.protocol.packets.battleitem.ItemUpdateBattleSuspicionInPacket;
   import scpacker.networking.protocol.packets.timechecker.TimeCheckerPacketHandler;
   import scpacker.networking.protocol.packets.timechecker.TimeCheckerPingInPacket;
   import scpacker.networking.protocol.packets.timechecker.TimeCheckerPongOutPacket;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   import scpacker.networking.protocol.packets.battle.InitBattleInPacket;
   import scpacker.networking.protocol.packets.battle.CreateTankInPacket;
   import scpacker.networking.protocol.packets.battle.InitializeSupplyEffectsInPacket;
   import scpacker.networking.protocol.packets.battle.InitBonusBoxesInPacket;
   import scpacker.networking.protocol.packets.battle.AddBonusBoxesInPacket;
   import scpacker.networking.protocol.packets.battle.AddBonusBoxInPacket;
   import scpacker.networking.protocol.packets.battle.RemoveBonusBoxInPacket;
   import scpacker.networking.protocol.packets.battle.TakeBonusBoxInPacket;
   import scpacker.networking.protocol.packets.battle.UnloadBattleSpaceInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.BattleStatisticsPacketHandler;
   import scpacker.networking.protocol.packets.battlestatistics.BattleFundInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.InitStatisticsInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.StatisticsModelLoadedPostInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.ComplaintConfirmedInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.RankUpInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.RoundFinishInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.RoundStartInPacket;
   import scpacker.networking.protocol.packets.battlestatistics.StatusProbablyCheaterChangedInPacket;
   import scpacker.networking.protocol.packets.dm.DmPacketHandler;
   import scpacker.networking.protocol.packets.dm.LoadDmModelPostInPacket;
   import scpacker.networking.protocol.packets.statisticsdm.ChangeUserStatInPacket;
   import scpacker.networking.protocol.packets.statisticsdm.DmStatisticsUserConnectInPacket;
   import scpacker.networking.protocol.packets.statisticsdm.DmStatisticsUserDisconnectInPacket;
   import scpacker.networking.protocol.packets.statisticsdm.InitDMStatisticsInPacket;
   import scpacker.networking.protocol.packets.statisticsdm.RefreshUsersStatInPacket;
   import scpacker.networking.protocol.packets.statisticsdm.StatisticsDmPacketHandler;
   import scpacker.networking.protocol.packets.statisticsteam.InitStatisticsTeamModelInPacket;
   import scpacker.networking.protocol.packets.statisticsteam.StatisticsTeamChangeTeamScoreInPacket;
   import scpacker.networking.protocol.packets.statisticsteam.StatisticsTeamChangeUserStatInPacket;
   import scpacker.networking.protocol.packets.statisticsteam.StatisticsTeamPacketHandler;
   import scpacker.networking.protocol.packets.statisticsteam.StatisticsTeamSwapTeamInPacket;
   import scpacker.networking.protocol.packets.statisticsteam.StatisticsTeamUserConnectInPacket;
   import scpacker.networking.protocol.packets.statisticsteam.StatisticsTeamUserLeftInPacket;
   import scpacker.networking.protocol.packets.tdm.TdmPacketHandler;
   import scpacker.networking.protocol.packets.tdm.LoadTdmPostInPacket;
   import scpacker.networking.protocol.packets.turretdata.TurretDataPacketHandler;
   import scpacker.networking.protocol.packets.turretdata.LoadTurretDataInPacket;
   import scpacker.networking.protocol.packets.tank.TankPacketHandler;
   import scpacker.networking.protocol.packets.tank.ActivateTankInPacket;
   import scpacker.networking.protocol.packets.tank.ActivateEffectInPacket;
   import scpacker.networking.protocol.packets.tank.StopEffectInPacket;
   import scpacker.networking.protocol.packets.tank.KillTankInPacket;
   import scpacker.networking.protocol.packets.tank.MoveAndSetTurretStateInPacket;
   import scpacker.networking.protocol.packets.tank.MoveTankInPacket;
   import scpacker.networking.protocol.packets.tank.MovementControlInPacket;
   import scpacker.networking.protocol.packets.tank.PrepareToSpawnInPacket;
   import scpacker.networking.protocol.packets.tank.RotateTurretInPacket;
   import scpacker.networking.protocol.packets.tank.SetTankHealthInPacket;
   import scpacker.networking.protocol.packets.tank.SetSpecificationInPacket;
   import scpacker.networking.protocol.packets.tank.SetTankTemperatureInPacket;
   import scpacker.networking.protocol.packets.tank.SpawnTankInPacket;
   import scpacker.networking.protocol.packets.tank.UnloadTankInPacket;
   import scpacker.networking.protocol.packets.tank.ClientMoveOutPacket;
   import scpacker.networking.protocol.packets.tank.ClientMoveTankAndTurretOutPacket;
   import scpacker.networking.protocol.packets.tank.ClientRotateTurretOutPacket;
   import scpacker.networking.protocol.packets.tank.ReadyToSpawnEndOutPacket;
   import scpacker.networking.protocol.packets.tank.ActivateTankOutPacket;
   import scpacker.networking.protocol.packets.tank.MovementControlOutPacket;
   import scpacker.networking.protocol.packets.tank.ReadyToPlaceOutPacket;
   import scpacker.networking.protocol.packets.flamethrower.FlamethrowerPacketHandler;
   import scpacker.networking.protocol.packets.flamethrower.FlamethrowerStartFireInPacket;
   import scpacker.networking.protocol.packets.flamethrower.FlamethrowerStopFireInPacket;
   import scpacker.networking.protocol.packets.flamethrower.FlamethrowerStartOutPacket;
   import scpacker.networking.protocol.packets.flamethrower.FlamethrowerStopOutPacket;
   import scpacker.networking.protocol.packets.flamethrower.FlamethrowerHitOutPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyPacketHandler;
   import scpacker.networking.protocol.packets.smoky.SmokyLocalCriticalHitInPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyShootInPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyShootStaticInPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyShootTargetInPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyFireOutPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyFireStaticOutPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyFireTargetOutPacket;
   import scpacker.networking.protocol.packets.damageindicator.DamageIndicatorPacketHandler;
   import scpacker.networking.protocol.packets.damageindicator.ShowDamageForShooterInPacket;
   import scpacker.networking.protocol.packets.controlpoints.ControlPointsPacketHandler;
   import scpacker.networking.protocol.packets.controlpoints.LoadControlPointsCCInPacket;
   import scpacker.networking.protocol.packets.controlpoints.PointCaptureStartedInPacket;
   import scpacker.networking.protocol.packets.controlpoints.PointCaptureStoppedInPacket;
   import scpacker.networking.protocol.packets.controlpoints.SetPointProgressInPacket;
   import scpacker.networking.protocol.packets.controlpoints.SetPointStateInPacket;
   import scpacker.networking.protocol.packets.controlpoints.TankEnteredPointZoneInPacket;
   import scpacker.networking.protocol.packets.controlpoints.TankLeftPointZoneInPacket;
   import scpacker.networking.protocol.packets.battlechat.BattleChatPacketHandler;
   import scpacker.networking.protocol.packets.battlechat.ReceiveBattleChatInPacket;
   import scpacker.networking.protocol.packets.battlechat.AddSpectatorTeamMessageInPacket;
   import scpacker.networking.protocol.packets.battlechat.ReceiveBattleSystemChatInPacket;
   import scpacker.networking.protocol.packets.battlechat.AddTeamMessageInPacket;
   import scpacker.networking.protocol.packets.battlechat.BattleChatLoadedInPacket;
   import scpacker.networking.protocol.packets.battlechat.BattleChatUpdateTeamHeaderInPacket;
   import scpacker.networking.protocol.packets.battlechat.SendBattleChatOutPacket;
   import scpacker.networking.protocol.packets.chat.ChatPacketHandler;
   import scpacker.networking.protocol.packets.chat.CleanUsersMessagesInPacket;
   import scpacker.networking.protocol.packets.chat.ClearAllMessagesInPacket;
   import scpacker.networking.protocol.packets.chat.LoadChatModelInPacket;
   import scpacker.networking.protocol.packets.chat.SendMessageOutPacket;
   import scpacker.networking.protocol.packets.chat.ShowMessagesInPacket;
   import scpacker.networking.protocol.packets.chat.UnloadChatInPacket;
   import scpacker.networking.protocol.packets.chat.UpdateTypingAntifloodParamsInPacket;
   import scpacker.networking.protocol.packets.capturetheflag.CaptureTheFlagPacketHandler;
   import scpacker.networking.protocol.packets.capturetheflag.DropFlagInPacket;
   import scpacker.networking.protocol.packets.capturetheflag.FlagDeliveredInPacket;
   import scpacker.networking.protocol.packets.capturetheflag.FlagTakenInPacket;
   import scpacker.networking.protocol.packets.capturetheflag.LoadCaptureTheFlagCCInPacket;
   import scpacker.networking.protocol.packets.capturetheflag.ReturnFlagToBaseInPacket;
   import scpacker.networking.protocol.packets.capturetheflag.DropFlagOutPacket;
   import scpacker.networking.protocol.packets.battlemine.BattleMinePacketHandler;
   import scpacker.networking.protocol.packets.battlemine.ActivateMineInPacket;
   import scpacker.networking.protocol.packets.battlemine.ExplodeMineInPacket;
   import scpacker.networking.protocol.packets.battlemine.LoadBattleMinesCCInPacket;
   import scpacker.networking.protocol.packets.battlemine.PutMineInPacket;
   import scpacker.networking.protocol.packets.battlemine.RemoveMinesInPacket;
   import scpacker.networking.protocol.packets.selfdestruct.SelfDestructPacketHandler;
   import scpacker.networking.protocol.packets.selfdestruct.SuicideInPacket;
   import scpacker.networking.protocol.packets.selfdestruct.SuicideOutPacket;
   import scpacker.networking.protocol.packets.tankreloader.TankReloaderPacketHandler;
   import scpacker.networking.protocol.packets.tankreloader.TankReloaderDieInPacket;
   import scpacker.networking.protocol.packets.tankreloader.TankReloaDeathScheduledInPacket;
   import scpacker.networking.protocol.packets.tankreloader.ReloadTankInPacket;
   import scpacker.networking.protocol.packets.twins.TwinsPacketHandler;
   import scpacker.networking.protocol.packets.twins.TwinsShootTargetIn;
   import scpacker.networking.protocol.packets.twins.TwinsFireDummyIn;
   import scpacker.networking.protocol.packets.railgun.RailgunPacketHandler;
   import scpacker.networking.protocol.packets.railgun.RailgunFireDummyInPacket;
   import scpacker.networking.protocol.packets.railgun.RailgunShootTargetInPacket;
   import scpacker.networking.protocol.packets.railgun.RailgunStartChargingInPacket;
   import scpacker.networking.protocol.packets.railgun.RailgunFireDummyOutPacket;
   import scpacker.networking.protocol.packets.railgun.RailgunFireOutPacket;
   import scpacker.networking.protocol.packets.railgun.RailgunStartChargingOutPacket;
   import scpacker.networking.protocol.packets.isida.IsidaPacketHandler;
   import scpacker.networking.protocol.packets.isida.ResetIsidaTargetInPacket;
   import scpacker.networking.protocol.packets.isida.SetIsidaTargetInPacket;
   import scpacker.networking.protocol.packets.isida.StopIsidaInPacket;
   import scpacker.networking.protocol.packets.isida.IsidaResetTargetOutPacket;
   import scpacker.networking.protocol.packets.isida.IsidaSetTargetOutPacket;
   import scpacker.networking.protocol.packets.isida.IsidaStopOutPacket;
   import scpacker.networking.protocol.packets.isida.IsidaTickOutPacket;
   import scpacker.networking.protocol.packets.thunder.ThunderPacketHandler;
   import scpacker.networking.protocol.packets.thunder.ThunderShootInPacket;
   import scpacker.networking.protocol.packets.thunder.ThunderShootStaticInPacket;
   import scpacker.networking.protocol.packets.thunder.ThunderShootTargetInPacket;
   import scpacker.networking.protocol.packets.thunder.ThunderShootOutPacket;
   import scpacker.networking.protocol.packets.thunder.ThunderShootStaticOutPacket;
   import scpacker.networking.protocol.packets.thunder.ThunderShootTargetOutPacket;
   import scpacker.networking.protocol.packets.shotgun.ShotGunPacketHandler;
   import scpacker.networking.protocol.packets.shotgun.ShotgunShootInPacket;
   import scpacker.networking.protocol.packets.shotgun.ShotgunShotOutPacket;
   import scpacker.networking.protocol.packets.shotgun.ShotgunTryDummyShootOutPacket;
   import scpacker.networking.protocol.packets.freeze.FreezePacketHandler;
   import scpacker.networking.protocol.packets.freeze.FreezeStartInPacket;
   import scpacker.networking.protocol.packets.freeze.FreezeStopInPacket;
   import scpacker.networking.protocol.packets.freeze.FreezeDamageOutPacket;
   import scpacker.networking.protocol.packets.freeze.FreezeStopOutPacket;
   import scpacker.networking.protocol.packets.freeze.FreezeStartOutPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetPacketHandler;
   import scpacker.networking.protocol.packets.ricochet.RicochetFireDummyInPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetShootTargetInPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetFireDummyOutPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetFireOutPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetHitStaticOutPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetHitTargetOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftPacketHandler;
   import scpacker.networking.protocol.packets.shaft.ShaftActivateManualTargetingInPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftActivateManualTargetingOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftAimedShotOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserAimAtTankInPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserAimAtTankOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserHideInPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserHideOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserUpdateDirectionInPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserUpdateDirectionOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftQuickShotOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftScopeInitOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftShootTargetInPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftStopManualTargetingInPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftStopManualTargetingOutPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunPacketHandler;
   import scpacker.networking.protocol.packets.machinegun.MachineGunHitInPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunStartFireInPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunStartFireOutPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunStopFireInPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunStopFireOutPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunUpdateDirectionOutPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunUpdateTargetsOutPacket;   
   import scpacker.networking.protocol.packets.battle.CollectBonusBoxOutPacket;
   import scpacker.networking.protocol.packets.bonusregion.BonusRegionPacketHandler;
   import scpacker.networking.protocol.packets.bonusregion.HideDropZoneInPacket;
   import scpacker.networking.protocol.packets.bonusregion.LoadBonusRegionsModelInPacket;
   import scpacker.networking.protocol.packets.bonusregion.ShowDropZoneInPacket;
   import scpacker.networking.protocol.packets.gold.GoldPacketHandler;
   import scpacker.networking.protocol.packets.gold.GoldTakenInPacket;
   import scpacker.networking.protocol.packets.gold.NotificationBonusContainsUidInPacket;
   import scpacker.networking.protocol.packets.gold.NotificationBonusInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsPacketHandler;
   import scpacker.networking.protocol.packets.friends.LoadFriendsListInPacket;
   import scpacker.networking.protocol.packets.friends.OutgoingOnAddingInPacket;
   import scpacker.networking.protocol.packets.friends.AcceptIncomingFriendInPacket;
   import scpacker.networking.protocol.packets.friends.IncomingOnAddingInPacket;
   import scpacker.networking.protocol.packets.friends.AlreadyInAcceptedFriendsInPacket;
   import scpacker.networking.protocol.packets.friends.AlreadyInIncomingFriendsInPacket;
   import scpacker.networking.protocol.packets.friends.AlreadyInOutgoingFriendsInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsAcceptedOnRemoveInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsIncomingOnRemoveInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsOutgoingOnRemoveInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsAcceptedNotificatorOnRemoveInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsIncomingNotificatorOnRemoveInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsOnUsersLoadedInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsUidExistInPacket;
   import scpacker.networking.protocol.packets.friends.FriendsUidNotExistInPacket;
   import scpacker.networking.protocol.packets.friends.AcceptFriendInviteOutPacket;
   import scpacker.networking.protocol.packets.friends.AddFriendOutPacket;
   import scpacker.networking.protocol.packets.friends.CheckFriendOutPacket;
   import scpacker.networking.protocol.packets.friends.RevokeFriendOutPacket;
   import scpacker.networking.protocol.packets.friends.RejectFriendInviteOutPacket;
   import scpacker.networking.protocol.packets.friends.RemoveAcceptedFriendOutPacket;
   import scpacker.networking.protocol.packets.friends.RemoveIncomingFriendOutPacket;
   import scpacker.networking.protocol.packets.friends.RemoveOutgoingFriendOutPacket;
   import scpacker.networking.protocol.packets.friends.FriendsLoadOutPacket;
   import scpacker.networking.protocol.packets.friends.NotifyAcceptedFriendOutPacket;
   import scpacker.networking.protocol.packets.friends.BattleKickReasonInPacket;
   import scpacker.networking.protocol.packets.settings.SettingsPacketHandler;
   import scpacker.networking.protocol.packets.settings.CloseSettingsInPacket;
   import scpacker.networking.protocol.packets.settings.CloseSettingsOutPacket;
   import scpacker.networking.protocol.packets.settings.LoadSettingsOutPacket;
   import scpacker.networking.protocol.packets.settings.OpenSettingsInPacket;
   import scpacker.networking.protocol.packets.usercountry.UserCountryPacketHandler;
   import scpacker.networking.protocol.packets.usercountry.ChangeLocationOutPacket;
   import scpacker.networking.protocol.packets.usercountry.CheckUserPaymentCountryOutPacket;
   import scpacker.networking.protocol.packets.usercountry.LoadUserCountryModelInPacket;
   import scpacker.networking.protocol.packets.usercountry.RequestUserCountryInPacket;
   import scpacker.networking.protocol.packets.usercountry.ShowPaymentWindowInPacket;
   import scpacker.networking.protocol.packets.inventory.InventoryPacketHandler;
   import scpacker.networking.protocol.packets.inventory.InventoryItemActivatedInPacket;
   import scpacker.networking.protocol.packets.inventory.InventoryItemActivateOutPacket;
   import scpacker.networking.protocol.packets.inventory.InventoryUpdateCountInPacket;
   import scpacker.networking.protocol.packets.inventory.LoadInventoryInPacket;
   import scpacker.networking.protocol.packets.missions.MissionPacketHandler;
   import scpacker.networking.protocol.packets.missions.TakePrizeOutPacket;
   import scpacker.networking.protocol.packets.missions.SkipQuestForFreeOutPacket;
   import scpacker.networking.protocol.packets.missions.SkipQuestForCrystalsOutPacket;
   import scpacker.networking.protocol.packets.missions.OpenQuestWindowOutPacket;
   import scpacker.networking.protocol.packets.missions.NotifyDailyQuestChangesViewedOutPacket;
   import scpacker.networking.protocol.packets.missions.NotifyDailyQuestCompletedInPacket;
   import scpacker.networking.protocol.packets.missions.NotifyDailyQuestGeneratedInPacket;
   import scpacker.networking.protocol.packets.missions.ShowQuestWindowInPacket;
   import scpacker.networking.protocol.packets.missions.ShowQuestWindowWithoutDailyQuestsInPacket;
   import scpacker.networking.protocol.packets.missions.SkipDailyQuestInPacket;
   import scpacker.networking.protocol.packets.missions.TakeDailyQuestPrizeInPacket;

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

         // LoginByHash Packets
         packetInvoker.registerPacketHandler(new LoginByHashPacketHandler());
         packetRegistry.registerPacket(new LoginByHashFailedInPacket());
         packetRegistry.registerPacket(new LoginByHashOutPacket());
         packetRegistry.registerPacket(new RememberUserHashInPakcet());

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

         // BattleList Packets
         packetInvoker.registerPacketHandler(new BattleListPacketHandler());
         packetRegistry.registerPacket(new BattleCreatedInPacket());
         packetRegistry.registerPacket(new LoadAllBattlesInPacket());
         packetRegistry.registerPacket(new RemoveBattleInPacket());
         packetRegistry.registerPacket(new SelectBattleInOutPacket());
         packetRegistry.registerPacket(new UnloadBattleSelectSpaceInPacket());

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
         packetRegistry.registerPacket(new JoinBattleOutPacket());
         packetRegistry.registerPacket(new SpectateBattleOutPacket());

         // BattleItem Packets
         packetInvoker.registerPacketHandler(new BattleItemPacketHandler());
         packetRegistry.registerPacket(new ItemBattleMadePrivateInPacket());
         packetRegistry.registerPacket(new ItemLeftDmBattleInPacket());
         packetRegistry.registerPacket(new ItemLeftTeamBattleInPacket());
         packetRegistry.registerPacket(new ItemJoinedDmBattleInPacket());
         packetRegistry.registerPacket(new ItemJoinedTeamBattleInPacket());
         packetRegistry.registerPacket(new ItemSwapTeamsInPacket());
         packetRegistry.registerPacket(new ItemUpdateBattleNameInPacket());
         packetRegistry.registerPacket(new ItemUpdateBattleSuspicionInPacket());

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
         packetRegistry.registerPacket(new MountItemOutPacket());
         packetRegistry.registerPacket(new BuyKitOutPacket());
         packetRegistry.registerPacket(new BuyMultipleItemsOutPacket());
         packetRegistry.registerPacket(new FitItemOutPacket());
         packetRegistry.registerPacket(new GarageEasterEggOutPacket());
         packetRegistry.registerPacket(new RemovePresentOutPacket());
         packetRegistry.registerPacket(new RenameOutPacket());

         // TimeChecker Packets
         packetInvoker.registerPacketHandler(new TimeCheckerPacketHandler());
         packetRegistry.registerPacket(new TimeCheckerPingInPacket());
         packetRegistry.registerPacket(new TimeCheckerPongOutPacket());

         // Battle Packets
         packetInvoker.registerPacketHandler(new BattlePacketHandler());
         packetRegistry.registerPacket(new InitBattleInPacket());
         packetRegistry.registerPacket(new CreateTankInPacket());
         packetRegistry.registerPacket(new InitializeSupplyEffectsInPacket());
         packetRegistry.registerPacket(new InitBonusBoxesInPacket());
         packetRegistry.registerPacket(new AddBonusBoxesInPacket());
         packetRegistry.registerPacket(new AddBonusBoxInPacket());
         packetRegistry.registerPacket(new RemoveBonusBoxInPacket());
         packetRegistry.registerPacket(new TakeBonusBoxInPacket());
         packetRegistry.registerPacket(new UnloadBattleSpaceInPacket());
         packetRegistry.registerPacket(new CollectBonusBoxOutPacket());

         // BattleStatistics Packets
         packetInvoker.registerPacketHandler(new BattleStatisticsPacketHandler());
         packetRegistry.registerPacket(new BattleFundInPacket());
         packetRegistry.registerPacket(new InitStatisticsInPacket());
         packetRegistry.registerPacket(new StatisticsModelLoadedPostInPacket());
         packetRegistry.registerPacket(new ComplaintConfirmedInPacket());
         packetRegistry.registerPacket(new RankUpInPacket());
         packetRegistry.registerPacket(new RoundFinishInPacket());
         packetRegistry.registerPacket(new RoundStartInPacket());
         packetRegistry.registerPacket(new StatusProbablyCheaterChangedInPacket());

         // StatisticsDM Packets
         packetInvoker.registerPacketHandler(new StatisticsDmPacketHandler());
         packetRegistry.registerPacket(new ChangeUserStatInPacket());
         packetRegistry.registerPacket(new InitDMStatisticsInPacket());
         packetRegistry.registerPacket(new RefreshUsersStatInPacket());
         packetRegistry.registerPacket(new DmStatisticsUserConnectInPacket());
         packetRegistry.registerPacket(new DmStatisticsUserDisconnectInPacket());

         // StatisticsTeam Packets
         packetInvoker.registerPacketHandler(new StatisticsTeamPacketHandler());
         packetRegistry.registerPacket(new StatisticsTeamChangeTeamScoreInPacket());
         packetRegistry.registerPacket(new StatisticsTeamChangeUserStatInPacket());
         packetRegistry.registerPacket(new InitStatisticsTeamModelInPacket());
         packetRegistry.registerPacket(new StatisticsTeamSwapTeamInPacket());
         packetRegistry.registerPacket(new StatisticsTeamUserConnectInPacket());
         packetRegistry.registerPacket(new StatisticsTeamUserLeftInPacket());

         // Dm Packets
         packetInvoker.registerPacketHandler(new DmPacketHandler());
         packetRegistry.registerPacket(new LoadDmModelPostInPacket());

         // Tdm Packets
         packetInvoker.registerPacketHandler(new TdmPacketHandler());
         packetRegistry.registerPacket(new LoadTdmPostInPacket());

         // TurretData Packets
         packetInvoker.registerPacketHandler(new TurretDataPacketHandler());
         packetRegistry.registerPacket(new LoadTurretDataInPacket());

         // Tank Packets
         packetInvoker.registerPacketHandler(new TankPacketHandler());
         packetRegistry.registerPacket(new ActivateTankInPacket());
         packetRegistry.registerPacket(new ActivateEffectInPacket());
         packetRegistry.registerPacket(new StopEffectInPacket());
         packetRegistry.registerPacket(new KillTankInPacket());
         packetRegistry.registerPacket(new MoveAndSetTurretStateInPacket());
         packetRegistry.registerPacket(new MoveTankInPacket());
         packetRegistry.registerPacket(new MovementControlInPacket());
         packetRegistry.registerPacket(new PrepareToSpawnInPacket());
         packetRegistry.registerPacket(new RotateTurretInPacket());
         packetRegistry.registerPacket(new SetTankHealthInPacket());
         packetRegistry.registerPacket(new SetSpecificationInPacket());
         packetRegistry.registerPacket(new SetTankTemperatureInPacket());
         packetRegistry.registerPacket(new SpawnTankInPacket());
         packetRegistry.registerPacket(new UnloadTankInPacket());
         packetRegistry.registerPacket(new ClientMoveOutPacket());
         packetRegistry.registerPacket(new ClientMoveTankAndTurretOutPacket());
         packetRegistry.registerPacket(new ClientRotateTurretOutPacket());
         packetRegistry.registerPacket(new ReadyToSpawnEndOutPacket());
         packetRegistry.registerPacket(new ActivateTankOutPacket());
         packetRegistry.registerPacket(new MovementControlOutPacket());
         packetRegistry.registerPacket(new ReadyToPlaceOutPacket());

         // Flamethrower Packets
         packetInvoker.registerPacketHandler(new FlamethrowerPacketHandler());
         packetRegistry.registerPacket(new FlamethrowerStartFireInPacket());
         packetRegistry.registerPacket(new FlamethrowerStopFireInPacket());
         packetRegistry.registerPacket(new FlamethrowerStartOutPacket());
         packetRegistry.registerPacket(new FlamethrowerStopOutPacket());
         packetRegistry.registerPacket(new FlamethrowerHitOutPacket());

         // Smoky Packets
         packetInvoker.registerPacketHandler(new SmokyPacketHandler());
         packetRegistry.registerPacket(new SmokyLocalCriticalHitInPacket());
         packetRegistry.registerPacket(new SmokyShootInPacket());
         packetRegistry.registerPacket(new SmokyShootStaticInPacket());
         packetRegistry.registerPacket(new SmokyShootTargetInPacket());
         packetRegistry.registerPacket(new SmokyFireOutPacket());
         packetRegistry.registerPacket(new SmokyFireStaticOutPacket());
         packetRegistry.registerPacket(new SmokyFireTargetOutPacket());

         // DamageIndicator Packets
         packetInvoker.registerPacketHandler(new DamageIndicatorPacketHandler());
         packetRegistry.registerPacket(new ShowDamageForShooterInPacket());

         // ControlPoints Packets
         packetInvoker.registerPacketHandler(new ControlPointsPacketHandler());
         packetRegistry.registerPacket(new LoadControlPointsCCInPacket());
         packetRegistry.registerPacket(new PointCaptureStartedInPacket());
         packetRegistry.registerPacket(new PointCaptureStoppedInPacket());
         packetRegistry.registerPacket(new SetPointProgressInPacket());
         packetRegistry.registerPacket(new SetPointStateInPacket());
         packetRegistry.registerPacket(new TankEnteredPointZoneInPacket());
         packetRegistry.registerPacket(new TankLeftPointZoneInPacket());

         // BattleChat Packets
         packetInvoker.registerPacketHandler(new BattleChatPacketHandler());
         packetRegistry.registerPacket(new ReceiveBattleChatInPacket());
         packetRegistry.registerPacket(new AddSpectatorTeamMessageInPacket());
         packetRegistry.registerPacket(new ReceiveBattleSystemChatInPacket());
         packetRegistry.registerPacket(new AddTeamMessageInPacket());
         packetRegistry.registerPacket(new BattleChatLoadedInPacket());
         packetRegistry.registerPacket(new BattleChatUpdateTeamHeaderInPacket());
         packetRegistry.registerPacket(new SendBattleChatOutPacket());

         // Chat Packets
         packetInvoker.registerPacketHandler(new ChatPacketHandler());
         packetRegistry.registerPacket(new CleanUsersMessagesInPacket());
         packetRegistry.registerPacket(new ClearAllMessagesInPacket());
         packetRegistry.registerPacket(new LoadChatModelInPacket());
         packetRegistry.registerPacket(new SendMessageOutPacket());
         packetRegistry.registerPacket(new ShowMessagesInPacket());
         packetRegistry.registerPacket(new UnloadChatInPacket());
         packetRegistry.registerPacket(new UpdateTypingAntifloodParamsInPacket());

         // CaptureTheFlag Packets
         packetInvoker.registerPacketHandler(new CaptureTheFlagPacketHandler());
         packetRegistry.registerPacket(new DropFlagInPacket());
         packetRegistry.registerPacket(new FlagDeliveredInPacket());
         packetRegistry.registerPacket(new FlagTakenInPacket());
         packetRegistry.registerPacket(new LoadCaptureTheFlagCCInPacket());
         packetRegistry.registerPacket(new ReturnFlagToBaseInPacket());
         packetRegistry.registerPacket(new DropFlagOutPacket());

         // BattleMine Packets
         packetInvoker.registerPacketHandler(new BattleMinePacketHandler());
         packetRegistry.registerPacket(new ActivateMineInPacket());
         packetRegistry.registerPacket(new ExplodeMineInPacket());
         packetRegistry.registerPacket(new LoadBattleMinesCCInPacket());
         packetRegistry.registerPacket(new PutMineInPacket());
         packetRegistry.registerPacket(new RemoveMinesInPacket());

         // SelfDestruct Packets
         packetInvoker.registerPacketHandler(new SelfDestructPacketHandler());
         packetRegistry.registerPacket(new SuicideInPacket());
         packetRegistry.registerPacket(new SuicideOutPacket());

         // TankReloader Packets
         packetInvoker.registerPacketHandler(new TankReloaderPacketHandler());
         packetRegistry.registerPacket(new TankReloaderDieInPacket());
         packetRegistry.registerPacket(new TankReloaDeathScheduledInPacket());
         packetRegistry.registerPacket(new ReloadTankInPacket());

         // Twins Packets
         packetInvoker.registerPacketHandler(new TwinsPacketHandler());
         packetRegistry.registerPacket(new TwinsShootTargetIn());
         packetRegistry.registerPacket(new TwinsFireDummyIn());

         // Railgun Packets
         packetInvoker.registerPacketHandler(new RailgunPacketHandler());
         packetRegistry.registerPacket(new RailgunFireDummyInPacket());
         packetRegistry.registerPacket(new RailgunShootTargetInPacket());
         packetRegistry.registerPacket(new RailgunStartChargingInPacket());
         packetRegistry.registerPacket(new RailgunFireDummyOutPacket());
         packetRegistry.registerPacket(new RailgunFireOutPacket());
         packetRegistry.registerPacket(new RailgunStartChargingOutPacket());

         // Isida Packets
         packetInvoker.registerPacketHandler(new IsidaPacketHandler());
         packetRegistry.registerPacket(new ResetIsidaTargetInPacket());
         packetRegistry.registerPacket(new SetIsidaTargetInPacket());
         packetRegistry.registerPacket(new StopIsidaInPacket());
         packetRegistry.registerPacket(new IsidaResetTargetOutPacket());
         packetRegistry.registerPacket(new IsidaSetTargetOutPacket());
         packetRegistry.registerPacket(new IsidaStopOutPacket());
         packetRegistry.registerPacket(new IsidaTickOutPacket());

         // Thunder Packets
         packetInvoker.registerPacketHandler(new ThunderPacketHandler());
         packetRegistry.registerPacket(new ThunderShootInPacket());
         packetRegistry.registerPacket(new ThunderShootStaticInPacket());
         packetRegistry.registerPacket(new ThunderShootTargetInPacket());
         packetRegistry.registerPacket(new ThunderShootOutPacket());
         packetRegistry.registerPacket(new ThunderShootStaticOutPacket());
         packetRegistry.registerPacket(new ThunderShootTargetOutPacket());

         // Shotgun Packets
         packetInvoker.registerPacketHandler(new ShotGunPacketHandler());
         packetRegistry.registerPacket(new ShotgunShootInPacket());
         packetRegistry.registerPacket(new ShotgunShotOutPacket());
         packetRegistry.registerPacket(new ShotgunTryDummyShootOutPacket());

         // Freeze Packets
         packetInvoker.registerPacketHandler(new FreezePacketHandler());
         packetRegistry.registerPacket(new FreezeStartInPacket());
         packetRegistry.registerPacket(new FreezeStopInPacket());
         packetRegistry.registerPacket(new FreezeDamageOutPacket());
         packetRegistry.registerPacket(new FreezeStopOutPacket());
         packetRegistry.registerPacket(new FreezeStartOutPacket());

         // Ricochet Packets
         packetInvoker.registerPacketHandler(new RicochetPacketHandler());
         packetRegistry.registerPacket(new RicochetFireDummyInPacket());
         packetRegistry.registerPacket(new RicochetShootTargetInPacket());
         packetRegistry.registerPacket(new RicochetFireDummyOutPacket());
         packetRegistry.registerPacket(new RicochetFireOutPacket());
         packetRegistry.registerPacket(new RicochetHitStaticOutPacket());
         packetRegistry.registerPacket(new RicochetHitTargetOutPacket());

         // Shaft Packets
         packetInvoker.registerPacketHandler(new ShaftPacketHandler());
         packetRegistry.registerPacket(new ShaftActivateManualTargetingInPacket());
         packetRegistry.registerPacket(new ShaftActivateManualTargetingOutPacket());
         packetRegistry.registerPacket(new ShaftAimedShotOutPacket());
         packetRegistry.registerPacket(new ShaftLaserAimAtTankInPacket());
         packetRegistry.registerPacket(new ShaftLaserAimAtTankOutPacket());
         packetRegistry.registerPacket(new ShaftLaserHideInPacket());
         packetRegistry.registerPacket(new ShaftLaserHideOutPacket());
         packetRegistry.registerPacket(new ShaftLaserUpdateDirectionInPacket());
         packetRegistry.registerPacket(new ShaftLaserUpdateDirectionOutPacket());
         packetRegistry.registerPacket(new ShaftQuickShotOutPacket());
         packetRegistry.registerPacket(new ShaftScopeInitOutPacket());
         packetRegistry.registerPacket(new ShaftShootTargetInPacket());
         packetRegistry.registerPacket(new ShaftStopManualTargetingInPacket());
         packetRegistry.registerPacket(new ShaftStopManualTargetingOutPacket());

         // MachineGun Packets
         packetInvoker.registerPacketHandler(new MachineGunPacketHandler());
         packetRegistry.registerPacket(new MachineGunHitInPacket());
         packetRegistry.registerPacket(new MachineGunStartFireInPacket());
         packetRegistry.registerPacket(new MachineGunStartFireOutPacket());
         packetRegistry.registerPacket(new MachineGunStopFireInPacket());
         packetRegistry.registerPacket(new MachineGunStopFireOutPacket());
         packetRegistry.registerPacket(new MachineGunUpdateDirectionOutPacket());
         packetRegistry.registerPacket(new MachineGunUpdateTargetsOutPacket());

         // BonusRegion Packets
         packetInvoker.registerPacketHandler(new BonusRegionPacketHandler());
         packetRegistry.registerPacket(new HideDropZoneInPacket());
         packetRegistry.registerPacket(new LoadBonusRegionsModelInPacket());
         packetRegistry.registerPacket(new ShowDropZoneInPacket());

         // Gold Packets
         packetInvoker.registerPacketHandler(new GoldPacketHandler());
         packetRegistry.registerPacket(new GoldTakenInPacket());
         packetRegistry.registerPacket(new NotificationBonusContainsUidInPacket());
         packetRegistry.registerPacket(new NotificationBonusInPacket());

         // Friends Packets
         packetInvoker.registerPacketHandler(new FriendsPacketHandler());
         packetRegistry.registerPacket(new LoadFriendsListInPacket());
         packetRegistry.registerPacket(new OutgoingOnAddingInPacket());
         packetRegistry.registerPacket(new AcceptIncomingFriendInPacket());
         packetRegistry.registerPacket(new IncomingOnAddingInPacket());
         packetRegistry.registerPacket(new AlreadyInAcceptedFriendsInPacket());
         packetRegistry.registerPacket(new AlreadyInIncomingFriendsInPacket());
         packetRegistry.registerPacket(new AlreadyInOutgoingFriendsInPacket());
         packetRegistry.registerPacket(new FriendsAcceptedOnRemoveInPacket());
         packetRegistry.registerPacket(new FriendsIncomingOnRemoveInPacket());
         packetRegistry.registerPacket(new FriendsOutgoingOnRemoveInPacket());
         packetRegistry.registerPacket(new FriendsAcceptedNotificatorOnRemoveInPacket());
         packetRegistry.registerPacket(new FriendsIncomingNotificatorOnRemoveInPacket());
         packetRegistry.registerPacket(new FriendsOnUsersLoadedInPacket());
         packetRegistry.registerPacket(new FriendsUidExistInPacket());
         packetRegistry.registerPacket(new FriendsUidNotExistInPacket());
         packetRegistry.registerPacket(new AcceptFriendInviteOutPacket());
         packetRegistry.registerPacket(new AddFriendOutPacket());
         packetRegistry.registerPacket(new CheckFriendOutPacket());
         packetRegistry.registerPacket(new RevokeFriendOutPacket());
         packetRegistry.registerPacket(new RejectFriendInviteOutPacket());
         packetRegistry.registerPacket(new RemoveAcceptedFriendOutPacket());
         packetRegistry.registerPacket(new RemoveIncomingFriendOutPacket());
         packetRegistry.registerPacket(new RemoveOutgoingFriendOutPacket());
         packetRegistry.registerPacket(new FriendsLoadOutPacket());
         packetRegistry.registerPacket(new NotifyAcceptedFriendOutPacket());
         packetRegistry.registerPacket(new BattleKickReasonInPacket());

         // Settings Packets
         packetInvoker.registerPacketHandler(new SettingsPacketHandler());
         packetRegistry.registerPacket(new OpenSettingsInPacket());
         packetRegistry.registerPacket(new CloseSettingsInPacket());
         packetRegistry.registerPacket(new CloseSettingsOutPacket());
         packetRegistry.registerPacket(new LoadSettingsOutPacket());

         // UserCountry Packets
         packetInvoker.registerPacketHandler(new UserCountryPacketHandler());
         packetRegistry.registerPacket(new LoadUserCountryModelInPacket());
         packetRegistry.registerPacket(new RequestUserCountryInPacket());
         packetRegistry.registerPacket(new ShowPaymentWindowInPacket());
         packetRegistry.registerPacket(new ChangeLocationOutPacket());
         packetRegistry.registerPacket(new CheckUserPaymentCountryOutPacket());

         // Inventory Packets
         packetInvoker.registerPacketHandler(new InventoryPacketHandler());
         packetRegistry.registerPacket(new InventoryItemActivatedInPacket());
         packetRegistry.registerPacket(new InventoryItemActivateOutPacket());
         packetRegistry.registerPacket(new InventoryUpdateCountInPacket());
         packetRegistry.registerPacket(new LoadInventoryInPacket());

         // Mission Packets
         packetInvoker.registerPacketHandler(new MissionPacketHandler());
         packetRegistry.registerPacket(new TakePrizeOutPacket());
         packetRegistry.registerPacket(new SkipQuestForFreeOutPacket());
         packetRegistry.registerPacket(new SkipQuestForCrystalsOutPacket());
         packetRegistry.registerPacket(new OpenQuestWindowOutPacket());
         packetRegistry.registerPacket(new NotifyDailyQuestChangesViewedOutPacket());
         packetRegistry.registerPacket(new NotifyDailyQuestCompletedInPacket());
         packetRegistry.registerPacket(new NotifyDailyQuestGeneratedInPacket());
         packetRegistry.registerPacket(new ShowQuestWindowInPacket());
         packetRegistry.registerPacket(new ShowQuestWindowWithoutDailyQuestsInPacket());
         packetRegistry.registerPacket(new SkipDailyQuestInPacket());
         packetRegistry.registerPacket(new TakeDailyQuestPrizeInPacket());
      }
   }
}

