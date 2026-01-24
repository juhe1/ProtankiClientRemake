package alternativa.tanks.gui.news
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.startup.CacheLoader;
   import alternativa.tanks.gui.communication.tabs.news.NewsTab;
   import alternativa.tanks.gui.frames.GreenFrame;
   import alternativa.tanks.services.NewsService;
   import controls.base.LabelBase;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.globalization.DateTimeFormatter;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import forms.ColorConstants;
   import projects.tanks.client.chat.models.news.showing.NewsItemData;
   import projects.tanks.client.commons.types.ShopCategoryEnum;
   import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   
   public class NewsItem extends Sprite
   {
      
      [Inject] // added
      public static var paymentDisplayService:PaymentDisplayService;
      
      [Inject] // added
      public static var newsService:NewsService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var rankService:RankService;
      
      private static const WIDTH:int = 280;
      
      private static const TEXT_LEFT_MARGIN:int = 80;
      
      private static const GAP:int = 5;
      
      private static const MIN_HEIGHT:int = 80;
      
      private static const BOTTOM_GAP:int = 27;
      
      private var newsHeader:LabelBase = new LabelBase();
      
      private var newsText:LabelBase = new LabelBase();
      
      private var shopCategories:Dictionary = new Dictionary();
      
      private var frame:GreenFrame;
      
      private var newsItem:NewsItemData;
      
      private var timer:Timer;
      
      private var newsTab:NewsTab;
      
      public function NewsItem(param1:NewsItemData, param2:NewsTab, param3:int)
      {
         super();
         this.newsItem = param1;
         this.newsTab = param2;
         if(!newsService.isViewed(param1) && param2 != null)
         {
            this.frame = new GreenFrame(WIDTH,MIN_HEIGHT);
            addChild(this.frame);
         }
         this.addImage();
         this.addHeader();
         this.addDescription();
         if(param3 > 0 && param2 != null)
         {
            this.timer = new Timer(param3);
            this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this.timer.start();
         }
         this.initShopCategoriesDictionary();
      }
      
      private static function replaceAllMetaVars(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:RegExp = null;
         var _loc2_:Dictionary = createMetaVars();
         for(_loc3_ in _loc2_)
         {
            _loc4_ = new RegExp(_loc3_,"g");
            param1 = param1.replace(_loc4_,_loc2_[_loc3_]);
         }
         return param1;
      }
      
      private static function createMetaVars() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["%USERNAME%"] = userPropertiesService.userName;
         _loc1_["%ID%"] = userPropertiesService.userId;
         _loc1_["%RANK%"] = rankService.getRankName(userPropertiesService.fullRank);
         _loc1_["%RANK_NUM%"] = userPropertiesService.fullRank;
         _loc1_["%LOCALE%"] = localeService.language;
         _loc1_["%REG_DATETIME%"] = getFormattedRegistrationDateTime();
         return _loc1_;
      }
      
      private static function getFormattedRegistrationDateTime() : String
      {
         var _loc1_:Date = new Date(userPropertiesService.registrationTimestamp * 1000);
         var _loc2_:DateTimeFormatter = new DateTimeFormatter("en-US");
         _loc2_.setDateTimePattern("yyyy-MM-dd\'T\'HH:mm:ss");
         return _loc2_.format(_loc1_);
      }
      
      public function read() : void
      {
         if(!this.isRead())
         {
            removeChild(this.frame);
            newsService.setIsViewed(this.newsItem.id);
         }
      }
      
      public function isRead() : Boolean
      {
         return this.frame == null || !contains(this.frame);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this.timer = null;
         this.newsTab.removeNewsItem(this);
      }
      
      private function addImage() : void
      {
         var _loc1_:CacheLoader = new CacheLoader();
         var _loc2_:URLRequest = new URLRequest(this.newsItem.imageUrl);
         _loc1_.load(_loc2_);
         addChild(_loc1_);
         _loc1_.x = GAP;
         _loc1_.y = GAP;
      }
      
      private function addHeader() : void
      {
         this.newsHeader.x = TEXT_LEFT_MARGIN;
         this.newsHeader.y = GAP;
         this.newsHeader.htmlText = "<b>" + this.newsItem.header + "<\b>";
         this.newsHeader.width = WIDTH - TEXT_LEFT_MARGIN - GAP;
         this.newsHeader.color = ColorConstants.GREEN_LABEL;
         addChild(this.newsHeader);
      }
      
      private function addDescription() : void
      {
         this.newsText.x = TEXT_LEFT_MARGIN;
         this.newsText.y = 23;
         this.newsText.wordWrap = true;
         this.newsText.multiline = true;
         this.newsText.width = this.newsHeader.width;
         this.newsText.htmlText = replaceAllMetaVars(this.newsItem.description);
         this.newsText.color = ColorConstants.GREEN_LABEL;
         this.newsText.addEventListener(TextEvent.LINK,this.linkActivated);
         addChild(this.newsText);
      }
      
      private function initShopCategoriesDictionary() : void
      {
         var _loc1_:ShopCategoryEnum = null;
         this.shopCategories["shop"] = ShopCategoryEnum.NO_CATEGORY;
         for each(_loc1_ in ShopCategoryEnum.values)
         {
            this.shopCategories["shop/" + _loc1_.name.toLocaleLowerCase()] = _loc1_;
         }
      }
      
      private function linkActivated(param1:TextEvent) : void
      {
         var _loc2_:String = param1.text.toLowerCase();
         if(this.shopCategories.hasOwnProperty(_loc2_))
         {
            paymentDisplayService.openPaymentAt(this.shopCategories[_loc2_]);
         }
      }
      
      public function destroy() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
         this.newsText.removeEventListener(TextEvent.LINK,this.linkActivated);
      }
      
      public function resize(param1:int) : void
      {
         this.newsText.width = param1 - TEXT_LEFT_MARGIN - GAP;
         if(this.frame != null)
         {
            this.frame.setWidth(param1);
            this.frame.setHeight(this.getHeight());
         }
      }
      
      public function getHeight() : int
      {
         return Math.max(this.newsText.textHeight + BOTTOM_GAP,MIN_HEIGHT);
      }
   }
}

