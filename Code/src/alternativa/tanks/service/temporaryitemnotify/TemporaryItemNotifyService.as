package alternativa.tanks.service.temporaryitemnotify
{
   import platform.client.fp10.core.type.IGameObject;
   
   public class TemporaryItemNotifyService implements ITemporaryItemNotifyService
   {
      
      private var listeners:Vector.<ITemporaryItemNotifyServiceListener>;
      
      public function TemporaryItemNotifyService()
      {
         super();
         this.listeners = new Vector.<ITemporaryItemNotifyServiceListener>();
      }
      
      public function addListener(param1:ITemporaryItemNotifyServiceListener) : void
      {
         if(this.listeners.indexOf(param1) == -1)
         {
            this.listeners.push(param1);
         }
      }
      
      public function removeListener(param1:ITemporaryItemNotifyServiceListener) : void
      {
         var _loc2_:Number = Number(this.listeners.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.listeners.splice(_loc2_,1);
         }
      }
      
      public function notifyTimeIsUp(param1:IGameObject) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.listeners.length)
         {
            this.listeners[_loc2_].temporaryItemTimeIsUp(param1);
            _loc2_++;
         }
      }
   }
}

