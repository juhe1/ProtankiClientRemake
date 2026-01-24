package alternativa.tanks.services
{
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import projects.tanks.client.chat.models.news.showing.NewsItemData;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   
   public class NewsServiceImpl extends EventDispatcher implements NewsService
   {
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      private static const READ_NEWS:String = "NEWS_SERVICE_READ_NEWS";
      
      private var newsItems:Vector.<NewsItemData>;
      
      private var newsItemsAddingCallback:Function;
      
      private var hasUnreadNewsCallback:Function;
      
      public function NewsServiceImpl()
      {
         super();
      }
      
      public function setInitialNewsItems(param1:Vector.<NewsItemData>) : void
      {
         this.newsItems = param1.concat();
         if(this.newsItemsAddingCallback != null)
         {
            this.newsItemsAddingCallback(param1);
         }
         if(this.hasUnreadNewsCallback != null && this.hasUnreadNews())
         {
            this.hasUnreadNewsCallback();
         }
      }
      
      public function addNewsItem(param1:NewsItemData) : void
      {
         var _loc2_:NewsServiceEvent = null;
         if(this.newsItems == null)
         {
            this.newsItems = new Vector.<NewsItemData>();
         }
         this.newsItems.unshift(param1);
         if(this.newsItemsAddingCallback != null)
         {
            _loc2_ = new NewsServiceEvent(NewsServiceEvent.NEWS_ITEM_IS_SENT);
            _loc2_.setNewsItem(param1);
            dispatchEvent(_loc2_);
         }
      }
      
      public function setIsViewed(param1:Long) : void
      {
         var _loc2_:Object = storageService.getStorage().data[READ_NEWS];
         if(_loc2_ == null)
         {
            _loc2_ = {};
         }
         _loc2_[param1.toString()] = "";
         storageService.getStorage().data[READ_NEWS] = _loc2_;
      }
      
      public function removeNewsItem(param1:Long) : void
      {
         var _loc2_:NewsServiceEvent = new NewsServiceEvent(NewsServiceEvent.NEWS_ITEM_IS_REMOVED);
         _loc2_.setNewsId(param1);
         dispatchEvent(_loc2_);
      }
      
      public function setNewsAddingCallback(param1:Function) : void
      {
         if(this.newsItems != null)
         {
            param1(this.newsItems);
         }
         else
         {
            this.newsItemsAddingCallback = param1;
         }
      }
      
      public function setHasUnreadNewsCallback(param1:Function) : void
      {
         if(this.newsItems == null)
         {
            this.hasUnreadNewsCallback = param1;
         }
         else if(this.hasUnreadNews())
         {
            param1();
         }
      }
      
      private function hasUnreadNews() : Boolean
      {
         var _loc1_:NewsItemData = null;
         for each(_loc1_ in this.newsItems)
         {
            if(!this.isViewed(_loc1_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isViewed(param1:NewsItemData) : Boolean
      {
         var _loc2_:Object = storageService.getStorage().data[READ_NEWS];
         if(!_loc2_)
         {
            return false;
         }
         return _loc2_.hasOwnProperty(param1.id.toString());
      }
      
      public function clearExpiredReadNews() : void
      {
         var _loc3_:String = null;
         var _loc4_:NewsItemData = null;
         var _loc1_:Object = storageService.getStorage().data[READ_NEWS];
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Object = {};
         for(_loc3_ in _loc1_)
         {
            for each(_loc4_ in this.newsItems)
            {
               if(_loc3_ == _loc4_.id.toString())
               {
                  _loc2_[_loc3_] = "";
                  break;
               }
            }
         }
         storageService.getStorage().data[READ_NEWS] = _loc2_;
      }
      
      public function resetNewsAddingCallback() : void
      {
         this.newsItemsAddingCallback = null;
      }
      
      public function resetHasUnreadNewsCallback() : void
      {
         this.hasUnreadNewsCallback = null;
      }
      
      public function cleanup() : void
      {
         this.newsItems = null;
      }
      
      public function getUnreadNewsItems() : Vector.<NewsItemData>
      {
         var _loc3_:NewsItemData = null;
         var _loc1_:Object = storageService.getStorage().data[READ_NEWS];
         if(_loc1_ == null)
         {
            return this.newsItems;
         }
         var _loc2_:Vector.<NewsItemData> = new Vector.<NewsItemData>();
         for each(_loc3_ in this.newsItems)
         {
            if(!this.isNewsAlreadyRead(_loc1_,_loc3_))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function isNewsAlreadyRead(param1:Object, param2:NewsItemData) : Boolean
      {
         return param1.hasOwnProperty(param2.id.toString());
      }
   }
}

