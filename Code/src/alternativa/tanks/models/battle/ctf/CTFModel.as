package alternativa.tanks.models.battle.ctf
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.commonflag.CommonFlag;
   import alternativa.tanks.models.battle.commonflag.Flag;
   import alternativa.tanks.models.battle.commonflag.FlagNotification;
   import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;
   import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizer;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator.FlagIndicator;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
   import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
   import flash.media.Sound;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
   import projects.tanks.client.battlefield.models.battle.pointbased.ctf.CaptureTheFlagModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.ctf.CaptureTheFlagSoundFX;
   import projects.tanks.client.battlefield.models.battle.pointbased.ctf.ICaptureTheFlagModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class CTFModel extends CaptureTheFlagModelBase implements ICaptureTheFlagModelBase, IFlagModeInitilizer, FlagNotification, ObjectLoadListener, BattleModel
   {
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var userInfoService:BattleUserInfoService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      private var guiModel:BattlefieldGUI;
      
      private var flagDropSound:Sound;
      
      private var flagReturnSound:Sound;
      
      private var flagTakeSound:Sound;
      
      private var winSound:Sound;
      
      private var markers:CTFHudIndicators;
      
      private var flagMessages:CTFMessages = new CTFMessages();
      
      public function CTFModel()
      {
         super();
      }
      
      public function getBattleType() : BattleType
      {
         return BattleType.CTF;
      }
      
      public function objectLoaded() : void
      {
         this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
         this.flagMessages.init(this.guiModel);
         var _loc1_:CaptureTheFlagSoundFX = getInitParam().sounds;
         this.flagDropSound = _loc1_.flagDropSound.sound;
         this.flagReturnSound = _loc1_.flagReturnSound.sound;
         this.flagTakeSound = _loc1_.flagTakeSound.sound;
         this.winSound = _loc1_.winSound.sound;
      }
      
      public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void
      {
         var _loc3_:ICommonFlagModeModel = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel));
         var _loc4_:Object3D = _loc3_.createBasePoint(param2[0],getInitParam().redPedestalModel);
         var _loc5_:Object3D = _loc3_.createBasePoint(param2[1],getInitParam().bluePedestalModel);
         var _loc6_:Flag = new Flag(param2[0].id,param2[0].flagBasePosition,BattleTeam.RED,getInitParam().redFlagSprite);
         var _loc7_:Flag = new Flag(param2[1].id,param2[1].flagBasePosition,BattleTeam.BLUE,getInitParam().blueFlagSprite);
         this.markers = new CTFHudIndicators(_loc6_,_loc4_,_loc7_,_loc5_);
         battleService.getBattleScene3D().addRenderer(this.markers);
         _loc3_.initFlag(_loc6_,param1[0]);
         _loc3_.initFlag(_loc7_,param1[1]);
         this.initIndicatorState(_loc6_);
         this.initIndicatorState(_loc7_);
      }
      
      private function initIndicatorState(param1:Flag) : void
      {
         switch(param1.state)
         {
            case FlagState.CARRIED:
               this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_BLINK);
               this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_CARRIED);
               break;
            case FlagState.DROPPED:
               this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_EMPTY);
               this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DROPPED);
               break;
            case FlagState.EXILED:
            case FlagState.FLYING:
            case FlagState.AT_BASE:
            default:
               this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_DEFAULT);
               this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DEFAULT);
         }
      }
      
      public function guiShowFlagDropped(param1:CommonFlag) : void
      {
         this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_EMPTY);
         this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DROPPED);
      }
      
      public function guiShowFlagCarried(param1:CommonFlag) : void
      {
         this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_BLINK);
         this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_CARRIED);
      }
      
      public function guiShowFlagAtBase(param1:CommonFlag) : void
      {
         this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_DEFAULT);
         this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_OUT);
      }
      
      public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void
      {
         this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_BLINK);
         this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_CARRIED);
         var _loc3_:UserAction = param2.teamType == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_PICK_REDFLAG : UserAction.CTF_RED_PLAYER_PICK_BLUEFLAG;
         this.guiModel.showUserBattleLogMessage(param2.user.id,_loc3_);
         battleService.soundManager.playSound(this.flagTakeSound);
      }
      
      public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void
      {
         var _loc3_:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
         if(battleInfoService.isSpectatorMode())
         {
            this.showFlagReturnMessageForSpectator(param1.teamType,param2);
         }
         else if(Boolean(_loc3_) && Boolean(_loc3_.teamType))
         {
            this.showFlagReturnMessage(param1.teamType,param2);
         }
         battleService.soundManager.playSound(this.flagReturnSound);
      }
      
      private function showFlagReturnMessageForSpectator(param1:BattleTeam, param2:IGameObject) : void
      {
         var _loc3_:UserAction = null;
         if(Boolean(param2))
         {
            _loc3_ = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
            this.guiModel.showUserBattleLogMessage(param2.id,_loc3_);
         }
         else
         {
            _loc3_ = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
            this.guiModel.showBattleLogMessage(_loc3_);
         }
      }
      
      private function showFlagReturnMessage(param1:BattleTeam, param2:IGameObject) : void
      {
         var _loc4_:UserAction = null;
         var _loc3_:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
         if(Boolean(param2))
         {
            _loc4_ = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
            this.guiModel.showUserBattleLogMessage(param2.id,_loc4_);
         }
         else
         {
            _loc4_ = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
            this.guiModel.showBattleLogMessage(_loc4_);
         }
      }
      
      public function notifyFlagDropped(param1:CommonFlag) : void
      {
         this.showFlagDropMessage(param1);
         this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_EMPTY);
         this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DROPPED);
      }
      
      private function showFlagDropMessage(param1:CommonFlag) : void
      {
         var _loc2_:UserAction = null;
         if(param1.carrier == null)
         {
            return;
         }
         try
         {
            _loc2_ = param1.carrier.teamType == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_DROP_REDFLAG : UserAction.CTF_RED_PLAYER_DROP_BLUEFLAG;
            this.guiModel.showUserBattleLogMessage(param1.carrier.getUser().id,_loc2_);
            battleService.soundManager.playSound(this.flagDropSound);
         }
         catch(e:Error)
         {
         }
      }
      
      public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void
      {
         var _loc4_:FlagMessage = null;
         var _loc3_:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
         if(battleInfoService.isSpectatorMode())
         {
            _loc4_ = this.flagMessages.getFlagMessageForSpectator(CTFMessages.MESSAGE_CAPTURED,param2.teamType);
         }
         else
         {
            _loc4_ = this.flagMessages.getFlagMessage(CTFMessages.MESSAGE_CAPTURED,_loc3_.teamType == param2.teamType);
         }
         this.flagMessages.showBattleMessage(_loc4_,param2.getUser());
         var _loc5_:UserAction = param2.teamType == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_DELIVER_REDFLAG : UserAction.CTF_RED_PLAYER_DELIVER_BLUEFLAG;
         this.guiModel.showUserBattleLogMessage(param2.user.id,_loc5_);
         battleService.soundManager.playSound(this.winSound);
         this.guiModel.setIndicatorState(param1.teamType,FlagIndicator.STATE_DEFAULT);
         this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DEFAULT);
      }
      
      public function notifyFlagFacedOff(param1:CommonFlag) : void
      {
      }
      
      public function notifyReadyToFaceOff() : void
      {
      }
      
      public function notifyFlagThrown(param1:CommonFlag) : void
      {
      }
   }
}

