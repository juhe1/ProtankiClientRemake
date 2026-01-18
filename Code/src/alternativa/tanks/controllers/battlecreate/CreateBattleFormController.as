package alternativa.tanks.controllers.battlecreate
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.model.map.mapinfo.IMapInfo;
   import alternativa.tanks.service.achievement.IAchievementService;
   import alternativa.tanks.view.battlecreate.CreateBattleFormLabels;
   import alternativa.tanks.view.battlecreate.CreateBattleFormView;
   import alternativa.tanks.view.battlelist.modefilter.BattleModeIcons;
   import alternativa.types.Long;
   import assets.icons.BattleInfoIcons;
   import controls.checkbox.CheckBoxEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import mx.utils.StringUtil;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateCC;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.Range;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;
   import projects.tanks.client.battleservice.EquipmentConstraintsMode;
   
   public class CreateBattleFormController extends EventDispatcher
   {
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      [Inject] // added
      public static var achievementService:IAchievementService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var battleFormatUtil:BattleFormatUtil;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const SECONDS_IN_MINUTE:int = 60;
      
      private static const NON_FORMAT_BATTLE_MODE_INDEX:int = 0;
      
      private static const MAX_RANK:int = 31;
      
      private static const MIN_RANK:int = 1;
      
      private static const MIN_RANK_INTERVAL_LENGTH:int = 1;
      
      private static const MIN_PLAYER_FOR_DEATH_MATCH:int = 2;
      
      private static const MIN_PLAYER_FOR_TEAM_BATTLE:int = 1;
      
      private static const SCORE_STEP_COMMON:int = 1;
      
      private static const SCORE_STEP_CP:int = 10;
      
      private static const SCORE_STEP_ASL:int = 10;
      
      private var _battlesLimits:Vector.<BattleLimits>;
      
      private var scoreLimits:Vector.<int>;
      
      private var _timeLimitInSec:int = 1800;
      
      private var _maxPeopleCount:int;
      
      private var _battleMode:BattleMode = BattleMode.DM;
      
      private var _view:CreateBattleFormView;
      
      private var _mapThemes:Dictionary = new Dictionary();
      
      private var _currentRank:int = -1;
      
      private var _mapsParams:Array;
      
      private var _mapParamsForCurrentRank:Array;
      
      private var _themeName:String;
      
      private var _isShowForm:Boolean;
      
      public var battleCreateParams:BattleCreateCC;
      
      private var _checkedBattleNameTimer:Timer;
      
      private var _isAutoName:Boolean;
      
      private var _isCheckedServerBattleName:Boolean;
      
      private var _battleNameBeforeCheck:String;
      
      public function CreateBattleFormController(param1:BattleCreateCC, param2:Vector.<IGameObject>)
      {
         super();
         this.battleCreateParams = param1;
         this._view = new CreateBattleFormView(this);
         this.init(param2);
      }
      
      public static function getIcon(param1:int) : DisplayObject
      {
         var _loc2_:BattleInfoIcons = new BattleInfoIcons();
         _loc2_.type = param1;
         return _loc2_;
      }
      
      private function init(param1:Vector.<IGameObject>) : void
      {
         this._battlesLimits = this.battleCreateParams.battlesLimits;
         this.scoreLimits = new Vector.<int>(BattleMode.values.length);
         this._checkedBattleNameTimer = new Timer(1200);
         this._checkedBattleNameTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._view.setMaxRankRange(this.battleCreateParams.maxRangeLength - 1);
         this._view.setRankIntervalRestriction(MIN_RANK,MAX_RANK,MIN_RANK_INTERVAL_LENGTH);
         this._view.resetPrivateBattleCheckBox();
         this._view.setBattleFormats(this.createFormatBattleModeDatas());
         this.parseMapsParams(param1);
      }
      
      private function parseMapsParams(param1:Vector.<IGameObject>) : void
      {
         var _loc4_:IGameObject = null;
         var _loc5_:IMapInfo = null;
         var _loc6_:CreateBattleMapParams = null;
         this._mapsParams = new Array();
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = IMapInfo(_loc4_.adapt(IMapInfo));
            _loc6_ = new CreateBattleMapParams();
            _loc6_.index = _loc3_;
            _loc6_.id = _loc5_.getMapId();
            _loc6_.previewResource = _loc5_.getPreviewResource();
            _loc6_.gameName = _loc5_.getName();
            _loc6_.maxPeople = _loc5_.getMaxPeople();
            _loc6_.maxRank = _loc5_.getMaxRank();
            _loc6_.minRank = _loc5_.getMinRank();
            _loc6_.themeName = _loc5_.getThemeName();
            _loc6_.theme = _loc5_.getTheme();
            _loc6_.battleModes = _loc5_.getSupportedBattleModes();
            _loc6_.enabled = _loc5_.isEnabled();
            _loc6_.defaultTheme = _loc5_.getDefaultTheme();
            _loc6_.matchmakingMark = _loc5_.hasMatchmakingMark();
            this._mapsParams.push(_loc6_);
            _loc3_++;
         }
      }
      
      public function onPlayersNumberChange() : void
      {
         this._maxPeopleCount = this._view.getNumberPlayers();
      }
      
      public function onTimeLimitChange() : void
      {
         this._timeLimitInSec = this._view.getTimeLimit() * SECONDS_IN_MINUTE;
         this.checkedCorrectBattleParams();
      }
      
      public function onScoreLimitChange() : void
      {
         this.scoreLimits[this._battleMode.value] = this._view.getScoreLimit();
         this.checkedCorrectBattleParams();
      }
      
      public function setBattleMode(param1:BattleMode) : void
      {
         var _loc3_:int = 0;
         this._battleMode = param1;
         var _loc2_:int = this._battlesLimits[this._battleMode.value].timeLimitInSec;
         if(this._timeLimitInSec > _loc2_)
         {
            this._timeLimitInSec = _loc2_;
         }
         this._view.setTypeBattle(this._battleMode);
         if(this._battleMode == BattleMode.DM)
         {
            this._maxPeopleCount = int(this.getSelectedMapParams().maxPeople);
            _loc3_ = MIN_PLAYER_FOR_DEATH_MATCH;
         }
         else
         {
            this._maxPeopleCount = int(this.getSelectedMapParams().maxPeople) / 2;
            _loc3_ = MIN_PLAYER_FOR_TEAM_BATTLE;
         }
         this._view.setSettingsPlayersLimit(_loc3_,this._maxPeopleCount);
         this._view.setSettingsTimeLimit(0,_loc2_ / SECONDS_IN_MINUTE,this._timeLimitInSec / SECONDS_IN_MINUTE);
         var _loc4_:int = this._battlesLimits[this._battleMode.value].scoreLimit;
         this.scoreLimits[this._battleMode.value] = this.clamp(this.scoreLimits[this._battleMode.value],0,_loc4_);
         var _loc5_:int = this.scoreLimits[this._battleMode.value];
         switch(this._battleMode)
         {
            case BattleMode.DM:
               this._view.setSettingsScoreLimit(_loc4_,_loc5_,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperKillsLimitLabel,getIcon(BattleInfoIcons.KILL_LIMIT));
               this._view.setNameMaxPlayersStepper();
               break;
            case BattleMode.TDM:
               this._view.setSettingsScoreLimit(_loc4_,_loc5_,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperKillsLimitLabel,getIcon(BattleInfoIcons.KILL_LIMIT));
               this._view.setNameMaxPlayersTeamStepper();
               break;
            case BattleMode.CTF:
               this._view.setSettingsScoreLimit(_loc4_,_loc5_,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperFlagsLimitLabel,getIcon(BattleInfoIcons.CTF));
               this._view.setNameMaxPlayersTeamStepper();
               break;
            case BattleMode.CP:
               this._view.setSettingsScoreLimit(_loc4_,_loc5_,SCORE_STEP_CP,CreateBattleFormLabels.stepperDominationLimitLabel,getIcon(BattleInfoIcons.TEAM_SCORE));
               this._view.setNameMaxPlayersTeamStepper();
               break;
            case BattleMode.AS:
               this._view.setSettingsScoreLimit(_loc4_,_loc5_,SCORE_STEP_ASL,CreateBattleFormLabels.stepperDominationLimitLabel,new Bitmap(BattleModeIcons.getIcon(BattleMode.AS)));
               this._view.setNameMaxPlayersTeamStepper();
               break;
            //case BattleMode.RUGBY:
            //   this._view.setSettingsScoreLimit(_loc4_,_loc5_,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperDominationLimitLabel,new Bitmap(BattleModeIcons.getIcon(BattleMode.RUGBY)));
            //   this._view.setNameMaxPlayersTeamStepper();
         }
         this._view.updateOptions();
      }
      
      private function clamp(param1:int, param2:int, param3:int) : int
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public function onMapChange() : void
      {
         this.updateThemes();
         this.updateParams();
      }
      
      public function onThemeChange() : void
      {
         this._themeName = this._view.getSelectedThemeItem().themeName;
         this.updateParams();
      }
      
      private function updateParams() : void
      {
         this.updateRangeRank();
         this.setAvailableBattleTypes();
         this.selectBattleType(this._battleMode);
         this.saveMapParamInStorage();
         this._view.battleInfo.updatePreview(this.getSelectedMapParams().previewResource);
         this._view.battleInfo.setMatchmakingMark(this._view.getSelectMapItem().matchmakingMark);
         var _loc1_:Object = this._view.getSelectedFormatItem();
         if(_loc1_ == null || _loc1_.index == 0)
         {
            this._view.setBattleName(this._view.getSelectMapItem().gameName);
         }
         else
         {
            this._view.setBattleName(this._view.getSelectMapItem().gameName + " " + _loc1_.gameName);
         }
      }
      
      public function destroy() : void
      {
         this._view.destroy();
         this._view = null;
      }
      
      public function showForm() : void
      {
         this._isShowForm = true;
         if(this._currentRank != userPropertiesService.rank)
         {
            this._currentRank = userPropertiesService.rank;
            if(this._currentRank < MIN_RANK)
            {
               this._currentRank = MIN_RANK;
            }
            this._view.setCurrentRank(this._currentRank);
            this.updateAvailableMaps();
            this.selectDefaultMap();
         }
         achievementService.showStartButtonHelper();
         this._view.show();
      }
      
      public function hideForm() : void
      {
         this._isShowForm = false;
         this._view.hide();
         achievementService.hideStartButtonHelper();
      }
      
      private function checkedCorrectBattleParams() : void
      {
         if(this.isBattleParamsCorrect())
         {
            this._view.unBlockedStartButton();
         }
         else
         {
            this._view.blockedStartButton();
         }
      }
      
      private function isBattleParamsCorrect() : Boolean
      {
         return Boolean(StringUtil.trim(this._view.getBattleName())) && (this._view.getTimeLimit() != 0 || this._view.getScoreLimit() != 0);
      }
      
      private function setAvailableBattleTypes() : void
      {
         this._view.setAvailableTypesBattle(this.getSelectedMapParams().battleModes);
      }
      
      private function updateRangeRank() : void
      {
         var selectedMapParams:CreateBattleMapParams = this.getSelectedMapParams();
         var maxRange:Range = this.battleCreateParams.maxRange;
         var maxRangeMapMinRangeMax:int = Math.max(maxRange.min,selectedMapParams.minRank);
         var maxRangeMapMaxRangeMin:int = Math.min(maxRange.max,selectedMapParams.maxRank);
         this._view.setRankIntervalRestriction(maxRangeMapMinRangeMax,maxRangeMapMaxRangeMin,MIN_RANK_INTERVAL_LENGTH);
         var defaultRange:Range = this.battleCreateParams.defaultRange;
         this._view.setMinRang(Math.max(defaultRange.min,this._view.getMinRangValue()));
         this._view.setMaxRang(Math.min(defaultRange.max,this._view.getMaxRangValue()));
      }
      
      private function updateThemes() : void
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:SaveMapParams = null;
         var _loc7_:CreateBattleMapParams = null;
         var _loc8_:CreateBattleMapParams = null;
         var _loc9_:Object = null;
         var _loc1_:String = this._view.getSelectMapItem().id;
         var _loc2_:Dictionary = this._mapThemes[_loc1_];
         if(_loc2_ != null)
         {
            _loc3_ = new Array();
            _loc4_ = null;
            for(_loc5_ in _loc2_)
            {
               _loc8_ = this._mapThemes[_loc1_][_loc5_];
               if(this._currentRank >= _loc8_.minRank && this._currentRank <= _loc8_.maxRank)
               {
                  _loc3_.push({
                     "gameName":_loc5_,
                     "id":_loc8_.id,
                     "rang":0,
                     "theme":_loc8_.theme
                  });
               }
               if(_loc8_.defaultTheme != null && _loc8_.defaultTheme.name == _loc8_.theme.name)
               {
                  _loc4_ = _loc5_;
               }
            }
            _loc3_.sortOn(["gameName"]);
            this._view.setThemeInfo(_loc3_);
            _loc6_ = this.getSaveMapParams();
            if(_loc6_ != null && _loc6_.selectedThemes != null && _loc6_.selectedThemes[_loc1_] != null)
            {
               this._themeName = _loc6_.selectedThemes[_loc1_];
            }
            else if(_loc4_ != null)
            {
               this._themeName = _loc4_;
            }
            _loc7_ = this._mapThemes[this._view.getSelectMapItem().id][this._themeName];
            if(this._themeName != null && this.isMapAndThemeAvailable(_loc7_))
            {
               this._view.setSelectMapThemeItemByField("themeName",this._themeName);
            }
            else
            {
               _loc9_ = this._view.getSelectedThemeItem();
               this._themeName = _loc9_ != null ? _loc9_.themeName : null;
            }
            if(_loc3_.length > 1)
            {
               this._view.showThemeForMap();
            }
            else
            {
               this._view.hideThemeForMap();
            }
         }
      }
      
      private function isMapAndThemeAvailable(param1:CreateBattleMapParams) : Boolean
      {
         return param1 != null && param1.enabled && this._currentRank >= param1.minRank && this._currentRank <= param1.maxRank;
      }
      
      private function getSelectedMapParams() : CreateBattleMapParams
      {
         return CreateBattleMapParams(this._mapThemes[this._view.getSelectMapItem().id][this._themeName]);
      }
      
      private function updateAvailableMaps() : void
      {
         var _loc1_:CreateBattleMapParams = null;
         this._mapThemes = new Dictionary();
         this._mapParamsForCurrentRank = new Array();
         for each(_loc1_ in this._mapsParams)
         {
            if(_loc1_.enabled && this._currentRank <= _loc1_.maxRank)
            {
               if(this._mapThemes[_loc1_.id] == undefined)
               {
                  this._mapThemes[_loc1_.id] = new Dictionary();
                  _loc1_.currentRank = this._currentRank >= _loc1_.minRank ? 0 : _loc1_.minRank;
                  this._mapParamsForCurrentRank.push(_loc1_);
               }
               this._mapThemes[_loc1_.id][_loc1_.themeName] = _loc1_;
            }
         }
         if(this._mapParamsForCurrentRank.length != 0)
         {
            this._mapParamsForCurrentRank.sortOn(["currentRank","gameName"],[Array.NUMERIC,null]);
            this._view.setMapsInfo(this._mapParamsForCurrentRank);
            return;
         }
         throw new ArgumentError("For your rank is not available maps");
      }
      
      private function selectDefaultMap() : void
      {
         var _loc1_:String = null;
         var _loc2_:SaveMapParams = this.getSaveMapParams();
         var _loc3_:CreateBattleMapParams = this.getMapParams(_loc2_.mapId,_loc2_.themeName);
         if(this.isMapAndThemeAvailable(_loc3_))
         {
            _loc1_ = _loc3_.gameName;
            this._themeName = _loc3_.themeName;
         }
         else
         {
            _loc1_ = this._mapParamsForCurrentRank[0].gameName;
            this._themeName = this._mapParamsForCurrentRank[0].themeName;
         }
         this._view.selectMap("gameName",_loc1_);
         this.onMapChange();
      }
      
      private function getMapParams(param1:String, param2:String) : CreateBattleMapParams
      {
         var _loc3_:int = int(this._mapsParams.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._mapsParams[_loc4_].id == param1 && this._mapsParams[_loc4_].themeName == param2)
            {
               return this._mapsParams[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      private function getSaveMapParams() : SaveMapParams
      {
         var _loc1_:SaveMapParams = new SaveMapParams();
         var _loc2_:SharedObject = storageService.getStorage();
         var _loc3_:Vector.<Object> = _loc2_.data.SelectedMap != null && _loc2_.data.SelectedMap is Vector.<Object> ? _loc2_.data.SelectedMap as Vector.<Object> : new Vector.<Object>();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].userName == userPropertiesService.userName)
            {
               _loc1_.mapId = _loc3_[_loc4_].mapId;
               _loc1_.themeName = _loc3_[_loc4_].mapTheme;
               _loc1_.selectedThemes = _loc3_[_loc4_].selectedThemes;
               break;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function saveMapParamInStorage() : void
      {
         var _loc6_:Object = null;
         var _loc1_:SharedObject = storageService.getStorage();
         var _loc2_:Vector.<Object> = _loc1_.data.SelectedMap != null && _loc1_.data.SelectedMap is Vector.<Object> ? _loc1_.data.SelectedMap as Vector.<Object> : new Vector.<Object>();
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].userName == userPropertiesService.userName)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         var _loc5_:CreateBattleMapParams = this.getSelectedMapParams();
         if(_loc3_ != -1)
         {
            _loc6_ = _loc2_[_loc3_];
         }
         else
         {
            _loc6_ = new Object();
            _loc6_.userName = userPropertiesService.userName;
            _loc2_.push(_loc6_);
         }
         _loc6_.mapId = _loc5_.id;
         _loc6_.mapTheme = _loc5_.themeName;
         if(_loc6_.selectedThemes == null)
         {
            _loc6_.selectedThemes = new Object();
         }
         _loc6_.selectedThemes[_loc5_.id] = _loc5_.themeName;
         _loc1_.data.SelectedMap = _loc2_;
      }
      
      private function selectBattleType(param1:BattleMode) : void
      {
         if(this.isTypeBattleContainedSelectedMap(param1))
         {
            this.setBattleMode(param1);
         }
         else
         {
            this.setBattleMode(this.getSelectedMapParams().battleModes[0]);
         }
      }
      
      private function isTypeBattleContainedSelectedMap(param1:BattleMode) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Vector.<BattleMode> = this.getSelectedMapParams().battleModes;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_] == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function onCreateBattle() : void
      {
         var _loc1_:BattleCreateParameters = null;
         if(this.isBattleParamsCorrect())
         {
            _loc1_ = new BattleCreateParameters();
            _loc1_.battleMode = this._battleMode;
            _loc1_.limits = new BattleLimits(this._view.getScoreLimit(),this._view.getTimeLimit() * SECONDS_IN_MINUTE);
            _loc1_.mapId = this._view.getSelectedThemeItem().id;
            _loc1_.theme = this._view.getSelectedThemeItem().theme;
            _loc1_.maxPeopleCount = this._maxPeopleCount;
            _loc1_.rankRange = new Range(this._view.getMaxRank(),this._view.getMinRank());
            _loc1_.proBattle = true;
            _loc1_.privateBattle = this._view.isPrivateBattle;
            _loc1_.withoutSupplies = this._view.isNoSuppliesBattle;
            _loc1_.withoutUpgrades = this._view.isWithoutUpgrades;
            //_loc1_.withoutDevices = this._view.isWithoutDevices;
            _loc1_.withoutBonuses = this._view.isWithoutBonuses;
            _loc1_.withoutGoldBoxes = !this._view.isGoldBoxesEnabled;
            _loc1_.autoBalance = this._view.isAutoBalance;
            _loc1_.friendlyFire = this._view.isFriendlyFire;
            _loc1_.withoutDrones = this._view.isWithoutDrones;
            _loc1_.reArmorEnabled = this._view.isReArmor;
            _loc1_.dependentCooldownEnabled = this._view.isDependentCooldownBattle;
            _loc1_.equipmentConstraintsMode = EquipmentConstraintsMode.fromString(this.getEquipmentConstraintsMode());
            _loc1_.parkourMode = this.isParkourFormatItemSelected();
            //_loc1_.clanBattle = this._view.isClanBattle;
            //_loc1_.ultimatesEnabled = this._view.isUltimatesEnabled();
            _loc1_.name = this._view.getBattleName();
            dispatchEvent(new CreateBattleEvent(_loc1_));
            this.hideForm();
            achievementService.hideAllBubbles(true);
         }
      }
      
      private function isParkourFormatItemSelected() : Boolean
      {
         return this._view.getSelectedFormatItem().parkour;
      }
      
      private function getEquipmentConstraintsMode() : String
      {
         return this._view.getSelectedFormatItem().equipmentConstraintsMode;
      }
      
      private function createFormatBattleModeDatas() : Vector.<Object>
      {
         var _loc3_:Object = null;
         var _loc1_:Vector.<Object> = new Vector.<Object>();
         var _loc2_:int = 0;
         _loc1_.push({
            "index":_loc2_++,
            "gameName":localeService.getText(TanksLocale.TEXT_FORMAT_NAME_NONE),
            "equipmentConstraintsMode":null,
            "parkour":false,
            "rang":0
         });
         for each(_loc3_ in battleFormatUtil.getEquipmentConstraintsModes())
         {
            _loc1_.push({
               "index":_loc2_++,
               "gameName":_loc3_.name,
               "equipmentConstraintsMode":_loc3_.mode,
               "parkour":false,
               "rang":0
            });
         }
         _loc1_.push({
            "index":_loc2_,
            "gameName":battleFormatUtil.getParkourFormatName(),
            "equipmentConstraintsMode":null,
            "parkour":true,
            "rang":0
         });
         return _loc1_;
      }
      
      public function onFormatChange(param1:Event) : void
      {
         if(this.isParkourFormatItemSelected())
         {
            this._view.resetDependentCooldownCheckBox();
         }
         else if(this.getEquipmentConstraintsMode() != null)
         {
            this._view.resetReArmorCheckbox();
            this._view.resetUpgradesAndDevicesCheckbox();
            this._view.resetUltimatesCheckBox();
         }
         this._view.updateOptions();
         this.updateParams();
      }
      
      public function onUpgradesOrDevicesChange(param1:Event) : void
      {
         if(!this._view.isWithoutUpgrades || !this._view.isWithoutDevices)
         {
            this.resetEquipConstraintsViewFormat();
         }
      }
      
      public function onReArmorChanged() : void
      {
         if(this._view.isReArmor)
         {
            this.resetEquipConstraintsViewFormat();
         }
      }
      
      private function resetEquipConstraintsViewFormat() : void
      {
         if(!this.isParkourFormatItemSelected())
         {
            this.resetFormatComboBox();
         }
      }
      
      public function onDependentCooldownChange(param1:CheckBoxEvent) : void
      {
         if(this._view.isDependentCooldownBattle && this.isParkourFormatItemSelected())
         {
            this.resetFormatComboBox();
         }
      }
      
      private function resetFormatComboBox() : void
      {
         this._view.selectFormatByIndex(NON_FORMAT_BATTLE_MODE_INDEX);
      }
      
      public function onUltimatesChanged(param1:CheckBoxEvent) : void
      {
         if(this._view.isUltimatesEnabled() && this.getEquipmentConstraintsMode() != null)
         {
            this._view.selectFormatByIndex(NON_FORMAT_BATTLE_MODE_INDEX);
         }
      }
      
      public function onBattleNameChange() : void
      {
         this._view.blockedStartButton();
         this._checkedBattleNameTimer.stop();
         if(this._view.getBattleNameLength() != 0)
         {
            this._view.hideInvalidRectangleBattleName();
            this._isCheckedServerBattleName = false;
            this._checkedBattleNameTimer.start();
         }
         else
         {
            this._view.showInvalidRectangleBattleName();
         }
      }
      
      private function getAutoName() : String
      {
         return this.getSelectedMapParams().gameName + " " + this._battleMode.name;
      }
      
      public function onBattleNameInFocus() : void
      {
         if(this._view.getBattleName() == this.getAutoName())
         {
            this._isAutoName = false;
            this._view.setBattleName("");
            this._view.showInvalidRectangleBattleName();
            this._view.blockedStartButton();
         }
      }
      
      public function checkedBattleNameResult(param1:String) : void
      {
         this._isCheckedServerBattleName = true;
         this._checkedBattleNameTimer.stop();
         if(this._view.getBattleName() == this._battleNameBeforeCheck && this._battleNameBeforeCheck != param1)
         {
            this._isAutoName = false;
            this._view.setBattleName(param1);
         }
         this._view.resetProgressBattleNameCheckIcon();
         if(this._view.getBattleNameLength() != 0)
         {
            this._view.hideInvalidRectangleBattleName();
         }
         this.checkedCorrectBattleParams();
      }
      
      private function setAutoNameBattle() : void
      {
         this._isAutoName = true;
         this._isCheckedServerBattleName = true;
         this._view.setBattleName(this.getAutoName());
         this._view.hideInvalidRectangleBattleName();
      }
      
      public function onBattleNameOutFocus() : void
      {
         if(this._view.getBattleNameLength() == 0)
         {
            this.setAutoNameBattle();
            if(this.isBattleParamsCorrect())
            {
               this._view.unBlockedStartButton();
            }
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         this._view.setProgressBattleNameCheckIcon();
         this._view.blockedStartButton();
         this._battleNameBeforeCheck = this._view.getBattleName();
         this._checkedBattleNameTimer.stop();
         dispatchEvent(new CheckBattleNameEvent(CheckBattleNameEvent.CHECK_NAME,this._battleNameBeforeCheck));
      }
   }
}

