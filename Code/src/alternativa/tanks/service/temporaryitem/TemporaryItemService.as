package alternativa.tanks.service.temporaryitem
{
   import alternativa.tanks.service.temporaryitemnotify.ITemporaryItemNotifyService;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   
   public class TemporaryItemService implements ITemporaryItemService
   {
      
      [Inject] // added
      public static var temporaryItemNotifyService:ITemporaryItemNotifyService;
      
      private var items:Dictionary;
      
      public function TemporaryItemService()
      {
         super();
         this.items = new Dictionary();
      }
      
      public function getCurrentTimeRemainingMSec(param1:IGameObject) : Number
      {
         var _loc2_:ItemTimer = this.items[param1];
         if(_loc2_ != null)
         {
            return _loc2_.currentTimeRemainingMSec;
         }
         return 0;
      }
      
      public function startItem(param1:IGameObject, param2:int) : void
      {
         this.stopItem(param1);
         var _loc3_:ItemTimer = new ItemTimer(param1,param2);
         this.items[param1] = _loc3_;
         _loc3_.addEventListener(Event.COMPLETE,this.onItemTimerCompleted);
      }
      
      public function stopItem(param1:IGameObject) : void
      {
         var _loc2_:ItemTimer = this.items[param1];
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener(Event.COMPLETE,this.onItemTimerCompleted);
            _loc2_.destroy();
            delete this.items[param1];
         }
      }
      
      private function onItemTimerCompleted(param1:Event) : void
      {
         var _loc2_:IGameObject = ItemTimer(param1.target).item;
         temporaryItemNotifyService.notifyTimeIsUp(_loc2_);
         delete this.items[_loc2_];
      }
   }
}

