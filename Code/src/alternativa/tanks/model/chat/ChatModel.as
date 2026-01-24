package alternativa.tanks.model.chat
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.startup.StartupSettings;
   import alternativa.tanks.gui.chat.CautionExternalLinkWindow;
   import alternativa.tanks.gui.chat.CautionExternalLinkWindowEvent;
   import alternativa.tanks.gui.chat.ChangeChatChannelEvent;
   import alternativa.tanks.gui.chat.SendChatMessageEvent;
   import alternativa.tanks.gui.communication.tabs.chat.ChatTab;
   import alternativa.tanks.gui.communication.tabs.chat.IChatTabView;
   import alternativa.tanks.tracker.ITrackerService;
   import alternativa.tanks.utils.Antiflood;
   import alternativa.tanks.utils.LinksInterceptor;
   import alternativa.types.Long;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
   import projects.tanks.client.chat.models.chat.chat.ChatModelBase;
   import projects.tanks.client.chat.models.chat.chat.IChatModelBase;
   import projects.tanks.client.chat.types.BattleChatLink;
   import projects.tanks.client.chat.types.ChatMessage;
   import projects.tanks.client.chat.types.MessageType;
   import projects.tanks.client.chat.types.UserStatus;
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
   
   [ModelInfo]
   public class ChatModel extends ChatModelBase implements IChatModelBase, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var trackerService:ITrackerService;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var userPropertyService:IUserPropertiesService;
      
      [Inject] // added
      public static var battleLinkActivatorService:IBattleLinkActivatorService;
      
      [Inject] // added
      public static var clientLog:IClientLog;
      
      [Inject] // added
      public static var lobbyChatView:IChatTabView;
      
      private static const LOG_CHANNEL_NAME:String = "chat";
      
      private const HTML_PATTERN:RegExp = /(<)(.*?)(>)/gi;
      
      private const BATTLE_ID_REG_EXP:RegExp = /^([0-9a-f]{16})$/gi;
      
      private var chatTab:ChatTab;
      
      private var selfUid:String;
      
      private var showLinks:Boolean;
      
      private var linksInterceptor:LinksInterceptor;
      
      private var htmlFlag:Boolean = false;
      
      private var sharpLinks:Array;
      
      private var isAdmin:Boolean;
      
      private var antiFloodEnabled:Boolean;
      
      private var chatEnabled:Boolean;
      
      private var privateMessagesEnabled:Boolean;
      
      private var battleId2Data:Dictionary;
      
      private var chatModeratorLevel:ChatModeratorLevel;
      
      private var isCautionExternalLinkWindowOpened:Boolean = false;
      
      private var cautionExternalLinkWindow:CautionExternalLinkWindow;
      
      public function ChatModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         this.battleId2Data = new Dictionary();
         this.selfUid = getInitParam().selfName;
         this.showLinks = getInitParam().showLinks;
         this.isAdmin = getInitParam().admin;
         this.antiFloodEnabled = getInitParam().antifloodEnabled;
         this.chatEnabled = getInitParam().chatEnabled;
         this.chatModeratorLevel = getInitParam().chatModeratorLevel;
         this.privateMessagesEnabled = getInitParam().privateMessagesEnabled;
         this.linksInterceptor = new LinksInterceptor(getInitParam().linksWhiteList);
         this.chatTab = new ChatTab(this.privateMessagesEnabled);
         this.chatTab.selfUid = this.selfUid;
         this.chatTab.typingAntifloodEnabled = getInitParam().typingSpeedAntifloodEnabled;
         this.chatTab.setChannels(getInitParam().channels);
         if(this.chatEnabled)
         {
            lobbyChatView.setChatTab(this.chatTab);
            this.onShowChatTab();
            this.chatTab.restoreCurrentChannel();
         }
         if(this.antiFloodEnabled)
         {
            Antiflood.init(getInitParam().linksWhiteList,getInitParam().minChar,getInitParam().minWord,getInitParam().bufferSize);
         }
         putData(ChatSettingsTracker,new ChatSettingsTracker(this.chatTab));
         trackerService.trackEvent(LOG_CHANNEL_NAME,"ChatStart","");
         this.prepareSharpLink();
      }
      
      public function objectUnloaded() : void
      {
         this.battleId2Data = null;
         this.chatTab.hide();
         if(this.chatEnabled)
         {
            this.onHideChatTab();
         }
      }
      
      private function onSendChatMessage(param1:SendChatMessageEvent) : void
      {
         var _loc2_:UserStatus = null;
         if(this.isAdmin || this.isPrivateMessage(param1) || !this.antiFloodEnabled || Antiflood.isNotFlood(param1.message))
         {
            server.sendMessage(param1.recipientUid,param1.addressMode,this.chatTab.getCurrentChannel(),param1.message);
            if(this.antiFloodEnabled)
            {
               Antiflood.getMessageKeys(param1.message,true);
            }
         }
         else
         {
            _loc2_ = new UserStatus(this.chatModeratorLevel,"",userPropertyService.rank,this.selfUid,userPropertyService.userId);
            this.chatTab.addMessageToCurrentChannel(_loc2_,null,param1.message);
            clientLog.log(LOG_CHANNEL_NAME,"onSendChatMessage : antiFlood : %1",param1.message);
         }
      }
      
      private function onChangeChannel(param1:ChangeChatChannelEvent) : void
      {
         server.changeChannel(param1.channel);
      }
      
      private function isPrivateMessage(param1:SendChatMessageEvent) : Boolean
      {
         return param1.recipientUid != "" && param1.addressMode == ChatAddressMode.PRIVATE;
      }
      
      public function showMessages(param1:Vector.<ChatMessage>) : void
      {
         var _loc2_:ChatMessage = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:BattleChatLink = null;
         var _loc6_:BattleInfoData = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.text;
            if(this.antiFloodEnabled)
            {
               Antiflood.getMessageKeys(_loc3_,true);
            }
            clientLog.log(LOG_CHANNEL_NAME,"showMessages : %1",_loc3_);
            this.htmlFlag = false;
            _loc4_ = int(_loc3_.search(this.HTML_PATTERN));
            if(_loc4_ > -1)
            {
               if(_loc2_.messageType == MessageType.USER)
               {
                  _loc3_ = _loc3_.replace(this.HTML_PATTERN,"&lt;$2&gt;");
               }
               this.htmlFlag = true;
            }
            _loc3_ += " ";
            if(this.showLinks && _loc2_.messageType == MessageType.USER)
            {
               _loc3_ = this.linksInterceptor.checkLinks(_loc3_);
               this.htmlFlag = this.linksInterceptor.htmlFlag;
            }
            for each(_loc5_ in _loc2_.battleLinks)
            {
               _loc6_ = new BattleInfoData();
               _loc6_.battleId = _loc5_.battleIdHex;//Long.fromHexString(_loc5_.battleIdHex);
               this.battleId2Data[_loc5_.battleIdHex] = _loc6_;
               _loc3_ = _loc3_.replace("#battle|" + _loc5_.battleIdHex,"<u><a href=\'event:" + _loc5_.battleIdHex + "\'>" + BattleInfoUtils.buildBattleName(_loc5_.battleName,_loc5_.battleMode) + "</a></u>");
               this.htmlFlag = true;
            }
            _loc3_ = this.replaceSharpLinks(_loc3_);
            if(_loc2_.channel == null)
            {
               this.chatTab.addMessageToCurrentChannel(_loc2_.sourceUser,_loc2_.targetUser,_loc3_,_loc2_.addressMode,_loc2_.messageType,this.htmlFlag);
            }
            else
            {
               this.chatTab.addMessage(_loc2_.sourceUser,_loc2_.targetUser,_loc2_.channel,_loc3_,_loc2_.addressMode,_loc2_.messageType,this.htmlFlag);
            }
         }
      }
      
      private function onShowChatTab() : void
      {
         this.chatTab.addEventListener(SendChatMessageEvent.SEND_CHAT_MESSAGE,getFunctionWrapper(this.onSendChatMessage));
         this.chatTab.addEventListener(ChangeChatChannelEvent.CHANGE_CHANNEL,getFunctionWrapper(this.onChangeChannel));
         this.chatTab.addEventListener(TextEvent.LINK,getFunctionWrapper(this.onTextLink));
      }
      
      private function onHideChatTab() : void
      {
         this.chatTab.removeEventListener(SendChatMessageEvent.SEND_CHAT_MESSAGE,getFunctionWrapper(this.onSendChatMessage));
         this.chatTab.removeEventListener(ChangeChatChannelEvent.CHANGE_CHANNEL,getFunctionWrapper(this.onChangeChannel));
         this.chatTab.removeEventListener(TextEvent.LINK,getFunctionWrapper(this.onTextLink));
      }
      
      private function onTextLink(param1:TextEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = param1.text;
         if(_loc2_.search(this.BATTLE_ID_REG_EXP) > -1)
         {
            _loc3_ = _loc2_.substr(_loc2_.length - 16);
            if(this.battleId2Data[_loc3_] != null)
            {
               battleLinkActivatorService.activateBattle(this.battleId2Data[_loc3_]);
            }
         }
         else
         {
            this.proceedExternalLink(_loc2_);
         }
      }
      
      private function proceedExternalLink(param1:String) : void
      {
         if(this.linksInterceptor.isInWhiteList(param1))
         {
            if(StartupSettings.isDesktop)
            {
               navigateToURL(new URLRequest(this.encodeIfNeeded(param1)),"_blank");
            }
            else
            {
               navigateToURL(new URLRequest(param1),"_blank");
            }
         }
         else if(!this.isCautionExternalLinkWindowOpened)
         {
            this.showCautionWindow(param1);
         }
      }
      
      private function encodeIfNeeded(param1:String) : String
      {
         return param1.indexOf("%") > 0 ? param1 : encodeURI(param1);
      }
      
      private function showCautionWindow(param1:String) : void
      {
         this.cautionExternalLinkWindow = new CautionExternalLinkWindow(param1);
         this.cautionExternalLinkWindow.addEventListener(CautionExternalLinkWindowEvent.CLOSING,this.onCautionWindowClose);
         this.cautionExternalLinkWindow.show();
         this.isCautionExternalLinkWindowOpened = true;
      }
      
      private function onCautionWindowClose(param1:CautionExternalLinkWindowEvent) : void
      {
         this.isCautionExternalLinkWindowOpened = false;
         this.cautionExternalLinkWindow.removeEventListener(CautionExternalLinkWindowEvent.CLOSING,this.onCautionWindowClose);
      }
      
      public function cleanUsersMessages(param1:String) : void
      {
         this.chatTab.cleanOutUsersMessages(param1);
      }
      
      private function prepareSharpLink() : void
      {
         this.sharpLinks = [localeService.getText(TanksLocale.TEXT_CHAT_SHARP_HELP).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_RULES).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_PLANS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_RANKS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_CLANS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_FORUM).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_UPDATES).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_THEFT).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_FEEDBACK).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_NICK).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_NEWS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_COMMANDS).split("|"),localeService.getText(TanksLocale.TEXT_CHAT_SHARP_WIKI).split("|")];
         var _loc1_:int = 0;
         while(_loc1_ < this.sharpLinks.length)
         {
            this.sharpLinks[_loc1_][0] = new RegExp("#" + this.sharpLinks[_loc1_][0],"gi");
            _loc1_++;
         }
      }
      
      private function replaceSharpLinks(param1:String) : String
      {
         var _loc5_:RegExp = null;
         var _loc2_:int = 0;
         var _loc3_:String = param1;
         var _loc4_:int = 0;
         while(_loc4_ < this.sharpLinks.length)
         {
            _loc5_ = this.sharpLinks[_loc4_][0];
            _loc2_ = int(_loc3_.search(_loc5_));
            if(_loc2_ > -1)
            {
               _loc3_ = _loc3_.replace(_loc5_,"<u><a href=\'" + this.sharpLinks[_loc4_][2] + "\' target=\'_blank\'>" + this.sharpLinks[_loc4_][1] + "</a></u>");
               this.htmlFlag = true;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function updateTypingSpeedAntifloodParams(param1:int, param2:int) : void
      {
         this.chatTab.updateTypingAntifloodParams(param1,param2);
      }
   }
}

