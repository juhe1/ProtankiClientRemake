package alternativa.tanks.service.notificationcategories
{
   import flash.events.EventDispatcher;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import projects.tanks.client.panel.model.garage.GarageItemInfo;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   
   public class NotificationGarageCategoriesService extends EventDispatcher implements INotificationGarageCategoriesService
   {
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      private static const NEW_ITEM_NOTIFICATION_SHARED_KEY:String = "NEW_ITEM_NOTIFICATION_IN_CATEGORY";
      
      public function NotificationGarageCategoriesService()
      {
         super();
      }
      
      public function notifyAboutAvailableItems(param1:Vector.<GarageItemInfo>) : void
      {
         var _loc4_:ItemViewCategoryEnum = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_].itemViewCategory;
            if(!this.isNeedShowNewItemNotification(_loc4_))
            {
               this.markAsNeedShowNewItemNotification(_loc4_);
            }
            _loc3_++;
         }
         dispatchEvent(new NotificationGarageCategoriesEvent(NotificationGarageCategoriesEvent.NOTIFICATION_CHANGE));
      }
      
      private function markAsNeedShowNewItemNotification(param1:ItemViewCategoryEnum) : void
      {
         storageService.getStorage().data[this.getNewItemNotificationSharedKey(param1)] = true;
      }
      
      public function categoryShowed(param1:ItemViewCategoryEnum) : void
      {
         storageService.getStorage().data[this.getNewItemNotificationSharedKey(param1)] = false;
      }
      
      public function isNeedShowNewItemNotification(param1:ItemViewCategoryEnum) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = this.getNewItemNotificationSharedKey(param1);
         if(storageService.getStorage().data.hasOwnProperty(_loc3_))
         {
            _loc2_ = Boolean(storageService.getStorage().data[_loc3_]);
         }
         return _loc2_;
      }
      
      private function getNewItemNotificationSharedKey(param1:ItemViewCategoryEnum) : String
      {
         return NEW_ITEM_NOTIFICATION_SHARED_KEY + param1.value;
      }
      
      public function notifyAboutNewItemsInCategory(param1:ItemViewCategoryEnum) : void
      {
         this.markAsNeedShowNewItemNotification(param1);
      }
   }
}

