package alternativa.tanks.models.battle.ctf
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.CTFTargetEvaluator;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.BattleRestartEvent;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.events.death.TankDeadEvent;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.battlefield.mine.IBattleMinesModel;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.tdm.TDMHealingGunTargetEvaluator;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.weapon.ricochet.CTFRicochetTargetEvaluator;
   import alternativa.tanks.models.weapon.ricochet.RicochetTargetEvaluator;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.tanks.utils.GraphicsUtils;
   import alternativa.tanks.utils.KeyCodes;
   import alternativa.types.Long;
   import flash.display.BitmapData;
   import flash.events.KeyboardEvent;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.StubBitmapData;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagCC;
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagModelBase;
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagSoundFX;
   import projects.tanks.client.battlefield.models.battle.ctf.ClientFlag;
   import projects.tanks.client.battlefield.models.battle.ctf.ICaptureTheFlagModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator.FlagIndicator;
   import utils.TankNameGameObjectMapper;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
   import alternativa.utils.TextureMaterialRegistry;
   
   [ModelInfo]
   public class CTFModel extends CaptureTheFlagModelBase implements ICaptureTheFlagModelBase, ICTFModel, ObjectLoadPostListener, ObjectUnloadListener, BattleEventListener, BattleModel
   {
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var userInfoService:BattleUserInfoService;
      
      [Inject]
      public static var battleInputLockService:BattleInputService;
      
      public static const Z_DISPLACEMENT:Number = 80;
      
      private static const FLAG_FRAME_WIDTH:int = 128;
      
      private static const FLAG_FRAME_HEIGHT:int = 256;
      
      private static const KEY_DROP_FLAG:uint = KeyCodes.F;
      
      private static const FLAG_PICKUP_LOCK_DURATION:int = 5000;
      
      private static const MESSAGE_TAKEN:String = "taken";
      
      private static const MESSAGE_LOST:String = "lost";
      
      private static const MESSAGE_RETURNED:String = "returned";
      
      private static const MESSAGE_CAPTURED:String = "captured";
      
      private var dropCommandSent:Boolean;
      
      private var guiModel:BattlefieldGUI;
      
      private var battleMinesModel:IBattleMinesModel;
      
      private var inventoryModel:IInventoryModel;
      
      private var flags:Dictionary;
      
      private var defaultMessages:Object;
      
      private var spectatorRedMessages:Object;
      
      private var spectatorBlueMessages:Object;
      
      private var ourFlagReturnedMessage:String;
      
      private var enemyFlagReturnedMessage:String;
      
      private var blueFlagReturnedMessage:FlagMessage;
      
      private var redFlagReturnedMessage:FlagMessage;
      
      private var flagDropSound:Sound;
      
      private var flagReturnSound:Sound;
      
      private var flagTakeSound:Sound;
      
      private var winSound:Sound;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var loadedTanks:Dictionary;
      
      private var localTank:Tank;
      
      private var triggers:Vector.<FlagBaseTrigger>;
      
      private var targetEvaluators:Vector.<CTFTargetEvaluator>;
      
      public function CTFModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivated);
         this.battleEventSupport.addEventHandler(TankDeadEvent,this.onTankDeadEvent);
      }
      
      private static function createPedestal(param1:Tanks3DSResource) : Object3D
      {
         var _loc2_:Mesh = Mesh(param1.objects[0]);
         var _loc3_:BSP = new BSP();
         _loc3_.createTree(_loc2_);
         var _loc4_:BitmapData = param1.getTextureForObject(0);
         if(_loc4_ == null)
         {
            _loc4_ = new StubBitmapData(16776960);
         }
         var _loc5_:TextureMaterial = materialRegistry.getMaterial(_loc4_);
         _loc5_.resolution = _loc3_.calculateResolution(_loc4_.width,_loc4_.height);
         _loc3_.setMaterialToAllFaces(_loc5_);
         return _loc3_;
      }
      
      private static function createSpectatorMessages(param1:Object, param2:uint) : void
      {
         param1[MESSAGE_TAKEN] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_GOT_FLAG_NEUTRAL),param2);
         param1[MESSAGE_LOST] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_LOST_FLAG_NEUTRAL),param2);
         param1[MESSAGE_RETURNED] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_RETURNED_FLAG_NEUTRAL),param2);
         param1[MESSAGE_CAPTURED] = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_CAPTURED_FLAG_NEUTRAL),param2);
      }
      
      private static function getOppositeTeam(param1:BattleTeam) : BattleTeam
      {
         return param1 == BattleTeam.BLUE ? BattleTeam.RED : BattleTeam.BLUE;
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function getBattleType() : BattleType
      {
         return BattleType.CTF;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:CaptureTheFlagSoundFX = getInitParam().sounds;
         this.flagDropSound = _loc1_.flagDropSound.sound;
         this.flagReturnSound = _loc1_.flagReturnSound.sound;
         this.flagTakeSound = _loc1_.flagTakeSound.sound;
         this.winSound = _loc1_.winSound.sound;
         this.loadedTanks = new Dictionary();
         this.triggers = new Vector.<FlagBaseTrigger>();
         this.initMessages();
         this.inventoryModel = IInventoryModel(object.adapt(IInventoryModel));
         this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
         this.battleMinesModel = IBattleMinesModel(object.adapt(IBattleMinesModel));
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         this.battleEventSupport.activateHandlers();
         this.initTargetEvaluators();
         this.initFlagsState();
      }
      
      private function initFlagsState() : void
      {
         this.flags = new Dictionary();
         var _loc1_:CaptureTheFlagCC = getInitParam();
         this.initFlag(BattleTeam.RED,_loc1_.redFlag,_loc1_.redFlagSprite.data,_loc1_.redPedestalModel);
         this.initFlag(BattleTeam.BLUE,_loc1_.blueFlag,_loc1_.blueFlagSprite.data,_loc1_.bluePedestalModel);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:CTFFlag = null;
         display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         for each(_loc1_ in this.flags)
         {
            _loc1_.dispose();
         }
         this.flags = null;
         this.guiModel = null;
         this.localTank = null;
         this.loadedTanks = null;
         this.triggers = null;
         this.battleEventSupport.deactivateHandlers();
         this.targetEvaluators = null;
         battleService.setCommonTargetEvaluator(null);
         battleService.setHealingGunTargetEvaluator(null);
         battleService.setRailgunTargetEvaluator(null);
      }
      
      [Obfuscation(rename="false")]
      public function flagTaken(param1:String, param2:BattleTeam) : void
      {
         var _loc5_:CTFFlag = null;
         var _loc3_:CTFFlag = this.getThisFlag(param2);
         var _loc4_:Tank = this.loadedTanks[param1];
         if(this.localTank != null && this.localTank == _loc4_)
         {
            this.setLocalFlagCarrier(_loc3_,param1,_loc4_);
         }
         else
         {
            this.setRemoteFlagCarrier(_loc3_,param1,_loc4_);
         }
         if(this.localTank != null || Boolean(battleInfoService.isSpectatorMode()))
         {
            this.disableFlagPickup(_loc3_);
            if(_loc4_ == this.localTank && this.localTank != null)
            {
               _loc5_ = this.getThisFlag(this.localTank.teamType);
               if(_loc5_.carrier == null)
               {
                  this.enableFlagPickup(_loc5_);
               }
            }
            this.showFlagPickupMessage(_loc4_.getUserId(),param2);
            battleService.soundManager.playSound(this.flagTakeSound);
         }
         //this.guiModel.ctfShowFlagCarried(param2); // 2017 code
         this.guiModel.setIndicatorState(param2, FlagIndicator.STATE_BLINK);
      }
      
      private function showFlagPickupMessage(param1:String, param2:BattleTeam) : void
      {
         var _loc3_:FlagMessage = null;
         var _loc4_:Boolean = false;
         if(battleInfoService.isSpectatorMode())
         {
            _loc3_ = this.getFlagMessageForSpectator(MESSAGE_TAKEN,getOppositeTeam(param2));
         }
         else if(this.localTank.teamType != null)
         {
            _loc4_ = this.localTank.teamType != param2;
            _loc3_ = this.getFlagMessage(MESSAGE_TAKEN,_loc4_);
         }
         if(_loc3_ != null)
         {
            this.addCTFMessage(_loc3_,param1);

            //this.guiModel.logUserAction(param1.id,_loc3_.text,null); // 2017 code
            var userAction:UserAction = param2 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_PICK_REDFLAG : UserAction.CTF_RED_PLAYER_PICK_BLUEFLAG;
            this.guiModel.showUserBattleLogMessage(param1,userAction);
         }
      }
      
      [Obfuscation(rename="false")]
      public function returnFlagToBase(param1:BattleTeam, param2:IGameObject) : void
      {
         this.returnFlag(param1);
         if(battleInfoService.isSpectatorMode())
         {
            this.showFlagReturnMessageForSpectator(param1,param2);
         }
         else if(Boolean(this.localTank) && Boolean(this.localTank.teamType))
         {
            this.showFlagReturnMessage(param1,param2);
         }
         battleService.soundManager.playSound(this.flagReturnSound);
      }
      
      private function showFlagReturnMessageForSpectator(param1:BattleTeam, param2:IGameObject) : void
      {
         var _loc3_:UserAction = null;
         if(Boolean(param2))
         {
            _loc3_ = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
            this.guiModel.showUserBattleLogMessage(TankNameGameObjectMapper.getTankNameByGameObject(param2),_loc3_);
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
         if(Boolean(param2))
         {
            _loc4_ = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
            this.guiModel.showUserBattleLogMessage(TankNameGameObjectMapper.getTankNameByGameObject(param2),_loc4_);
         }
         else
         {
            _loc4_ = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
            this.guiModel.showBattleLogMessage(_loc4_);
         }
      }
      
      [Obfuscation(rename="false")]
      public function dropFlag(param1:Vector3d, param2:BattleTeam) : void
      {
         var _loc3_:CTFFlag = this.getThisFlag(param2);
         this.showFlagDropMessage(_loc3_);
         this.guiModel.setIndicatorState(_loc3_.teamType, FlagIndicator.STATE_EMPTY);
         this.setupAfterFlagDrop(_loc3_);
         _loc3_.dropAt(new Vector3(param1.x,param1.y,param1.z));
      }
      
      private function setupAfterFlagDrop(param1:CTFFlag) : void
      {
         var _loc2_:CTFFlag = null;
         if(this.localTank == null)
         {
            return;
         }
         if(param1.carrier == null)
         {
            return;
         }
         if(this.localTank.isSameTeam(param1.teamType))
         {
            this.setFlagCarrierForEvaluators(null);
         }
         if(param1.carrier == this.localTank)
         {
            if(this.dropCommandSent)
            {
               this.dropCommandSent = false;
               battleService.getBattleRunner().addLogicUnit(new FlagPickupTimeoutTask(this,getTimer() + FLAG_PICKUP_LOCK_DURATION));
            }
            _loc2_ = this.getOtherFlag(param1.teamType);
            if(_loc2_.state == CTFFlagState.AT_BASE)
            {
               this.disableFlagPickup(_loc2_);
            }
         }
         else
         {
            this.enableFlagPickup(param1);
         }
      }
      
      private function showFlagDropMessage(param1:CTFFlag) : void
      {
         var _loc2_:UserAction = null;
         if(param1.carrier == null)
         {
            return;
         }
         try
         {
            _loc2_ = param1.carrier.teamType == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_DROP_REDFLAG : UserAction.CTF_RED_PLAYER_DROP_BLUEFLAG;
            this.guiModel.showUserBattleLogMessage(param1.carrier.getUserId(),_loc2_);
            battleService.soundManager.playSound(this.flagDropSound);
         }
         catch(e:Error)
         {
         }
      }
      
      [Obfuscation(rename="false")]
      public function flagDelivered(team:BattleTeam, param2:String) : void
      {
         this.returnFlag(BattleUtils.getOtherTeam(team));

         var tank:Tank = this.loadedTanks[param2];
         var _loc4_:FlagMessage = null;
         if(battleInfoService.isSpectatorMode())
         {
            _loc4_ = this.getFlagMessageForSpectator(CTFMessages.MESSAGE_CAPTURED,team);
         }
         else
         {
            _loc4_ = this.getFlagMessage(CTFMessages.MESSAGE_CAPTURED,this.localTank.teamType == team);
         }
         this.addCTFMessage(_loc4_,tank.getUserId());
         var _loc5_:UserAction = team == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_DELIVER_REDFLAG : UserAction.CTF_RED_PLAYER_DELIVER_BLUEFLAG;
         this.guiModel.showUserBattleLogMessage(tank.getUserId(),_loc5_);
         battleService.soundManager.playSound(this.winSound);
         this.guiModel.setIndicatorState(team,FlagIndicator.STATE_DEFAULT);
         //this.markers.setHudIndicatorState(team,PointHudIndicator.STATE_DEFAULT);
      }
      
      public function onEnterFlagBaseZone() : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,true);
      }
      
      public function onLeaveFlagBaseZone() : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
      }
      
      public function onFlagTouch(param1:CTFFlag) : void
      {
         this.disableFlagPickup(param1);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      }
      
      public function onPickupTimeoutPassed() : void
      {
         var _loc1_:CTFFlag = this.getOtherFlag(this.localTank.teamType);
         if(_loc1_.state != CTFFlagState.CARRIED)
         {
            this.enableFlagPickup(_loc1_);
         }
      }
      
      private function initFlag(param1:BattleTeam, param2:ClientFlag, param3:BitmapData, param4:Tanks3DSResource) : void
      {
         var _loc8_:CTFFlag = null;
         var _loc9_:Vector3 = null;
         if(param3 == null)
         {
            param3 = new BitmapData(FLAG_FRAME_WIDTH,FLAG_FRAME_HEIGHT,false,param1 == BattleTeam.RED ? 11141120 : 170);
         }
         var _loc5_:TextureAnimation = GraphicsUtils.getTextureAnimation(materialRegistry,param3,FLAG_FRAME_WIDTH,param3.height,0,false);
         var _loc6_:Vector3 = new Vector3(param2.flagBasePosition.x,param2.flagBasePosition.y,param2.flagBasePosition.z);
         var _loc7_:BattleScene3D = battleService.getBattleScene3D();
         _loc8_ = new CTFFlag(param1,_loc6_,FLAG_FRAME_WIDTH,FLAG_FRAME_HEIGHT,_loc5_,battleService.getBattleRunner().getCollisionDetector(),this,_loc7_);
         this.flags[param1] = _loc8_;
         _loc8_.addToScene();
         if(param2.flagCarrierId != null)
         {
            this.setRemoteFlagCarrier(_loc8_,param2.flagCarrierId,this.loadedTanks[param2.flagCarrierId]);
            //this.guiModel.ctfShowFlagCarried(param1); // 2017 code

            this.guiModel.setIndicatorState(param1,FlagIndicator.STATE_BLINK);
            //this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_CARRIED);
         }
         else if(param2.flagPosition != null)
         {
            _loc9_ = new Vector3();
            _loc9_.x = param2.flagPosition.x;
            _loc9_.y = param2.flagPosition.y;
            _loc9_.z = param2.flagPosition.z;
            _loc8_.dropAt(_loc9_);
            //this.guiModel.ctfShowFlagDropped(param1); // 2017 code

            this.guiModel.setIndicatorState(param1,FlagIndicator.STATE_EMPTY);
            //this.markers.setHudIndicatorState(param1.teamType,PointHudIndicator.STATE_DROPPED);
         }
         _loc7_.addRenderer(_loc8_,1);
         _loc7_.hidableGraphicObjects.add(_loc8_);
         this.initFlagBase(param4,param2);
      }
      
      private function initFlagBase(param1:Tanks3DSResource, param2:ClientFlag) : void
      {
         var _loc3_:Object3D = createPedestal(param1);
         var _loc4_:Vector3 = BattleUtils.getVector3(param2.flagBasePosition);
         _loc4_.z -= Z_DISPLACEMENT;
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         _loc3_.z = _loc4_.z;
         battleService.getBattleScene3D().addObject(_loc3_);
         var _loc5_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         var _loc6_:FlagBaseTrigger = new FlagBaseTrigger(_loc4_,this.battleMinesModel.getMinDistanceFromBase(),this,_loc5_);
         this.triggers.push(_loc6_);
         battleService.getBattleRunner().addTrigger(_loc6_);
      }
      
      private function returnFlag(param1:BattleTeam) : void
      {
         var _loc3_:CTFFlag = null;
         this.dropCommandSent = false;
         var _loc2_:CTFFlag = this.getThisFlag(param1);
         _loc2_.returnToBase();
         if(Boolean(this.localTank) && Boolean(this.localTank.teamType))
         {
            if(this.localTank.isSameTeam(param1))
            {
               this.setFlagCarrierForEvaluators(null);
               _loc3_ = this.getOtherFlag(param1);
               if(_loc3_.carrier == this.localTank)
               {
                  this.enableFlagPickup(_loc2_);
               }
               else
               {
                  this.disableFlagPickup(_loc2_);
               }
            }
            else
            {
               this.enableFlagPickup(_loc2_);
            }
         }
         // this.guiModel.ctfShowFlagAtBase(param1); // 2017 code
         var userAction:UserAction = param1 == BattleTeam.BLUE ? UserAction.CTF_BLUE_PLAYER_BRINGBACK_BLUEFLAG : UserAction.CTF_RED_PLAYER_BRINGBACK_REDFLAG;
         this.guiModel.showBattleLogMessage(userAction);
      }
      
      private function initMessages() : void
      {
         this.defaultMessages = {};
         this.spectatorBlueMessages = {};
         this.spectatorRedMessages = {};
         this.createDefaultFlagMessages();
         createSpectatorMessages(this.spectatorBlueMessages,MessageColor.BLUE);
         createSpectatorMessages(this.spectatorRedMessages,MessageColor.RED);
         this.ourFlagReturnedMessage = localeService.getText(TanksLocale.TEXT_CTF_OUR_FLAG_RETURNED);
         this.enemyFlagReturnedMessage = localeService.getText(TanksLocale.TEXT_CTF_ENEMY_FLAG_RETURNED);
         this.blueFlagReturnedMessage = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_BLUE_FLAG_RETURNED),MessageColor.BLUE);
         this.redFlagReturnedMessage = new FlagMessage(localeService.getText(TanksLocale.TEXT_CTF_RED_FLAG_RETURNED),MessageColor.RED);
      }
      
      private function createDefaultFlagMessages() : void
      {
         this.createFlagActionMessages(MESSAGE_TAKEN,TanksLocale.TEXT_CTF_GOT_ENEMY_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_GOT_OUR_FLAG,MessageColor.NEGATIVE);
         this.createFlagActionMessages(MESSAGE_LOST,TanksLocale.TEXT_CTF_LOST_OUR_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_LOST_ENEMY_FLAG,MessageColor.NEGATIVE);
         this.createFlagActionMessages(MESSAGE_RETURNED,TanksLocale.TEXT_CTF_RETURNED_OUR_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_RETURNED_ENEMY_FLAG,MessageColor.NEGATIVE);
         this.createFlagActionMessages(MESSAGE_CAPTURED,TanksLocale.TEXT_CTF_CAPTURED_ENEMY_FLAG,MessageColor.POSITIVE,TanksLocale.TEXT_CTF_CAPTURED_OUR_FLAG,MessageColor.NEGATIVE);
      }
      
      private function createFlagActionMessages(param1:String, param2:String, param3:uint, param4:String, param5:uint) : void
      {
         var _loc6_:FlagMessage = new FlagMessage(localeService.getText(param2),param3);
         var _loc7_:FlagMessage = new FlagMessage(localeService.getText(param4),param5);
         this.defaultMessages[param1] = new FlagActionMessages(_loc6_,_loc7_);
      }
      
      private function getFlagMessage(param1:String, param2:Boolean) : FlagMessage
      {
         var _loc3_:FlagActionMessages = this.defaultMessages[param1];
         return param2 ? _loc3_.positive : _loc3_.negative;
      }
      
      private function getFlagMessageForSpectator(param1:String, param2:BattleTeam) : FlagMessage
      {
         var _loc3_:Object = param2 == BattleTeam.BLUE ? this.spectatorBlueMessages : this.spectatorRedMessages;
         return _loc3_[param1];
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case KEY_DROP_FLAG:
               this.doDropFlag();
         }
      }
      
      private function doDropFlag() : void
      {
         var _loc1_:CTFFlag = null;
         if(Boolean(battleService.isBattleActive()) && !battleInputLockService.isInputLocked() && this.localTank != null && !this.dropCommandSent)
         {
            _loc1_ = this.getOtherFlag(this.localTank.teamType);
            if(_loc1_.carrier == this.localTank)
            {
               this.dropCommandSent = true;
               this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
               server.dropFlagCommand();
            }
         }
      }
      
      private function addCTFMessage(param1:FlagMessage, userId:String) : void
      {
         var _loc3_:String = userId != null ? userInfoService.getUserName(userId) : null;
         if(Boolean(_loc3_))
         {
            this.guiModel.showBattleMessage(param1.color,_loc3_ + " " + param1.text);
         }
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         this.loadedTanks[param1.tank.getUserId()] = param1.tank;
         if(param1.isLocal)
         {
            this.localTank = param1.tank;
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         var _loc4_:Body = null;
         var _loc5_:BodyState = null;
         var _loc6_:Vector3 = null;
         var _loc2_:Tank = param1.tank;
         var _loc3_:CTFFlag = this.getOtherFlag(_loc2_.teamType);
         if(_loc3_.carrier == _loc2_)
         {
            _loc4_ = _loc2_.getBody();
            _loc5_ = _loc4_.state;
            _loc6_ = _loc5_.position;
            this.dropFlag(BattleUtils.getVector3d(_loc6_),_loc3_.teamType);
         }
         delete this.loadedTanks[_loc2_.getUserId()];
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         var _loc2_:CTFFlag = null;
         for each(_loc2_ in this.flags)
         {
            if(_loc2_.state == CTFFlagState.CARRIED && _loc2_.carrierId == param1.tank.getUserId())
            {
               this.setRemoteFlagCarrier(_loc2_,_loc2_.carrierId,param1.tank);
               this.disableFlagPickup(_loc2_);
               break;
            }
         }
      }
      
      private function onLocalTankActivated(param1:Object) : void
      {
         var _loc4_:CTFTargetEvaluator = null;
         var _loc2_:CTFFlag = this.getThisFlag(this.localTank.teamType);
         if(_loc2_.state == CTFFlagState.DROPPED)
         {
            this.enableFlagPickup(_loc2_);
         }
         var _loc3_:CTFFlag = this.getOtherFlag(this.localTank.teamType);
         if(_loc3_.state != CTFFlagState.CARRIED)
         {
            this.enableFlagPickup(_loc3_);
         }
         for each(_loc4_ in this.targetEvaluators)
         {
            _loc4_.setLocalTeamType(this.localTank.teamType);
         }
      }
      
      private function onTankDeadEvent(param1:TankDeadEvent) : void
      {
         var _loc2_:CTFFlag = null;
         if(this.localTank != null && this.localTank.getUser() == param1.victim)
         {
            for each(_loc2_ in this.flags)
            {
               this.disableFlagPickup(_loc2_);
            }
         }
      }
      
      private function onBattleRestart(param1:Object) : void
      {
         var _loc2_:FlagBaseTrigger = null;
         this.returnFlag(BattleTeam.BLUE);
         this.returnFlag(BattleTeam.RED);
         for each(_loc2_ in this.triggers)
         {
            _loc2_.reset();
         }
      }
      
      private function onBattleFinish(param1:Object) : void
      {
         var _loc2_:CTFFlag = null;
         this.dropCommandSent = false;
         for each(_loc2_ in this.flags)
         {
            this.disableFlagPickup(_loc2_);
         }
      }
      
      private function enableFlagPickup(param1:CTFFlag) : void
      {
         if(this.localTank != null && this.localTank.state == ClientTankState.ACTIVE && Boolean(battleService.isBattleActive()))
         {
            battleService.getBattleRunner().addTrigger(param1);
         }
      }
      
      private function disableFlagPickup(param1:CTFFlag) : void
      {
         battleService.getBattleRunner().removeTrigger(param1);
      }
      
      private function setLocalFlagCarrier(param1:CTFFlag, param2:String, param3:Tank) : void
      {
         param1.setLocalCarrier(param2,param3);
         this.setupEvaluators(param1,param3);
      }
      
      private function setRemoteFlagCarrier(param1:CTFFlag, param2:String, param3:Tank) : void
      {
         param1.setRemoteCarrier(param2,param3);
         this.setupEvaluators(param1,param3);
      }
      
      private function setupEvaluators(param1:CTFFlag, param2:Tank) : void
      {
         if(param2 != null && this.localTank != null && this.localTank.isSameTeam(param1.teamType))
         {
            this.setFlagCarrierForEvaluators(param2.getBody());
         }
      }
      
      private function initTargetEvaluators() : void
      {
         this.targetEvaluators = new Vector.<CTFTargetEvaluator>();
         var _loc1_:CTFCommonTargetEvaluator = new CTFCommonTargetEvaluator();
         battleService.setCommonTargetEvaluator(_loc1_);
         this.targetEvaluators.push(_loc1_);
         //var _loc2_:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
         //battleService.setHealingGunTargetEvaluator(_loc2_);
         //this.targetEvaluators.push(_loc2_);
         var _loc3_:CTFRailgunTargetEvaluator = new CTFRailgunTargetEvaluator();
         battleService.setRailgunTargetEvaluator(_loc3_);
         this.targetEvaluators.push(_loc3_);
      }
      
      private function setFlagCarrierForEvaluators(param1:Body) : void
      {
         var _loc2_:CTFTargetEvaluator = null;
         for each(_loc2_ in this.targetEvaluators)
         {
            _loc2_.setFlagCarrier(param1);
         }
      }
      
      private function getThisFlag(param1:BattleTeam) : CTFFlag
      {
         return this.flags[param1];
      }
      
      private function getOtherFlag(param1:BattleTeam) : CTFFlag
      {
         return this.flags[BattleUtils.getOtherTeam(param1)];
      }
      
      public function getRicochetTargetEvaluator() : RicochetTargetEvaluator
      {
         var _loc1_:CTFRicochetTargetEvaluator = new CTFRicochetTargetEvaluator();
         this.targetEvaluators.push(_loc1_);
         return _loc1_;
      }
   }
}

