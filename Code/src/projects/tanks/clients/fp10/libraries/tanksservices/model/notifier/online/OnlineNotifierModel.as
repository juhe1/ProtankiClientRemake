package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online
{
   import alternativa.types.Long;
   import projects.tanks.client.tanksservices.model.notifier.online.IOnlineNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierData;
   import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
   import projects.tanks.client.tanksservices.model.listener.UserNotifierModelBase;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   [ModelInfo]
   public class OnlineNotifierModel extends OnlineNotifierModelBase implements IOnlineNotifierModelBase, UserRefresh
   {
      
      [Inject] // added
      public static var onlineNotifierService:IOnlineNotifierService;

      [Inject] // added
      public static var modelRegistry:ModelRegistry;
      
      public function OnlineNotifierModel()
      {
         super();
      }
      
      private static function convertToClientData(param1:OnlineNotifierData) : ClientOnlineNotifierData
      {
         return new ClientOnlineNotifierData(param1.userId,param1.online,param1.serverNumber);
      }
      
      public function setOnline(param1:Vector.<OnlineNotifierData>) : void
      {
         var _loc5_:ClientOnlineNotifierData = null;
         var _loc2_:Vector.<ClientOnlineNotifierData> = new Vector.<ClientOnlineNotifierData>(param1.length);
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = convertToClientData(param1[_loc4_]);
            this.setAndUpdateConsumer(_loc5_);
            _loc2_[_loc4_] = _loc5_;
            _loc4_++;
         }
         onlineNotifierService.setOnline(_loc2_);
      }
      
      private function setAndUpdateConsumer(param1:ClientOnlineNotifierData) : void
      {
         var _loc4_:UserInfoConsumer = null;
         var _loc2_:String = param1.userId;
         onlineNotifierService.addUserOnlineData(param1);
         var _loc3_:UserNotifier = UserNotifier(modelRegistry.getModel(UserNotifierModelBase.modelId));
         if(_loc3_.hasDataConsumer(_loc2_))
         {
            _loc4_ = _loc3_.getDataConsumer(_loc2_);
            _loc4_.setOnline(param1.online,param1.serverNumber);
         }
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         var _loc3_:ClientOnlineNotifierData = null;
         if(onlineNotifierService.hasUserOnlineData(param1))
         {
            _loc3_ = onlineNotifierService.getUserOnlineData(param1);
            param2.setOnline(_loc3_.online,_loc3_.serverNumber);
         }
      }
      
      public function remove(param1:String) : void
      {
         onlineNotifierService.removeUserOnlineData(param1);
      }
   }
}

