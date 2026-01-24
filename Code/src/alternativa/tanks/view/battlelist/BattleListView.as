package alternativa.tanks.view.battlelist
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.controllers.battlelist.BattleListItemParams;
   import alternativa.tanks.controllers.battlelist.IBattleListViewControllerCallback;
   import alternativa.tanks.service.battlecreate.IBattleCreateFormService;
   import alternativa.tanks.service.panel.IPanelView;
   import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
   import alternativa.tanks.view.battlelist.battleitem.BattleListItem;
   import alternativa.tanks.view.battlelist.forms.BattleListRenderer;
   import alternativa.tanks.view.battlelist.help.LockedMapsHelper;
   import alternativa.tanks.view.battlelist.modefilter.BattleModeCheckBox;
   import controls.BigButton;
   import controls.TankWindowInner;
   import controls.base.DefaultButtonBase;
   import fl.controls.LabelButton;
   import fl.controls.List;
   import fl.controls.ScrollBar;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import forms.TankWindowWithHeader;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.Range;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import utils.ScrollStyleUtils;
   import alternativa.tanks.gui.dailyquests.window.buttons.skin.GreenBigButtonSkin;
   
   public class BattleListView extends Sprite implements IBattleListView
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var helpService:IHelpService;
      
      [Inject] // added
      public static var userProBattleService:IUserProBattleService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var battleSelectActionsService:UserBattleSelectActionsService;
      
      [Inject] // added
      public static var battleCreateFormService:IBattleCreateFormService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var reconnectService:ReconnectService;
      
      [Inject] // added
      public static var panelView:IPanelView;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const MIN_FLASH_WIDTH:int = 970;
      
      private static const MIN_FLASH_HEIGHT:int = 530;
      
      private static const HEADER_HEIGHT:int = 60;
      
      private static const ADDITIONAL_SCROLL_AREA_HEIGHT:Number = 7;
      
      private static const RESIZE_DELAY:int = 400;
      
      private const HELPER_GROUP_KEY:String = "BattleSelectModel";
      
      private const HELPER_NOT_AVAILABLE:int = 1;
      
      private var _lockedMapsHelper:LockedMapsHelper;
      
      private var _callback:IBattleListViewControllerCallback;
      
      private var _window:TankWindowWithHeader;
      
      private var _inner:TankWindowInner;
      
      private var _createBattleButton:DefaultButtonBase;
      
      private var findBattleButton:BigButton = new BigButton();
      
      private var _battleList:List;
      
      private var battleModeItems:Vector.<BattleModeCheckBox>;
      
      private var _dataProvider:DataProvider;
      
      private var _timeOutResize:uint;
      
      private var iconWidth:int = 100;
      
      private var lastSelectedBattleId:String;
      
      public function BattleListView()
      {
         super();
         this._window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CURRENT_BATTLES);
         addChild(this._window);
         this._inner = new TankWindowInner(100,100,TankWindowInner.GREEN);
         this._inner.showBlink = true;
         addChild(this._inner);
         this._dataProvider = new DataProvider();
         this._battleList = new List();
         this._battleList.rowHeight = 20;
         this._battleList.setStyle("cellRenderer",BattleListRenderer);
         this._battleList.dataProvider = this._dataProvider;
         this._battleList.focusEnabled = true;
         addChild(this._battleList);
         this._battleList.move(15,70);
         this._battleList.verticalLineScrollSize = 12;
         ScrollStyleUtils.setGreenStyle(this._battleList);
         this._createBattleButton = new DefaultButtonBase();
         this._createBattleButton.label = LocaleBattleList.showBattleCreateFormLabel;
         this._createBattleButton.visible = !battleCreateFormService.battleCreationDisabled;
         addChild(this._createBattleButton);
         this.findBattleButton.setBigText();
         this.findBattleButton.width = 200;
         this.findBattleButton.label = localeService.getText(TanksLocale.TEXT_FIND_BATTLE_BUTTON_TEXT);
         this.findBattleButton.y = 12;
         this.findBattleButton.setSkin(GreenBigButtonSkin.GREEN_SKIN);
         this.findBattleButton.enabled = true;
         addChild(this.findBattleButton);
         this.initBattleModeFilter();
         this.resize();
      }
      
      private function initBattleModeFilter() : void
      {
         this.battleModeItems = new Vector.<BattleModeCheckBox>();
         this.createBattleModeCheckBox(BattleMode.DM);
         this.createBattleModeCheckBox(BattleMode.TDM);
         this.createBattleModeCheckBox(BattleMode.CTF);
         this.createBattleModeCheckBox(BattleMode.CP);
         this.createBattleModeCheckBox(BattleMode.AS);
         //this.createBattleModeCheckBox(BattleMode.RUGBY);
         //this.createBattleModeCheckBox(BattleMode.JGR);
         this.resize();
      }
      
      private function createBattleModeCheckBox(param1:BattleMode) : void
      {
         var _loc2_:BattleModeCheckBox = new BattleModeCheckBox(param1);
         addChild(_loc2_);
         this.battleModeItems.push(_loc2_);
      }
      
      public function setCallBack(param1:IBattleListViewControllerCallback) : void
      {
         this._callback = param1;
      }
      
      public function show(param1:BattleMode) : void
      {
         if(!this.getContainer().contains(this))
         {
            this.resize();
            this.setEvents();
            this.getContainer().addChild(this);
            this._lockedMapsHelper = new LockedMapsHelper();
            helpService.registerHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE,this._lockedMapsHelper,false);
            this.getBattleModeCheckBox(param1).isPressed = true;
         }
      }
      
      private function setEvents() : void
      {
         this.getStage().addEventListener(Event.RESIZE,this.onResize);
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
         this._createBattleButton.addEventListener(MouseEvent.CLICK,this.onShowCreateBattleFormButtonClick);
         this._battleList.addEventListener(ListEvent.ITEM_CLICK,this.onBattleListItemClick);
         this._battleList.addEventListener(Event.CHANGE,this.onListChange);
         this.findBattleButton.addEventListener(MouseEvent.CLICK,this.onBackToMatchmakingClick);
         var _loc1_:int = int(this.battleModeItems.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.battleModeItems[_loc2_].addEventListener(Event.CHANGE,this.onBattleModeChange);
            _loc2_++;
         }
      }
      
      public function hide() : void
      {
         if(this.getContainer().contains(this))
         {
            this.removeEvents();
            this.getContainer().removeChild(this);
            helpService.hideHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
            helpService.unregisterHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
         }
      }
      
      public function destroy() : void
      {
         this.removeEvents();
         var _loc1_:int = int(this.battleModeItems.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.battleModeItems[_loc2_].destroy();
            _loc2_++;
         }
         clearTimeout(this._timeOutResize);
         this.battleModeItems = null;
         this._lockedMapsHelper = null;
         this._callback = null;
      }
      
      private function removeEvents() : void
      {
         lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
         this.getStage().removeEventListener(Event.RESIZE,this.onResize);
         this._createBattleButton.removeEventListener(MouseEvent.CLICK,this.onShowCreateBattleFormButtonClick);
         this._battleList.removeEventListener(ListEvent.ITEM_CLICK,this.onBattleListItemClick);
         this._battleList.removeEventListener(Event.CHANGE,this.onListChange);
         this.findBattleButton.removeEventListener(MouseEvent.CLICK,this.onBackToMatchmakingClick);
         var _loc1_:int = int(this.battleModeItems.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.battleModeItems[_loc2_].removeEventListener(Event.CHANGE,this.onBattleModeChange);
            _loc2_++;
         }
      }
      
      private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void
      {
         this.findBattleButton.enabled = true;
      }
      
      private function onBattleModeChange(param1:Event) : void
      {
         var _loc2_:BattleModeCheckBox = BattleModeCheckBox(param1.currentTarget);
         this._callback.onBattleModeChange(_loc2_.battleMode,_loc2_.isPressed);
      }
      
      public function unPressFilter(param1:BattleMode) : void
      {
         this.getBattleModeCheckBox(param1).isPressed = false;
      }
      
      public function lockFilter(param1:BattleMode) : void
      {
         this.getBattleModeCheckBox(param1).lock = true;
      }
      
      public function unLockFilter(param1:BattleMode) : void
      {
         this.getBattleModeCheckBox(param1).lock = false;
      }
      
      private function getBattleModeCheckBox(param1:BattleMode) : BattleModeCheckBox
      {
         var _loc2_:BattleModeCheckBox = null;
         for each(_loc2_ in this.battleModeItems)
         {
            if(_loc2_.battleMode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function updateScrollOnEnterFrame(param1:Event) : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         var _loc2_:ScrollBar = this._battleList.verticalScrollBar;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.numChildren)
         {
            _loc4_ = Sprite(_loc2_.getChildAt(_loc3_));
            if(_loc4_.hitArea != null)
            {
               _loc5_ = _loc4_.hitArea;
               _loc5_.graphics.clear();
            }
            else
            {
               _loc5_ = new Sprite();
               _loc5_.mouseEnabled = false;
               _loc4_.hitArea = _loc5_;
               this._battleList.addChild(_loc5_);
            }
            _loc5_.graphics.beginFill(0,0);
            if(_loc4_ is LabelButton)
            {
               _loc5_.graphics.drawRect(_loc2_.x - ADDITIONAL_SCROLL_AREA_HEIGHT,_loc4_.y - 14,_loc4_.width + ADDITIONAL_SCROLL_AREA_HEIGHT,_loc4_.height + 28);
            }
            else
            {
               _loc5_.graphics.drawRect(_loc2_.x - ADDITIONAL_SCROLL_AREA_HEIGHT,_loc4_.y,_loc4_.width + ADDITIONAL_SCROLL_AREA_HEIGHT,_loc4_.height);
            }
            _loc5_.graphics.endFill();
            _loc3_++;
         }
      }
      
      public function resize(param1:Boolean = true) : void
      {
         clearTimeout(this._timeOutResize);
         var _loc2_:int = Math.max(MIN_FLASH_WIDTH,this.getStage().stageWidth) / 3;
         var _loc3_:int = Math.max(this.getStage().stageHeight - HEADER_HEIGHT,MIN_FLASH_HEIGHT);
         this._window.width = _loc2_;
         this._window.height = _loc3_;
         this.x = _loc2_;
         this.y = HEADER_HEIGHT;
         this._inner.width = _loc2_ - 22;
         this._inner.height = _loc3_ - 115;
         this._inner.x = 11;
         this._inner.y = 67;
         this.findBattleButton.x = (_loc2_ - this.findBattleButton.width) / 2;
         var _loc4_:int = this._inner.width - (this._battleList.verticalScrollBar.visible ? 0 : 4);
         this._battleList.setSize(_loc4_,this._inner.height - 8);
         var _loc5_:int = int(this.battleModeItems.length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc6_ == 0)
            {
               this.battleModeItems[_loc6_].x = 11;
            }
            else
            {
               this.battleModeItems[_loc6_].x = this.battleModeItems[_loc6_ - 1].x + this.battleModeItems[_loc6_ - 1].width + 5;
            }
            this.battleModeItems[_loc6_].y = _loc3_ - 42;
            _loc6_++;
         }
         this._createBattleButton.x = _loc2_ - this._createBattleButton.width - 11;
         this._createBattleButton.y = _loc3_ - 42;
         this.resizeItems(_loc4_);
         if(param1)
         {
            this.resizeWithDelay();
         }
      }
      
      private function resizeItems(param1:int) : void
      {
         var _loc3_:Object = null;
         this.iconWidth = param1 - (this._battleList.verticalScrollBar.visible ? 35 : 20);
         var _loc2_:int = 0;
         while(_loc2_ < this._dataProvider.length)
         {
            _loc3_ = this._dataProvider.getItemAt(_loc2_);
            BattleListItem(_loc3_.iconNormal).resize(this.iconWidth);
            this._dataProvider.invalidateItemAt(_loc2_);
            _loc2_++;
         }
      }
      
      private function resizeWithDelay() : void
      {
         clearTimeout(this._timeOutResize);
         this._timeOutResize = setTimeout(this.onResizeWithDelay,RESIZE_DELAY);
      }
      
      private function onResizeWithDelay() : void
      {
         this.resize(false);
      }
      
      public function sortBattleList() : void
      {
         if(this._dataProvider.length == 0)
         {
            return;
         }
         this._dataProvider.sortOn(["suspicionLevel","accessible","createdAt"],[Array.NUMERIC,Array.DESCENDING,0]);
      }
      
      public function resetSelectedItem() : void
      {
         this._battleList.selectedItem = null;
      }
      
      public function createItem(param1:BattleListItemParams, param2:Boolean) : void
      {
         var _loc3_:Object = new Object();
         var _loc4_:BattleInfoBaseParams = param1.params;
         var _loc5_:BattleCreateParameters = _loc4_.createParams;
         _loc3_.id = param1.id;
         _loc3_.accessible = param1.accessible;
         _loc3_.iconNormal = _loc3_.iconSelected = new BattleListItem(param1,this.iconWidth);
         _loc3_.suspicionLevel = _loc4_.suspicionLevel.value;
         _loc3_.dat = param1;
         _loc3_.friends = _loc4_.friends;
         _loc3_.modeIndex = this.getModeSortIndex(_loc5_.battleMode);
         var _loc6_:BattleLimits = _loc5_.limits;
         _loc3_.timeLimit = _loc6_.timeLimitInSec == 0 ? 999999 : _loc6_.timeLimitInSec;
         _loc3_.scoreLimit = _loc6_.scoreLimit == 0 ? 0 : _loc6_.scoreLimit;
         _loc3_.mapName = _loc4_.mapName;
         _loc3_.customName = _loc4_.customName;
         _loc3_.formatName = param1.formatName;
         _loc3_.proBattle = _loc5_.proBattle ? 0 : 1;
         _loc3_.isFull = this.isFullBattle(param1);
         _loc3_.createdAt = param1.id.toString();
         if(this.getItemIndex(param1.id) < 0)
         {
            this._dataProvider.addItem(_loc3_);
         }
         if(param2)
         {
            this.sortBattleList();
            this.resize();
            helpService.hideHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
         }
      }
      
      private function getModeSortIndex(param1:BattleMode) : int
      {
         switch(param1)
         {
            case BattleMode.CTF:
               return 1;
            case BattleMode.DM:
               return 2;
            case BattleMode.TDM:
               return 3;
            case BattleMode.CP:
               return 4;
            case BattleMode.AS:
               return 5;
            //case BattleMode.RUGBY:
            //   return 6;
            default:
               return 0;
         }
      }
      
      private function isFullBattle(param1:BattleListItemParams) : Boolean
      {
         if(param1.isDM)
         {
            return param1.dmParams.users.length == param1.params.createParams.maxPeopleCount;
         }
         return param1.teamParams.usersRed.length == param1.params.createParams.maxPeopleCount && param1.teamParams.usersBlue.length == param1.params.createParams.maxPeopleCount;
      }
      
      public function removeItem(param1:String) : void
      {
         var _loc2_:int = this.getItemIndex(param1);
         if(_loc2_ >= 0)
         {
            this._dataProvider.removeItemAt(_loc2_);
            this.resizeWithDelay();
         }
      }
      
      public function setSelect(param1:String) : void
      {
         var _loc2_:int = this.getItemIndex(param1);
         if(_loc2_ >= 0)
         {
            this._battleList.selectedIndex = _loc2_;
            this._battleList.scrollToSelected();
            if(this.getStage().focus != this._battleList)
            {
               this.getStage().focus = this._battleList;
            }
            this.lastSelectedBattleId = BattleListItemParams(this._battleList.selectedItem.dat).id;
         }
         else
         {
            this._battleList.selectedItem = null;
         }
         this._battleList.drawNow();
      }
      
      public function updateSuspicious(param1:String, param2:BattleSuspicionLevel) : void
      {
         var _loc4_:Object = null;
         var _loc5_:BattleListItemParams = null;
         var _loc3_:int = this.getItemIndex(param1);
         if(_loc3_ >= 0)
         {
            _loc4_ = this._dataProvider.getItemAt(_loc3_);
            _loc5_ = _loc4_.dat;
            BattleListItem(_loc4_.iconNormal).updateSuspicion(param2);
            _loc4_.suspicionLevel = param2.value;
            this._dataProvider.invalidateItemAt(_loc3_);
            this.sortBattleList();
         }
      }
      
      public function updateUsersCount(param1:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BattleListItemParams = null;
         var _loc2_:int = this.getItemIndex(param1);
         if(_loc2_ >= 0)
         {
            _loc3_ = this._dataProvider.getItemAt(_loc2_);
            _loc4_ = _loc3_.dat;
            BattleListItem(_loc3_.iconNormal).updateUsersCount();
            _loc3_.isFull = this.isFullBattle(_loc4_);
            this._dataProvider.invalidateItemAt(_loc2_);
         }
      }
      
      public function updateBattleName(param1:String) : void
      {
         var _loc2_:int = this.getItemIndex(param1);
         if(_loc2_ >= 0)
         {
            BattleListItem(this._dataProvider.getItemAt(_loc2_).iconNormal).updateBattleName();
            this._dataProvider.invalidateItemAt(_loc2_);
         }
      }
      
      public function swapTeams(param1:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BattleListItemParams = null;
         var _loc2_:int = this.getItemIndex(param1);
         if(_loc2_ >= 0)
         {
            _loc3_ = this._dataProvider.getItemAt(_loc2_);
            _loc4_ = _loc3_.dat;
            BattleListItem(_loc3_.iconNormal).updateUsersCount();
            _loc3_.isFull = this.isFullBattle(_loc4_);
            this._dataProvider.invalidateItemAt(_loc2_);
         }
      }
      
      public function updateAccessibleItems() : void
      {
         var _loc3_:Object = null;
         var _loc4_:BattleListItemParams = null;
         var _loc5_:Range = null;
         var _loc6_:Boolean = false;
         var _loc1_:int = int(this._dataProvider.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._dataProvider.getItemAt(_loc2_);
            _loc4_ = _loc3_.dat;
            _loc5_ = _loc4_.params.createParams.rankRange;
            _loc6_ = _loc5_.min <= userPropertiesService.rank && userPropertiesService.rank <= _loc5_.max;
            _loc4_.accessible = _loc6_;
            BattleListItem(_loc3_.iconNormal).updateAccessible();
            _loc3_.accessible = _loc6_;
            this._dataProvider.invalidateItemAt(_loc2_);
            _loc2_++;
         }
         this.sortBattleList();
      }
      
      public function getItemIndex(param1:String) : int
      {
         var _loc4_:Object = null;
         var _loc2_:int = int(this._dataProvider.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._dataProvider.getItemAt(_loc3_);
            if(_loc4_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function onResize(param1:Event) : void
      {
         this.resize();
      }
      
      private function onShowCreateBattleFormButtonClick(param1:MouseEvent) : void
      {
         this._callback.onShowCreateBattleFormButtonClick();
      }
      
      private function onBattleListItemClick(param1:ListEvent) : void
      {
         var _loc2_:String = BattleListItemParams(param1.item.dat).id;
         if(_loc2_ != this.lastSelectedBattleId)
         {
            this.lastSelectedBattleId = _loc2_;
         }
         this._callback.onBattleListItemClick(BattleListItemParams(param1.item.dat).params.battle);
         battleSelectActionsService.battleSelected(BattleListItemParams(param1.item.dat).createParams.battleMode,_loc2_);
         var _loc3_:Boolean = BattleListItemParams(param1.item.dat).accessible;
         if(!_loc3_)
         {
            this._lockedMapsHelper.targetPoint = new Point(this.getStage().mouseX,this.getStage().mouseY);
            helpService.showHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
         }
      }
      
      private function onListChange(param1:Event) : void
      {
         if(this._battleList.selectedItem != null)
         {
            this._callback.onBattleListItemChange(BattleListItemParams(this._battleList.selectedItem.dat).params.battle);
         }
      }
      
      private function onBackToMatchmakingClick(param1:MouseEvent) : void
      {
         this.findBattleButton.enabled = false;
         this._callback.onBackToMatchmakingClick();
      }
      
      private function getContainer() : DisplayObjectContainer
      {
         return display.systemLayer;
      }
      
      private function getStage() : Stage
      {
         return display.stage;
      }
      
      public function setBattleButtonEnabled(param1:Boolean) : void
      {
         this.findBattleButton.enabled = param1;
      }
      
      public function setBattleCreationEnabled(param1:Boolean) : void
      {
         this._createBattleButton.visible = param1;
      }
   }
}

