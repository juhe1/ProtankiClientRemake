package alternativa.tanks.gui.communication.tabs.news
{
   import alternativa.tanks.gui.communication.tabs.*;
   import alternativa.tanks.gui.news.NewsItem;
   import alternativa.tanks.services.NewsService;
   import alternativa.tanks.services.NewsServiceEvent;
   import alternativa.types.Long;
   import controls.TankWindowInner;
   import controls.base.LabelBase;
   import fl.containers.ScrollPane;
   import fl.controls.ScrollPolicy;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import forms.ColorConstants;
   import projects.tanks.client.chat.models.news.showing.NewsItemData;
   import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
   import utils.ScrollStyleUtils;
   
   public class NewsTab extends AbstractCommunicationPanelTab
   {
      
      [Inject] // added
      public static var newsService:NewsService;
      
      private static const AROUND_GAP:int = 25;
      
      private static const SCROLL_GAP:int = 5;
      
      private static const SCROLL_PANE_BOTTOM_PADDING:int = 15;
      
      private static const SCROLL_SHIFT_GAP:int = 5;
      
      private static const SCROLL_SPEED_MULTIPLIER:int = 3;
      
      private static const LEFT_MARGIN:int = 10;
      
      private static const VERTICAL_GAP:int = 12;
      
      private static const NEWS_VERTICAL_GAP:int = 24;
      
      private var scrollPane:ScrollPane = new ScrollPane();
      
      private var scrollContainer:Sprite = new Sprite();
      
      private var scrollPaneBottomPadding:Sprite = new Sprite();
      
      private var inner:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      
      private var scrollEnabled:Boolean;
      
      private var _width:int;
      
      private var _height:int;
      
      private var newsId2NewsItem:Dictionary = new Dictionary();
      
      public function NewsTab()
      {
         super();
         this.inner.showBlink = true;
         addChild(this.inner);
         this.scrollContainer.addChild(this.scrollPaneBottomPadding);
         ScrollStyleUtils.setGreenStyle(this.scrollPane);
         this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
         this.scrollPane.source = this.scrollContainer;
         this.scrollPane.update();
         this.scrollPane.focusEnabled = false;
         this.scrollPane.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
         this.inner.addChild(this.scrollPane);
         newsService.setNewsAddingCallback(this.addNewsItems);
         newsService.addEventListener(NewsServiceEvent.NEWS_ITEM_IS_SENT,this.onNewsItemAdded);
         newsService.addEventListener(NewsServiceEvent.NEWS_ITEM_IS_REMOVED,this.onNewsItemRemoved);
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:NewsItem = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.scrollContainer.numChildren)
         {
            _loc3_ = this.scrollContainer.getChildAt(_loc2_);
            if(_loc3_ is NewsItem)
            {
               _loc4_ = NewsItem(_loc3_);
               _loc5_ = _loc3_.y - (this.scrollEnabled ? this.scrollPane.verticalScrollPosition : 0);
               if(!_loc4_.isRead() && _loc3_.x <= mouseX && _loc3_.x + _loc3_.width >= mouseX && _loc5_ <= mouseY && _loc5_ + _loc3_.height >= mouseY)
               {
                  _loc4_.read();
                  break;
               }
            }
            _loc2_++;
         }
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         param1.delta *= SCROLL_SPEED_MULTIPLIER;
      }
      
      private function onNewsItemRemoved(param1:NewsServiceEvent) : void
      {
         var _loc2_:Long = param1.getNewsId();
         var _loc3_:NewsItem = this.newsId2NewsItem[_loc2_];
         if(_loc3_ != null)
         {
            this.removeNewsItem(_loc3_);
         }
      }
      
      public function removeNewsItem(param1:NewsItem) : void
      {
         param1.destroy();
         var _loc2_:int = this.scrollContainer.getChildIndex(param1);
         this.scrollContainer.removeChildAt(_loc2_);
         this.removeUnusedDateLabel(_loc2_);
         this.resize(this._width,this._height);
      }
      
      private function removeUnusedDateLabel(param1:int) : void
      {
         if(!(this.scrollContainer.getChildAt(param1 - 1) is LabelBase))
         {
            return;
         }
         if(param1 == this.scrollContainer.numChildren || this.scrollContainer.getChildAt(param1) is LabelBase)
         {
            this.scrollContainer.removeChildAt(param1 - 1);
         }
      }
      
      private function onNewsItemAdded(param1:NewsServiceEvent) : void
      {
         var _loc6_:LabelBase = null;
         var _loc2_:NewsItemData = param1.getNewsItem();
         var _loc3_:Long = _loc2_.id;
         if(this.newsId2NewsItem[_loc3_] != null)
         {
            return;
         }
         var _loc4_:NewsItem = this.createNewsItem(_loc2_);
         if(_loc4_ == null)
         {
            return;
         }
         this.newsId2NewsItem[_loc3_] = _loc4_;
         var _loc5_:String = this.getDateString(_loc2_.dateInSeconds);
         if(this.scrollContainer.numChildren > 1)
         {
            _loc6_ = this.scrollContainer.getChildAt(1) as LabelBase;
            if(_loc5_ == _loc6_.text)
            {
               this.scrollContainer.addChildAt(_loc4_,2);
            }
            else
            {
               this.addNewsItemAndNewDateBlock(_loc4_,_loc5_);
            }
         }
         else
         {
            this.addNewsItemAndNewDateBlock(_loc4_,_loc5_);
         }
         this.resize(this._width,this._height);
         dispatchEvent(new NewsTabNewsItemAddedEvent());
      }
      
      private function createNewsItem(param1:NewsItemData) : NewsItem
      {
         var _loc2_:int = 0;
         if(param1.endDate > 0)
         {
            _loc2_ = param1.endDate * 1000 - new Date().time;
            if(_loc2_ < 5000)
            {
               return null;
            }
         }
         var _loc3_:NewsItem = new NewsItem(param1,this,_loc2_);
         _loc3_.x = LEFT_MARGIN;
         return _loc3_;
      }
      
      private function addNewsItemAndNewDateBlock(param1:NewsItem, param2:String) : void
      {
         this.scrollContainer.addChildAt(param1,1);
         var _loc3_:LabelBase = new LabelBase();
         _loc3_.htmlText = param2;
         _loc3_.textColor = ColorConstants.NEWS_DATE;
         this.scrollContainer.addChildAt(_loc3_,1);
      }
      
      override public function resize(param1:int, param2:int) : void
      {
         this._width = param1;
         this._height = param2;
         this.scrollPane.y = SCROLL_GAP;
         this.scrollPane.setSize(param1 + SCROLL_SHIFT_GAP,param2 - SCROLL_GAP * 2);
         this.inner.width = param1;
         this.inner.height = param2;
         var _loc3_:int = this.resizeAll(param1 - 20);
         this.scrollEnabled = false;
         if(this.scrollPane.height < _loc3_ + SCROLL_SHIFT_GAP * 2)
         {
            _loc3_ = this.resizeAll(param1 - 25);
            this.scrollEnabled = true;
         }
         this.fixScrollPaneBottomPadding(_loc3_);
         this.scrollPane.update();
      }
      
      private function fixScrollPaneBottomPadding(param1:int) : void
      {
         this.scrollPaneBottomPadding.graphics.lineStyle(1,ColorConstants.WHITE,0);
         this.scrollPaneBottomPadding.graphics.beginFill(ColorConstants.WHITE,0);
         this.scrollPaneBottomPadding.graphics.drawRect(0,0,1,SCROLL_PANE_BOTTOM_PADDING);
         this.scrollPaneBottomPadding.graphics.endFill();
         this.scrollPaneBottomPadding.x = AROUND_GAP;
         this.scrollPaneBottomPadding.y = param1;
      }
      
      private function resizeAll(param1:int) : int
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:NewsItem = null;
         var _loc6_:LabelBase = null;
         var _loc2_:int = VERTICAL_GAP >> 1;
         var _loc3_:int = 0;
         while(_loc3_ < this.scrollContainer.numChildren)
         {
            _loc4_ = this.scrollContainer.getChildAt(_loc3_);
            if(_loc4_ is NewsItem)
            {
               _loc5_ = NewsItem(_loc4_);
               _loc5_.resize(param1);
               _loc5_.y = _loc2_;
               _loc2_ += _loc5_.getHeight() + NEWS_VERTICAL_GAP;
            }
            if(_loc4_ is LabelBase)
            {
               _loc6_ = LabelBase(_loc4_);
               _loc6_.x = param1 - _loc6_.textWidth >> 1;
               _loc6_.y = _loc2_;
               _loc2_ = _loc6_.y + _loc6_.textHeight + VERTICAL_GAP;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function addNewsItems(param1:Vector.<NewsItemData>) : void
      {
         var _loc3_:NewsItemData = null;
         var _loc4_:NewsItem = null;
         var _loc5_:String = null;
         var _loc6_:LabelBase = null;
         this.clearAll();
         var _loc2_:String = "";
         for each(_loc3_ in param1)
         {
            _loc4_ = this.createNewsItem(_loc3_);
            if(_loc4_ != null)
            {
               _loc5_ = this.getDateString(_loc3_.dateInSeconds);
               if(_loc2_ != _loc5_)
               {
                  _loc2_ = _loc5_;
                  _loc6_ = new LabelBase();
                  _loc6_.htmlText = _loc2_;
                  _loc6_.textColor = ColorConstants.NEWS_DATE;
                  this.scrollContainer.addChild(_loc6_);
               }
               this.newsId2NewsItem[_loc3_.id] = _loc4_;
               this.scrollContainer.addChild(_loc4_);
            }
         }
         this.resize(this._width,this._height);
      }
      
      private function getDateString(param1:int) : String
      {
         var _loc2_:Date = new Date();
         _loc2_.setTime(param1 * 1000);
         return DateFormatter.formatDateToLocalized(_loc2_);
      }
      
      private function clearAll() : void
      {
         this.scrollContainer = new Sprite();
         this.scrollPaneBottomPadding = new Sprite();
         this.scrollContainer.addChild(this.scrollPaneBottomPadding);
         this.scrollPane.source = this.scrollContainer;
         this.scrollPane.update();
         newsService.clearExpiredReadNews();
      }
      
      public function destroy() : void
      {
         var _loc2_:NewsItem = null;
         newsService.resetNewsAddingCallback();
         this.scrollPane.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         newsService.removeEventListener(NewsServiceEvent.NEWS_ITEM_IS_SENT,this.onNewsItemAdded);
         newsService.removeEventListener(NewsServiceEvent.NEWS_ITEM_IS_REMOVED,this.onNewsItemRemoved);
         removeEventListener(MouseEvent.CLICK,this.onClick);
         var _loc1_:int = 0;
         while(_loc1_ < this.scrollContainer.numChildren)
         {
            _loc2_ = this.scrollContainer.getChildAt(_loc1_) as NewsItem;
            if(_loc2_ != null)
            {
               _loc2_.destroy();
            }
            _loc1_++;
         }
      }
   }
}

