package alternativa.tanks.gui.communication
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.chat.dropdown.ChatDropDownList;
   import alternativa.tanks.gui.communication.button.CommunicationPanelTabButton;
   import alternativa.tanks.gui.communication.button.CommunicationPanelTabControl;
   import alternativa.tanks.gui.communication.button.TabButtonTypes;
   import alternativa.tanks.gui.communication.button.TabIcons;
   import alternativa.tanks.gui.communication.tabs.AbstractCommunicationPanelTab;
   import alternativa.tanks.gui.communication.tabs.chat.ChatTab;
   import alternativa.tanks.gui.communication.tabs.chat.ChatTabEvent;
   import alternativa.tanks.gui.communication.tabs.chat.ChatTabViewEvent;
   import alternativa.tanks.gui.communication.tabs.chat.IChatTabView;
   import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatTab;
   import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatTabNewMessageEvent;
   import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatViewEvent;
   import alternativa.tanks.gui.communication.tabs.clanchat.IClanChatView;
   import alternativa.tanks.gui.communication.tabs.news.NewsTab;
   import alternativa.tanks.gui.communication.tabs.news.NewsTabNewsItemAddedEvent;
   import alternativa.tanks.gui.friends.button.friends.NewRequestIndicator;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.services.NewsService;
   import base.DiscreteSprite;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import forms.TankWindowWithHeader;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   
   public class CommunicationPanel extends DiscreteSprite
   {
      
      [Inject] // added
      public static var chatTabView:IChatTabView;
      
      [Inject] // added
      public static var clanChatView:IClanChatView;
      
      //[Inject]
      //public static var clanUserInfoService:ClanUserInfoService;
      
      [Inject] // added
      public static var settingsService:ISettingsService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      [Inject] // added
      public static var newsService:NewsService;
      
      private static const WINDOW_MARGIN:int = 12;
      
      private static const BUTTON_WIDTH:int = 102;
      
      private static const GAP:int = 5;
      
      private static const LAST_SHOWN_COMMUNICATOR_TAB:String = "LAST_SHOWED_COMMUNICATOR_TAB";
      
      private var window:TankWindowWithHeader;
      
      private var buttonsPanel:Sprite = new Sprite();
      
      private var buttonsPanelVisibleHeight:int;
      
      private var category2tab:Dictionary = new Dictionary();
      
      private var category2button:Dictionary = new Dictionary();
      
      private var activeTab:AbstractCommunicationPanelTab;
      
      private var activeTabWidth:int;
      
      private var activeTabHeight:int;
      
      private var newsNotifier:Bitmap = new NewRequestIndicator.attentionIconClass();
      
      private var clanChatNotifier:Bitmap = new NewRequestIndicator.attentionIconClass();
      
      private var previousTabCategory:String;
      
      public function CommunicationPanel()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.configUI);
         addEventListener(Event.ADDED_TO_STAGE,this.addResizeListener);
         addEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         //clanUserInfoService.addEventListener(ClanUserInfoEvent.ON_LEAVE_CLAN,this.onLeaveClan);
         //clanUserInfoService.addEventListener(ClanUserInfoEvent.ON_JOIN_CLAN,this.onJoinClan);
         this.setPreviousTabCategory();
         newsService.setHasUnreadNewsCallback(this.showNewsIfHasUnread);
      }
      
      private function setPreviousTabCategory() : void
      {
         this.previousTabCategory = storageService.getStorage().data.hasOwnProperty(LAST_SHOWN_COMMUNICATOR_TAB) ? storageService.getStorage().data[LAST_SHOWN_COMMUNICATOR_TAB] : TabButtonTypes.NEWS_TAB;
      }
      
      private function showNewsIfHasUnread() : void
      {
         this.previousTabCategory = TabButtonTypes.NEWS_TAB;
         if(Boolean(this.category2tab.hasOwnProperty(this.previousTabCategory)) && !this.category2tab[this.previousTabCategory].isActive)
         {
            this.selectCategory(this.previousTabCategory);
         }
      }
      
      private function onJoinClan(param1:ClanUserInfoEvent) : void
      {
         clanChatView.updateClanChatView();
      }
      
      private function onLeaveClan(param1:ClanUserInfoEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(this.activeTab == this.category2tab[TabButtonTypes.CLAN_CHAT_TAB])
         {
            this.selectCategory(TabButtonTypes.NEWS_TAB);
         }
         if(this.category2button.hasOwnProperty(TabButtonTypes.CLAN_CHAT_TAB))
         {
            _loc2_ = this.category2button[TabButtonTypes.CLAN_CHAT_TAB];
            this.buttonsPanel.removeChild(_loc2_);
            delete this.category2button[TabButtonTypes.CLAN_CHAT_TAB];
         }
         removeChild(this.clanChatNotifier);
      }
      
      public function configUI(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.configUI);
         this.buttonsPanel.x = WINDOW_MARGIN;
         this.buttonsPanel.y = WINDOW_MARGIN;
         this.buttonsPanelVisibleHeight = new CommunicationPanelTabButton("","",TabIcons.newsIconClass).height;
         addChild(this.buttonsPanel);
         this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_COMMUNICATOR);
         addChild(this.window);
         this.addNewsItemsTab();
         var _loc2_:ChatTab = chatTabView.getChatTab();
         if(_loc2_ != null)
         {
            this.addChatTab(_loc2_);
         }
         else
         {
            chatTabView.addEventListener(ChatTabViewEvent.CHAT_TAB_CREATED,this.onChatTabCreated);
         }
         var _loc3_:ClanChatTab = clanChatView.getClanChat();
         if(_loc3_ != null)
         {
            this.addClanChatTab(_loc3_);
         }
         else
         {
            clanChatView.addEventListener(ClanChatViewEvent.CLAN_CHAT_ADDED,this.onClanChatTabCreated);
         }
         this.moveButtonsAndNotifiersToTop();
         this.onResize();
      }
      
      private function onClanChatTabCreated(param1:ClanChatViewEvent) : void
      {
         clanChatView.removeEventListener(ClanChatViewEvent.CLAN_CHAT_ADDED,this.onClanChatTabCreated);
         this.addClanChatTab(clanChatView.getClanChat());
      }
      
      private function onChatTabCreated(param1:ChatTabViewEvent) : void
      {
         chatTabView.removeEventListener(ChatTabViewEvent.CHAT_TAB_CREATED,this.onChatTabCreated);
         this.addChatTab(chatTabView.getChatTab());
      }
      
      private function addNewsItemsTab() : void
      {
         this.addNewsNotifier();
         var _loc1_:CommunicationPanelTabButton = new CommunicationPanelTabButton(TabButtonTypes.NEWS_TAB,localeService.getText(TanksLocale.TEXT_NEWS_TAB_HEADER),TabIcons.newsIconClass);
         this.addTabControl(TabButtonTypes.NEWS_TAB,_loc1_,0,false);
         var _loc2_:NewsTab = new NewsTab();
         this.category2tab[TabButtonTypes.NEWS_TAB] = _loc2_;
         _loc2_.x = WINDOW_MARGIN;
         _loc2_.y = this.buttonsPanel.y + this.buttonsPanelVisibleHeight + GAP;
         _loc2_.isActive = true;
         _loc2_.addEventListener(NewsTabNewsItemAddedEvent.NEWS_ITEM_ADDED,this.onNewsItemAdded);
         addChild(_loc2_);
         this.activeTab = _loc2_;
         this.activeTab.resize(this.activeTabWidth,this.activeTabHeight);
      }
      
      private function addNewsNotifier() : void
      {
         this.newsNotifier.y = WINDOW_MARGIN >> 1;
         this.newsNotifier.x = BUTTON_WIDTH;
         this.newsNotifier.visible = false;
         addChild(this.newsNotifier);
      }
      
      private function addChatTab(param1:ChatTab) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc4_:ChatDropDownList = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         chatTabView.clear();
         this.category2tab[TabButtonTypes.CHAT_TAB] = param1;
         param1.addEventListener(ChatTabEvent.HIDE_CHAT,this.onHideChat);
         param1.addEventListener(ChatTabEvent.SHOW_CHAT,this.onShowChat);
         param1.x = WINDOW_MARGIN;
         param1.y = this.buttonsPanel.y + this.buttonsPanelVisibleHeight + GAP;
         var _loc3_:Vector.<String> = param1.getChannels();
         if(_loc3_.length <= 1)
         {
            _loc2_ = new CommunicationPanelTabButton(TabButtonTypes.CHAT_TAB,localeService.getText(TanksLocale.TEXT_CHAT_TAB_HEADER),TabIcons.chatIconClass);
         }
         else
         {
            _loc4_ = new ChatDropDownList(TabButtonTypes.CHAT_TAB);
            _loc2_ = _loc4_;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = _loc3_[_loc5_];
               _loc7_ = {
                  "gameName":_loc6_,
                  "rang":0
               };
               _loc4_.addItem(_loc7_);
               _loc5_++;
            }
            _loc4_.selectItemByField("gameName",param1.getCurrentChannel());
            _loc4_.addEventListener(Event.CHANGE,param1.onChangeChannel);
         }
         this.addTabControl(TabButtonTypes.CHAT_TAB,_loc2_,BUTTON_WIDTH + GAP,true);
         addChild(param1);
         if(!settingsService.showChat)
         {
            this.onHideChat();
            return;
         }
         if(this.previousTabCategory == TabButtonTypes.CHAT_TAB)
         {
            this.selectCategory(TabButtonTypes.CHAT_TAB);
         }
      }
      
      private function addClanChatTab(param1:ClanChatTab) : void
      {
         clanChatView.clear();
         var _loc2_:CommunicationPanelTabButton = new CommunicationPanelTabButton(TabButtonTypes.CLAN_CHAT_TAB,localeService.getText(TanksLocale.TEXT_CLAN_CHAT),TabIcons.clanChatIconClass);
         this.addTabControl(TabButtonTypes.CLAN_CHAT_TAB,_loc2_,settingsService.showChat ? (BUTTON_WIDTH + GAP) * 2 : BUTTON_WIDTH + GAP,true);
         this.category2tab[TabButtonTypes.CLAN_CHAT_TAB] = param1;
         param1.x = WINDOW_MARGIN;
         param1.y = this.buttonsPanel.y + this.buttonsPanelVisibleHeight + GAP;
         addChild(param1);
         if(this.previousTabCategory == TabButtonTypes.CLAN_CHAT_TAB)
         {
            this.selectCategory(TabButtonTypes.CLAN_CHAT_TAB);
         }
         this.addClanChatNotifier();
         param1.addEventListener(ClanChatTabNewMessageEvent.NEW_MESSAGE,this.onNewClanChatMessage);
      }
      
      private function addClanChatNotifier() : void
      {
         var _loc1_:DisplayObject = this.category2button[TabButtonTypes.CLAN_CHAT_TAB];
         this.clanChatNotifier.x = _loc1_.x + BUTTON_WIDTH;
         this.clanChatNotifier.y = WINDOW_MARGIN >> 1;
         this.clanChatNotifier.visible = false;
         addChild(this.clanChatNotifier);
      }
      
      private function onNewClanChatMessage(param1:ClanChatTabNewMessageEvent) : void
      {
         var _loc2_:ClanChatTab = this.category2tab[TabButtonTypes.CLAN_CHAT_TAB];
         if(!_loc2_.isActive)
         {
            this.clanChatNotifier.visible = true;
         }
      }
      
      private function addTabControl(param1:String, param2:DisplayObject, param3:Number, param4:Boolean) : void
      {
         param2.width = BUTTON_WIDTH;
         param2.x = param3;
         param2.addEventListener(MouseEvent.CLICK,this.onTabButtonClick);
         (param2 as CommunicationPanelTabControl).enabled = param4;
         this.buttonsPanel.addChild(param2);
         this.category2button[param1] = param2;
      }
      
      private function onNewsItemAdded(param1:NewsTabNewsItemAddedEvent) : void
      {
         var _loc2_:NewsTab = this.category2tab[TabButtonTypes.NEWS_TAB];
         if(!_loc2_.isActive)
         {
            this.newsNotifier.visible = true;
         }
      }
      
      private function onShowChat(param1:ChatTabEvent) : void
      {
         var _loc2_:DisplayObject = this.category2button[TabButtonTypes.CHAT_TAB];
         if(!this.buttonsPanel.contains(_loc2_))
         {
            this.buttonsPanel.addChild(_loc2_);
            this.selectCategory(TabButtonTypes.CHAT_TAB);
            this.moveClanChatButtonIfExists((BUTTON_WIDTH + GAP) * 2);
         }
      }
      
      private function onHideChat(param1:ChatTabEvent = null) : void
      {
         if(this.activeTab == this.category2tab[TabButtonTypes.CHAT_TAB])
         {
            this.selectCategory(TabButtonTypes.NEWS_TAB);
         }
         var _loc2_:DisplayObject = this.category2button[TabButtonTypes.CHAT_TAB];
         if(_loc2_ != null && this.buttonsPanel.contains(_loc2_))
         {
            this.buttonsPanel.removeChild(_loc2_);
            this.moveClanChatButtonIfExists(BUTTON_WIDTH + GAP);
         }
      }
      
      private function moveClanChatButtonIfExists(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         if(this.category2button.hasOwnProperty(TabButtonTypes.CLAN_CHAT_TAB))
         {
            _loc2_ = this.category2button[TabButtonTypes.CLAN_CHAT_TAB];
            _loc2_.x = param1;
            this.clanChatNotifier.x = param1 + BUTTON_WIDTH;
         }
      }
      
      private function onTabButtonClick(param1:MouseEvent) : void
      {
         var _loc2_:CommunicationPanelTabControl = null;
         if(param1.target is CommunicationPanelTabControl)
         {
            _loc2_ = CommunicationPanelTabControl(param1.target);
            this.selectCategory(_loc2_.getCategory());
         }
      }
      
      private function selectCategory(param1:String) : void
      {
         var _loc4_:CommunicationPanelTabControl = null;
         var _loc5_:AbstractCommunicationPanelTab = null;
         removeChild(this.activeTab);
         this.activeTab = this.category2tab[param1];
         addChild(this.activeTab);
         this.activeTab.resize(this.activeTabWidth,this.activeTabHeight);
         this.activeTab.render();
         this.activeTab.isActive = true;
         var _loc2_:CommunicationPanelTabControl = this.category2button[param1];
         _loc2_.enabled = false;
         var _loc3_:int = 0;
         while(_loc3_ < this.buttonsPanel.numChildren)
         {
            _loc4_ = this.buttonsPanel.getChildAt(_loc3_) as CommunicationPanelTabControl;
            if(_loc2_ != _loc4_)
            {
               _loc4_.enabled = true;
               _loc5_ = this.category2tab[_loc4_.getCategory()];
               _loc5_.isActive = false;
               _loc5_.hide();
            }
            _loc3_++;
         }
         storageService.getStorage().data[LAST_SHOWN_COMMUNICATOR_TAB] = param1;
         if(param1 == TabButtonTypes.NEWS_TAB)
         {
            this.newsNotifier.visible = false;
         }
         if(param1 == TabButtonTypes.CLAN_CHAT_TAB)
         {
            this.clanChatNotifier.visible = false;
         }
         this.moveButtonsAndNotifiersToTop();
      }
      
      private function moveButtonsAndNotifiersToTop() : void
      {
         if(contains(this.buttonsPanel))
         {
            removeChild(this.buttonsPanel);
            addChild(this.buttonsPanel);
         }
         if(contains(this.newsNotifier))
         {
            removeChild(this.newsNotifier);
            addChild(this.newsNotifier);
         }
         if(contains(this.clanChatNotifier))
         {
            removeChild(this.clanChatNotifier);
            addChild(this.clanChatNotifier);
         }
      }
      
      private function addResizeListener(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function destroy(param1:Event) : void
      {
         stage.removeEventListener(Event.RESIZE,this.onResize);
         var _loc2_:ChatTab = this.category2tab[TabButtonTypes.CHAT_TAB];
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener(ChatTabEvent.HIDE_CHAT,this.onHideChat);
            _loc2_.removeEventListener(ChatTabEvent.SHOW_CHAT,this.onShowChat);
         }
         var _loc3_:ClanChatTab = this.category2tab[TabButtonTypes.CLAN_CHAT_TAB];
         if(_loc3_ != null)
         {
            _loc3_.removeEventListener(ClanChatTabNewMessageEvent.NEW_MESSAGE,this.onNewClanChatMessage);
         }
         newsService.resetHasUnreadNewsCallback();
         var _loc4_:NewsTab = this.category2tab[TabButtonTypes.NEWS_TAB];
         _loc4_.removeEventListener(NewsTabNewsItemAddedEvent.NEWS_ITEM_ADDED,this.onNewsItemAdded);
         _loc4_.destroy();
         chatTabView.removeEventListener(ChatTabViewEvent.CHAT_TAB_CREATED,this.onChatTabCreated);
         clanChatView.removeEventListener(ClanChatViewEvent.CLAN_CHAT_ADDED,this.onClanChatTabCreated);
         //clanUserInfoService.removeEventListener(ClanUserInfoEvent.ON_LEAVE_CLAN,this.onLeaveClan);
         //clanUserInfoService.removeEventListener(ClanUserInfoEvent.ON_JOIN_CLAN,this.onJoinClan);
      }
      
      private function onResize(param1:Event = null) : void
      {
         x = 0;
         y = 60;
         var _loc2_:int = int(Math.max(970,stage.stageWidth));
         this.window.width = _loc2_ / 3;
         this.window.height = Math.max(stage.stageHeight - 60,530);
         this.activeTabWidth = this.window.width - WINDOW_MARGIN * 2;
         this.activeTabHeight = this.window.height - WINDOW_MARGIN * 2 - GAP - this.buttonsPanelVisibleHeight;
         this.activeTab.resize(this.activeTabWidth,this.activeTabHeight);
      }
   }
}

