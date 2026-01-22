package scpacker.networking.protocol
{
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;
   import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorType;
   import projects.tanks.client.achievements.model.Achievement;
   import projects.tanks.client.commons.models.captcha.CaptchaLocation;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
   import platform.client.models.commons.types.ValidationStatus;
   import projects.tanks.client.battleservice.EquipmentConstraintsMode;
   import projects.tanks.client.battleservice.BattleMode;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import projects.tanks.client.battleservice.model.map.params.MapTheme;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import projects.tanks.client.battleselect.model.item.BattleSuspicionLevel;
   import projects.tanks.client.commons.models.layout.LayoutState;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import scpacker.networking.Network;
   import scpacker.networking.protocol.codec.*;
   import scpacker.networking.protocol.codec.complex.ByteArrayCodec;
   import scpacker.networking.protocol.codec.custom.*;
   import scpacker.networking.protocol.codec.primitive.*;
   import scpacker.networking.protocol.protection.IProtection;
   import scpacker.networking.protocol.protection.XorProtection;
   import scpacker.networking.protocol.protection.EmptyProtection;
   import scpacker.networking.protocol.packets.init.SetClientLangOutPacket;
   
   public class ProtocolInitializer
   {
      private var newname_11956__END:Dictionary = new Dictionary();
      
      private var protection:IProtection = new EmptyProtection();
      
      public function ProtocolInitializer()
      {
         super();
         this.addCodec(new BooleanCodec());
         this.addCodec(new ByteCodec());
         this.addCodec(new VectorCodecByte());
         this.addCodec(new FloatCodec());
         this.addCodec(new IntCodec());
         this.addCodec(new DoubleCodec());
         this.addCodec(new ShortCodec());
         this.addCodec(new StringCodec());
         this.addCodec(new LongCodec());
         this.addCodec(new ByteArrayCodec());
         this.addCodec(new CodecImagePair(this));
         this.addCodec(new CodecStringPair(this));
         this.addCodec(new CodecLocalizedFileFormat(this));
      }
      
      public function init() : void
      {
         this.addCodec(new ResourceGetterCodec(this,ResourceRegistry(OSGi.getInstance().getService(ResourceRegistry))));
         this.addEnumCodec("CaptchaLocationCodec",CaptchaLocation);
         this.addCodec(new CodecUserPropertiesCC(this));
         this.addCodec(new CodecPremiumAccountAlertCC(this));
         this.addCodec(new CodecPremiumNotifierCC(this));
         this.addEnumCodec("CodecLayoutState",LayoutState);
         this.addCodec(new CodecUserContainerCC(this));
         this.addEnumCodec("CodecBattleMode",BattleMode);
         this.addCodec(new CodecBattleInviteMessage(this));
         this.addCodec(new CodecDailyQuestPrizeInfo(this));
         this.addCodec(new CodecDailyQuestInfo(this));
         this.addCodec(new CodecWeeklyQuestDescription(this));
         this.addCodec(new CodecWeeklyQuestRewardItem(this));
         this.addCodec(new CodecRange(this));
         this.addCodec(new CodecBattleInfoData(this));
         this.addCodec(new CodecPremiumNotifierData(this));
         this.addCodec(new CodecOnlineNotifierData(this));
         this.addCodec(new CodecRankNotifierData(this));
         this.addCodec(new CodecUidNotifierData(this));
         this.addCodec(new CodecBattleNotifierData(this));
         this.addCodec(new CodecBonusInfoCC(this));
         this.addCodec(new CodecSocialNetworkPanelParams(this));
         this.addCodec(new CodecSocialNetworkPanelCC(this));
         this.addEnumCodec("CodecItemCategoryEnum",ItemCategoryEnum);
         this.addEnumCodec("CodecItemViewCategoryEnum",ItemViewCategoryEnum);
         this.addCodec(new CodecGarageItemInfo(this));
         this.addEnumCodec("CodecChatModeratorLevel",ChatModeratorLevel);
         this.addCodec(new CodecUserStatus(this));
         this.addCodec(new CodecChatMessage(this));
         this.addCodec(new CodecChatCC(this));
         this.addCodec(new CodecBattleLimits(this));
         this.addEnumCodec("CodecMapTheme",MapTheme);
         this.addEnumCodec("CodecEquipmentConstraintsMode",EquipmentConstraintsMode);
         this.addCodec(new CodecBattleCreateParameters(this));
         this.addEnumCodec("CodecBattleTeam",BattleTeam);
         this.addCodec(new CodecBattleInfoUser(this));
         this.addEnumCodec("CodecValidationStatus",ValidationStatus);
         this.addCodec(new CodecStatisticsModelCC(this));
         this.addCodec(new CodecVector3d(this));
         this.addCodec(new CodecMoveCommand(this));
         this.addCodec(new CodecUserInfo(this));
         this.addCodec(new CodecStatisticsTeamCC(this));
         this.addCodec(new CodecRotateTurretCommand(this));
         this.addCodec(new CodecClientFlag(this));
         this.addCodec(new CodecCaptureTheFlagSoundFX(this));
         this.addCodec(new CodecCaptureTheFlagCC(this));
         this.addEnumCodec("CodecDamageIndicatorType",DamageIndicatorType);
         this.addCodec(new CodecTargetTankDamage(this));
         this.addCodec(new CodecUserStat(this));
         this.addCodec(new CodecBonusSpawnData(this));
         this.addEnumCodec("CodecControlPointState",ControlPointState);
         this.addCodec(new CodecClientPointData(this));
         this.addCodec(new CodecDominationResources(this));
         this.addCodec(new CodecDominationSounds(this));
         this.addCodec(new CodecControlPointsCC(this));
         this.addCodec(new CodecBattleMine(this));
         this.addCodec(new CodecBattleMineCC(this));
         this.addCodec(new CodecStatisticsDMCC(this));
         this.addEnumCodec("CodecIsisState",IsisState);
         this.addCodec(new CodecTankUsersRegistry(this));
         this.addCodec(new CodecUserReward(this));
         this.addEnumCodec("CodecAchievement",Achievement);
         this.addCodec(new CodecAchievementCC(this));
         this.addCodec(new CodecNewsItemCC(this));
         this.addCodec(new CodecNewsShowingCC(this));
         this.addCodec(new CodecTargetPosition(this));
         this.addCodec(new CodecAssaultBase(this));
         this.addCodec(new CodecAssaultSoundFX(this));
         this.addCodec(new CodecClientAssaultFlag(this));
         this.addCodec(new CodecAssaultCC(this));
         this.addEnumCodec("CodecBattleSuspicionLevel",BattleSuspicionLevel);
         this.addCodec(new CodecBattleInviteCC(this));
         this.addCodec(new CodecTipItemCC(this));
         this.addCodec(new CodecSocialNetworkEntranceParams(this));
         this.addCodec(new CodecCountryInfo(this));
         this.addCodec(new CodecUserCountryCC(this));
         this.addCodec(new CodecReferrerIncomeData(this));
         this.addCodec(new CodecVectorReferrerIncomeData(this));
         this.addCodec(new CodecReferrerPanelCC(this));
         this.addCodec(new CodecShellState(this));
         this.addCodec(new CodecShellHit(this));
         this.addEnumCodec("CodecBonusType",BonusesType);
         this.addCodec(new CodecBonusRegionResource(this));
         this.addCodec(new CodecBonusRegionData(this));
         this.addCodec(new CodecBonusRegionsCC(this));
         this.addCodec(new CodecTargetHit(this));
      }
      
      public function InitializeProtection(param1:Vector.<int>) : void
      {
         this.protection = new XorProtection(param1);
         var _loc2_:OSGi = OSGi.getInstance();
         Network(_loc2_.getService(Network)).send(new SetClientLangOutPacket(ILocaleService(_loc2_.getService(ILocaleService)).language));
      }
      
      public function getProtection() : IProtection
      {
         return this.protection;
      }
      
      public function reset() : void
      {
         this.protection = new EmptyProtection();
      }
      
      private function addCodec(param1:ICodec) : void
      {
         this.newname_11956__END[getQualifiedClassName(param1).replace("::",".")] = param1;
      }
      
      private function addEnumCodec(param1:String, param2:Class) : void
      {
         this.newname_11956__END["scpacker.networking.protocol.codec.custom." + param1] = new EnumCodec(param2);
      }
      
      public function getCodec(param1:String) : ICodec
      {
         var _loc4_:String = null;
         var _loc3_:* = undefined;
         var _loc2_:ICodec = this.newname_11956__END[param1];
         if(_loc2_ == null && param1.indexOf(".VectorCodec") != -1)
         {
            _loc4_ = param1.replace(".Vector",".");
            _loc3_ = this.getCodec(_loc4_);
            if(_loc3_ == undefined)
            {
               _loc4_ = _loc4_.replace("Codec","") + "Codec";
               _loc3_ = this.getCodec(_loc4_);
               if(_loc3_ == undefined)
               {
                  _loc4_ = _loc4_.replace("custom","primitive");
                  _loc3_ = this.getCodec(_loc4_);
                  if(_loc3_ == undefined)
                  {
                     _loc3_ = this.getCodec(_loc4_.replace("complex","primitive"));
                  }
               }
            }
            _loc2_ = new VectorCodec(_loc3_,_loc3_.element,_loc3_.optionalVector);
            this.newname_11956__END[param1] = _loc2_;
         }
         return _loc2_;
      }
   }
}

