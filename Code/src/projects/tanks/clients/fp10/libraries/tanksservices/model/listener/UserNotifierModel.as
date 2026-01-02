package projects.tanks.clients.fp10.libraries.tanksservices.model.listener
{
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.tanksservices.model.listener.IUserNotifierModelBase;
   import projects.tanks.client.tanksservices.model.listener.UserNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.online.OnlineNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierModelBase;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   [ModelInfo]
   public class UserNotifierModel extends UserNotifierModelBase implements IUserNotifierModelBase, UserNotifier, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var userInfoService:IUserInfoService;

      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;

      [Inject] // added
      public static var modelRegistry:ModelRegistry;
      
      public function UserNotifierModel()
      {
         super();
      }
      
      public function subcribe(param1:String, param2:UserInfoConsumer) : void
      {
         this.refresh(param1,param2);
         server.subscribe(param1);
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         //UserRefresh(object.event(UserRefresh)).refresh(param1,param2);
         UserRefresh(modelRegistry.getModel(BattleNotifierModelBase.modelId)).refresh(param1,param2);
         UserRefresh(modelRegistry.getModel(OnlineNotifierModelBase.modelId)).refresh(param1,param2);
         UserRefresh(modelRegistry.getModel(RankNotifierModelBase.modelId)).refresh(param1,param2);
         UserRefresh(modelRegistry.getModel(UidNotifierModelBase.modelId)).refresh(param1,param2);

      }
      
      public function unsubcribe(param1:Vector.<String>) : void
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            //UserRefresh(object.event(UserRefresh)).remove(_loc2_);
            UserRefresh(modelRegistry.getModel(BattleNotifierModelBase.modelId)).remove(_loc2_);
            UserRefresh(modelRegistry.getModel(OnlineNotifierModelBase.modelId)).remove(_loc2_);
            UserRefresh(modelRegistry.getModel(RankNotifierModelBase.modelId)).remove(_loc2_);
            UserRefresh(modelRegistry.getModel(UidNotifierModelBase.modelId)).remove(_loc2_);
         }
         server.unsubscribe(param1);
      }
      
      public function hasDataConsumer(param1:String) : Boolean
      {
         return userInfoService.hasConsumer(param1);
      }
      
      public function getDataConsumer(param1:String) : UserInfoConsumer
      {
         return userInfoService.getConsumer(param1);
      }
      
      public function objectLoaded() : void
      {
         userInfoService.init(object);
      }
      
      public function objectUnloaded() : void
      {
         userInfoService.unload();
      }
      
      public function getCurrentUserId() : String
      {
         return userPropertiesService.userName;
      }
   }
}

