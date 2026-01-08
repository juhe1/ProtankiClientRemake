package alternativa.tanks.models.battle.assault
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.OmniLight;
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
   import alternativa.tanks.engine3d.TextureMaterialRegistry;
   import alternativa.tanks.models.battle.assault.hud.ASKeyPointHudMarker;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.battlefield.mine.IBattleMinesModel;
   import alternativa.tanks.models.battle.ctf.CTFCommonTargetEvaluator;
   import alternativa.tanks.models.battle.ctf.CTFFlagState;
   import alternativa.tanks.models.battle.ctf.CTFRailgunTargetEvaluator;
   import alternativa.tanks.models.battle.ctf.FlagMessage;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.tdm.TDMHealingGunTargetEvaluator;
   import alternativa.tanks.models.controlpoints.hud.KeyPointView;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.teamlight.ModeLight;
   import alternativa.tanks.models.teamlight.TeamLightColor;
   import alternativa.tanks.models.weapon.ricochet.CTFRicochetTargetEvaluator;
   import alternativa.tanks.models.weapon.ricochet.RicochetTargetEvaluator;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
   import alternativa.tanks.utils.GraphicsUtils;
   import alternativa.tanks.utils.KeyCodes;
   import alternativa.types.Long;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.KeyboardEvent;
   import flash.geom.Matrix;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.StubBitmapData;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.assault.AssaultBase;
   import projects.tanks.client.battlefield.models.battle.assault.AssaultCC;
   import projects.tanks.client.battlefield.models.battle.assault.AssaultModelBase;
   import projects.tanks.client.battlefield.models.battle.assault.AssaultSoundFX;
   import projects.tanks.client.battlefield.models.battle.assault.ClientAssaultFlag;
   import projects.tanks.client.battlefield.models.battle.assault.IAssaultModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class AssaultModel extends AssaultModelBase implements IAssaultModelBase, ObjectLoadPostListener, ObjectUnloadListener, BattleEventListener, BattleModel, IAssaultModel
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
      
      [Inject]
      public static var lightingEffectsService:ILightingEffectsService;
      
      private static const pointIconClass:Class = AssaultModel_pointIconClass;
      
      private static const pointIconBitmapData:BitmapData = Bitmap(new pointIconClass()).bitmapData;
      
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
      
      private var flags:Vector.<ASFlag>;
      
      private var messagesForRed:Object;
      
      private var messagesForBlue:Object;
      
      private var spectatorMessages:Object;
      
      private var flagReturnedMessage:FlagMessage;
      
      private var flagDropSound:Sound;
      
      private var flagReturnSound:Sound;
      
      private var flagTakeSound:Sound;
      
      private var winSound:Sound;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var loadedTanks:Dictionary;
      
      private var localTank:Tank;
      
      private var triggers:Vector.<ASFlagBaseTrigger>;
      
      private var keyPointHUDMarkers:Vector.<ASKeyPointHudMarker>;
      
      private var targetEvaluators:Vector.<CTFTargetEvaluator>;
      
      public function AssaultModel()
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
      
      private static function getCircleMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1,false);
         _loc2_.resolution = 1000 / param1.width;
         return _loc2_;
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
      
      [Obfuscation(rename="false")]
      public function flagTaken(param1:int, param2:Long) : void
      {
         var _loc3_:ASFlag = this.flags[param1];
         var _loc4_:Tank = this.loadedTanks[param2];
         if(this.localTank != null && this.localTank == _loc4_)
         {
            this.setLocalFlagCarrier(_loc3_,param2,_loc4_);
         }
         else
         {
            this.setRemoteFlagCarrier(_loc3_,param2,_loc4_);
         }
         if(this.localTank != null || Boolean(battleInfoService.isSpectatorMode()))
         {
            this.disableFlagPickup(_loc3_);
            this.showFlagAction(MESSAGE_TAKEN,_loc4_.getUser());
            battleService.soundManager.playSound(this.flagTakeSound);
         }
         this.guiModel.asShowFlagCarried();
      }
      
      private function setLocalFlagCarrier(param1:ASFlag, param2:Long, param3:Tank) : void
      {
         param1.setLocalCarrier(param2,param3);
         this.setupEvaluators(param1,param3);
      }
      
      private function setRemoteFlagCarrier(param1:ASFlag, param2:Long, param3:Tank) : void
      {
         param1.setRemoteCarrier(param2,param3);
         this.setupEvaluators(param1,param3);
      }
      
      private function setupEvaluators(param1:ASFlag, param2:Tank) : void
      {
         if(param2 != null && this.localTank != null && !this.isUserInAttackTeam())
         {
            this.setFlagCarrierForEvaluators(param2.getBody());
         }
      }
      
      [Obfuscation(rename="false")]
      public function dropFlag(param1:int, param2:Vector3d) : void
      {
         var _loc3_:ASFlag = this.flags[param1];
         this.notifyUserFlagDropped(_loc3_);
         this.guiModel.asShowFlagDropped();
         this.setupAfterFlagDrop(_loc3_);
         _loc3_.dropAt(new Vector3(param2.x,param2.y,param2.z));
      }
      
      private function notifyUserFlagDropped(param1:ASFlag) : void
      {
         if(param1.carrier == null)
         {
            return;
         }
         this.showFlagAction(MESSAGE_LOST,param1.carrier.getUser());
         battleService.soundManager.playSound(this.flagDropSound);
      }
      
      private function setupAfterFlagDrop(param1:ASFlag) : void
      {
         if(this.localTank == null || param1.carrier == null)
         {
            return;
         }
         if(!this.isUserInAttackTeam())
         {
            this.setFlagCarrierForEvaluators(null);
            return;
         }
         if(param1.carrier == this.localTank)
         {
            if(this.dropCommandSent)
            {
               this.dropCommandSent = false;
               battleService.getBattleRunner().addLogicUnit(new ASFlagPickupTimeoutTask(param1.getId(),this,getTimer() + FLAG_PICKUP_LOCK_DURATION));
            }
         }
         else
         {
            this.enableFlagPickup(param1);
         }
      }
      
      [Obfuscation(rename="false")]
      public function returnFlagToBase(param1:int, param2:IGameObject) : void
      {
         this.returnFlag(this.flags[param1]);
         this.showFlagReturnMessage(param2);
         battleService.soundManager.playSound(this.flagReturnSound);
      }
      
      private function returnFlag(param1:ASFlag) : void
      {
         this.dropCommandSent = false;
         param1.returnToBase();
         if(Boolean(this.localTank) && Boolean(this.localTank.teamType))
         {
            if(this.localTank.isSameTeam(BattleTeam.BLUE))
            {
               this.setFlagCarrierForEvaluators(null);
            }
            else
            {
               this.enableFlagPickup(param1);
            }
         }
         this.guiModel.asShowFlagAtBase();
      }
      
      private function showFlagReturnMessage(param1:IGameObject) : void
      {
         if(Boolean(param1))
         {
            this.showFlagAction(MESSAGE_RETURNED,param1);
         }
         else
         {
            this.guiModel.showBattleMessage(this.flagReturnedMessage.color,this.flagReturnedMessage.text);
         }
      }
      
      [Obfuscation(rename="false")]
      public function flagDelivered(param1:int, param2:int, param3:Long) : void
      {
         var _loc5_:Tank = null;
         var _loc4_:ASFlag = this.flags[param1];
         this.returnFlag(_loc4_);
         if(this.localTank != null || Boolean(battleInfoService.isSpectatorMode()))
         {
            _loc5_ = this.loadedTanks[param3];
            if(_loc5_ != null)
            {
               this.showFlagAction(MESSAGE_CAPTURED,_loc5_.getUser());
               battleService.soundManager.playSound(this.winSound);
            }
         }
      }
      
      private function onBattleFinish(param1:Object) : void
      {
         var _loc2_:ASFlag = null;
         this.dropCommandSent = false;
         for each(_loc2_ in this.flags)
         {
            this.disableFlagPickup(_loc2_);
         }
      }
      
      private function onBattleRestart(param1:Object) : void
      {
         var _loc2_:ASFlag = null;
         var _loc3_:ASFlagBaseTrigger = null;
         for each(_loc2_ in this.flags)
         {
            this.returnFlag(_loc2_);
         }
         for each(_loc3_ in this.triggers)
         {
            _loc3_.reset();
         }
      }
      
      private function setFlagCarrierForEvaluators(param1:Body) : void
      {
         var _loc2_:CTFTargetEvaluator = null;
         for each(_loc2_ in this.targetEvaluators)
         {
            _loc2_.setFlagCarrier(param1);
         }
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         var _loc2_:ASKeyPointHudMarker = null;
         this.loadedTanks[param1.tank.getUser().id] = param1.tank;
         if(param1.isLocal)
         {
            for each(_loc2_ in this.keyPointHUDMarkers)
            {
               _loc2_.show();
            }
            this.localTank = param1.tank;
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         var _loc3_:ASFlag = null;
         var _loc4_:Body = null;
         var _loc5_:BodyState = null;
         var _loc6_:Vector3 = null;
         var _loc2_:Tank = param1.tank;
         for each(_loc3_ in this.flags)
         {
            if(_loc3_.carrier == _loc2_)
            {
               _loc4_ = _loc2_.getBody();
               _loc5_ = _loc4_.state;
               _loc6_ = _loc5_.position;
               this.dropFlag(_loc3_.getId(),BattleUtils.getVector3d(_loc6_));
            }
         }
         delete this.loadedTanks[_loc2_.getUser().id];
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         var _loc2_:ASFlag = null;
         for each(_loc2_ in this.flags)
         {
            if(_loc2_.state == CTFFlagState.CARRIED && _loc2_.carrierId == param1.tank.getUser().id)
            {
               this.setRemoteFlagCarrier(_loc2_,_loc2_.carrierId,param1.tank);
               this.disableFlagPickup(_loc2_);
            }
         }
      }
      
      private function onLocalTankActivated(param1:Object) : void
      {
         var _loc2_:CTFTargetEvaluator = null;
         var _loc3_:ASFlag = null;
         if(this.isUserInAttackTeam())
         {
            for each(_loc3_ in this.flags)
            {
               if(_loc3_.state != CTFFlagState.CARRIED)
               {
                  this.enableFlagPickup(_loc3_);
               }
            }
         }
         for each(_loc2_ in this.targetEvaluators)
         {
            _loc2_.setLocalTeamType(this.localTank.teamType);
         }
      }
      
      private function onTankDeadEvent(param1:TankDeadEvent) : void
      {
         var _loc2_:ASFlag = null;
         if(this.localTank != null && this.localTank.getUser() == param1.victim)
         {
            for each(_loc2_ in this.flags)
            {
               this.disableFlagPickup(_loc2_);
            }
         }
      }
      
      private function showFlagAction(param1:String, param2:IGameObject) : void
      {
         var _loc3_:FlagMessage = this.getFlagMessageForAction(param1);
         this.addCTFMessage(_loc3_,param2);
         this.guiModel.logUserAction(param2.id,_loc3_.text,null);
      }
      
      private function getFlagMessageForAction(param1:String) : FlagMessage
      {
         if(battleInfoService.isSpectatorMode())
         {
            return this.spectatorMessages[param1];
         }
         return this.localTank.teamType == BattleTeam.BLUE ? this.messagesForBlue[param1] : this.messagesForRed[param1];
      }
      
      private function addCTFMessage(param1:FlagMessage, param2:IGameObject) : void
      {
         var _loc3_:String = param2 != null ? userInfoService.getUserName(param2.id) : null;
         if(Boolean(_loc3_))
         {
            this.guiModel.showBattleMessage(param1.color,_loc3_ + " " + param1.text);
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:AssaultSoundFX = getInitParam().sounds;
         this.flagDropSound = _loc1_.flagDropSound.sound;
         this.flagReturnSound = _loc1_.flagReturnSound.sound;
         this.flagTakeSound = _loc1_.flagTakeSound.sound;
         this.winSound = _loc1_.winSound.sound;
         this.loadedTanks = new Dictionary();
         this.triggers = new Vector.<ASFlagBaseTrigger>();
         this.initMessages();
         this.inventoryModel = IInventoryModel(object.adapt(IInventoryModel));
         this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
         this.battleMinesModel = IBattleMinesModel(object.adapt(IBattleMinesModel));
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         this.battleEventSupport.activateHandlers();
         this.initTargetEvaluators();
         this.initKeyPointIndicators();
         this.initFlagsState();
      }
      
      private function initKeyPointIndicators() : void
      {
         var _loc1_:AssaultBase = null;
         this.keyPointHUDMarkers = new Vector.<ASKeyPointHudMarker>(getInitParam().redBases.length);
         for each(_loc1_ in getInitParam().redBases)
         {
            this.keyPointHUDMarkers[_loc1_.id] = new ASKeyPointHudMarker(battleService.getBattleView(),battleService.getBattleScene3D().getCamera(),battleService,new Vector3(_loc1_.position.x,_loc1_.position.y,_loc1_.position.z));
            battleService.getBattleScene3D().addRenderer(this.keyPointHUDMarkers[_loc1_.id],0);
            if(battleInfoService.isSpectatorMode())
            {
               this.keyPointHUDMarkers[_loc1_.id].show();
            }
         }
      }
      
      private function initMessages() : void
      {
         this.createPlayerMessages();
         this.createSpectatorMessages();
         this.flagReturnedMessage = new FlagMessage(localeService.getText(TanksLocale.STRING_CTF_RED_FLAG_RETURNED),MessageColor.YELLOW);
      }
      
      private function createPlayerMessages() : void
      {
         this.messagesForRed = {};
         this.messagesForBlue = {};
         this.createFlagActionMessages(MESSAGE_TAKEN,TanksLocale.STRING_CTF_GOT_FLAG_NEUTRAL,true);
         this.createFlagActionMessages(MESSAGE_LOST,TanksLocale.STRING_CTF_LOST_FLAG_NEUTRAL,false);
         this.createFlagActionMessages(MESSAGE_RETURNED,TanksLocale.STRING_CTF_RETURNED_FLAG_NEUTRAL,false);
         this.createFlagActionMessages(MESSAGE_CAPTURED,TanksLocale.STRING_CTF_CAPTURED_FLAG_NEUTRAL,true);
      }
      
      private function createFlagActionMessages(param1:String, param2:String, param3:Boolean) : void
      {
         this.messagesForRed[param1] = new FlagMessage(localeService.getText(param2),param3 ? MessageColor.POSITIVE : MessageColor.NEGATIVE);
         this.messagesForBlue[param1] = new FlagMessage(localeService.getText(param2),!param3 ? MessageColor.POSITIVE : MessageColor.NEGATIVE);
      }
      
      private function createSpectatorMessages() : void
      {
         this.spectatorMessages = {};
         this.spectatorMessages[MESSAGE_TAKEN] = new FlagMessage(localeService.getText(TanksLocale.STRING_CTF_GOT_FLAG_NEUTRAL),MessageColor.RED);
         this.spectatorMessages[MESSAGE_LOST] = new FlagMessage(localeService.getText(TanksLocale.STRING_CTF_LOST_FLAG_NEUTRAL),MessageColor.RED);
         this.spectatorMessages[MESSAGE_RETURNED] = new FlagMessage(localeService.getText(TanksLocale.STRING_CTF_RETURNED_FLAG_NEUTRAL),MessageColor.BLUE);
         this.spectatorMessages[MESSAGE_CAPTURED] = new FlagMessage(localeService.getText(TanksLocale.STRING_CTF_CAPTURED_FLAG_NEUTRAL),MessageColor.RED);
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
         var _loc1_:ASFlag = null;
         if(Boolean(battleService.isBattleActive()) && !battleInputLockService.isInputLocked() && this.localTank != null && !this.dropCommandSent)
         {
            for each(_loc1_ in this.flags)
            {
               if(_loc1_.carrier == this.localTank)
               {
                  this.dropCommandSent = true;
                  this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
                  server.dropFlagCommand();
               }
            }
         }
      }
      
      private function initTargetEvaluators() : void
      {
         this.targetEvaluators = new Vector.<CTFTargetEvaluator>();
         var _loc1_:CTFCommonTargetEvaluator = new CTFCommonTargetEvaluator();
         battleService.setCommonTargetEvaluator(_loc1_);
         this.targetEvaluators.push(_loc1_);
         var _loc2_:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
         battleService.setHealingGunTargetEvaluator(_loc2_);
         this.targetEvaluators.push(_loc2_);
         var _loc3_:CTFRailgunTargetEvaluator = new CTFRailgunTargetEvaluator();
         battleService.setRailgunTargetEvaluator(_loc3_);
         this.targetEvaluators.push(_loc3_);
      }
      
      private function initFlagsState() : void
      {
         var _loc2_:ClientAssaultFlag = null;
         var _loc3_:AssaultBase = null;
         var _loc1_:AssaultCC = getInitParam();
         this.flags = new Vector.<ASFlag>(_loc1_.blueFlags.length);
         for each(_loc2_ in _loc1_.blueFlags)
         {
            this.initFlag(BattleTeam.BLUE,_loc2_,_loc1_.flagSprite.data,_loc1_.flagPedestalModel);
         }
         for each(_loc3_ in _loc1_.redBases)
         {
            this.initFlagBase(_loc1_.pointPedestalModel,_loc3_.position);
            this.initPoint(_loc3_.position);
         }
      }
      
      private function initPoint(param1:Vector3d) : void
      {
         var _loc2_:BitmapData = getInitParam().pointCircleTexture.data.clone();
         var _loc3_:Matrix = new Matrix();
         _loc3_.tx = (_loc2_.height - pointIconBitmapData.height) / 2;
         _loc3_.ty = (_loc2_.height - pointIconBitmapData.height) / 2;
         _loc2_.draw(pointIconBitmapData,_loc3_);
         var _loc4_:TextureMaterial = getCircleMaterial(_loc2_);
         var _loc5_:ASProgressPlane = new ASProgressPlane(_loc4_,battleService);
         battleService.getBattleScene3D().addRenderer(_loc5_,0);
         _loc5_.x = param1.x;
         _loc5_.y = param1.y;
         _loc5_.z = param1.z + KeyPointView.CIRCLE_ASCENSION;
         battleService.getBattleScene3D().addObject(_loc5_);
         this.initLight(param1);
      }
      
      private function initLight(param1:Vector3d) : void
      {
         var _loc2_:ModeLight = lightingEffectsService.getLightForMode(BattleMode.CP);
         var _loc3_:TeamLightColor = _loc2_.getLightForTeam(BattleTeam.BLUE);
         var _loc4_:OmniLight = new OmniLight(0,_loc2_.getAttenuationBegin(),_loc2_.getAttenuationEnd());
         _loc4_.color = _loc3_.getColor();
         _loc4_.intensity = _loc3_.getIntensity();
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.z = param1.z + KeyPointView.CIRCLE_ASCENSION;
         battleService.getBattleScene3D().addObject(_loc4_);
      }
      
      private function initFlag(param1:BattleTeam, param2:ClientAssaultFlag, param3:BitmapData, param4:Tanks3DSResource) : void
      {
         var _loc9_:Vector3 = null;
         if(param3 == null)
         {
            param3 = new BitmapData(FLAG_FRAME_WIDTH,FLAG_FRAME_HEIGHT,false,param1 == BattleTeam.RED ? 11141120 : 170);
         }
         var _loc5_:TextureAnimation = GraphicsUtils.getTextureAnimation(materialRegistry,param3,FLAG_FRAME_WIDTH,param3.height,0,false);
         var _loc6_:Vector3 = new Vector3(param2.flagBasePosition.x,param2.flagBasePosition.y,param2.flagBasePosition.z);
         var _loc7_:BattleScene3D = battleService.getBattleScene3D();
         var _loc8_:ASFlag = new ASFlag(param2.id,param1,_loc6_,FLAG_FRAME_WIDTH,FLAG_FRAME_HEIGHT,_loc5_,battleService.getBattleRunner().getCollisionDetector(),this,_loc7_);
         _loc8_.addToScene();
         if(param2.flagCarrierId != null)
         {
            this.setRemoteFlagCarrier(_loc8_,param2.flagCarrierId,this.loadedTanks[param2.flagCarrierId]);
            this.guiModel.asShowFlagCarried();
         }
         else if(param2.flagPosition != null)
         {
            _loc9_ = new Vector3();
            _loc9_.x = param2.flagPosition.x;
            _loc9_.y = param2.flagPosition.y;
            _loc9_.z = param2.flagPosition.z;
            _loc8_.dropAt(_loc9_);
            this.guiModel.asShowFlagAtBase();
         }
         _loc7_.addRenderer(_loc8_,1);
         _loc7_.hidableGraphicObjects.add(_loc8_);
         this.initFlagBase(param4,param2.flagBasePosition);
         this.flags[_loc8_.getId()] = _loc8_;
      }
      
      private function initFlagBase(param1:Tanks3DSResource, param2:Vector3d) : void
      {
         var _loc3_:Object3D = null;
         _loc3_ = createPedestal(param1);
         var _loc4_:Vector3 = BattleUtils.getVector3(param2);
         _loc4_.z -= Z_DISPLACEMENT;
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         _loc3_.z = _loc4_.z;
         battleService.getBattleScene3D().addObject(_loc3_);
         var _loc5_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         var _loc6_:ASFlagBaseTrigger = new ASFlagBaseTrigger(_loc4_,this.battleMinesModel.getMinDistanceFromBase(),this,_loc5_);
         this.triggers.push(_loc6_);
         battleService.getBattleRunner().addTrigger(_loc6_);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:ASFlag = null;
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
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function getRicochetTargetEvaluator() : RicochetTargetEvaluator
      {
         var _loc1_:CTFRicochetTargetEvaluator = new CTFRicochetTargetEvaluator();
         this.targetEvaluators.push(_loc1_);
         return _loc1_;
      }
      
      private function disableFlagPickup(param1:ASFlag) : void
      {
         battleService.getBattleRunner().removeTrigger(param1);
      }
      
      private function enableFlagPickup(param1:ASFlag) : void
      {
         if(this.localTank != null && this.localTank.state == ClientTankState.ACTIVE && Boolean(battleService.isBattleActive()))
         {
            battleService.getBattleRunner().addTrigger(param1);
         }
      }
      
      private function isUserInAttackTeam() : Boolean
      {
         return this.localTank.teamType == BattleTeam.RED;
      }
      
      public function onEnterFlagBaseZone() : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,true);
      }
      
      public function onLeaveFlagBaseZone() : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
      }
      
      public function onFlagTouch(param1:int) : void
      {
         this.disableFlagPickup(this.flags[param1]);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      }
      
      public function onPickupTimeoutPassed(param1:int) : void
      {
         var _loc2_:ASFlag = this.flags[param1];
         if(_loc2_.state != CTFFlagState.CARRIED)
         {
            this.enableFlagPickup(_loc2_);
         }
      }
      
      public function getBattleType() : BattleType
      {
         return BattleType.AS;
      }
   }
}

