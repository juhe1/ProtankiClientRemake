package projects.tanks.clients.fp10.libraries.tanksservices.service.user
{
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.TimeOutTruncateConsumers;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifierModel;
   import projects.tanks.client.tanksservices.model.listener.UserNotifierModelBase;
   
   public class UserInfoService extends EventDispatcher implements IUserInfoService
   {
      
      [Inject]
      public static var premiumService:PremiumService;

      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      private var consumers:Dictionary;
      
      private var unsubscribedConsumers:Dictionary;
      
      private var serviceObject:IGameObject;
      
      private var truncateConsumers:TimeOutTruncateConsumers;
      
      private var stateOffer:Boolean;
      
      public function UserInfoService()
      {
         super();
      }
      
      public function init(param1:IGameObject) : void
      {
         this.serviceObject = param1;
         this.truncateConsumers = new TimeOutTruncateConsumers();
         this.truncateConsumers.consumers = this.consumers;
         this.truncateConsumers.truncateFunction = this.unSubscribe;
         this.consumers = new Dictionary();
         this.unsubscribedConsumers = new Dictionary();
      }
      
      public function getOrCreateUpdater(param1:String) : IUserInfoLabelUpdater
      {
         var _loc2_:UserInfoLabelUpdater = null;
         if(this.hasConsumer(param1))
         {
            _loc2_ = this.consumers[param1];
         }
         else
         {
            _loc2_ = new UserInfoLabelUpdater();
            if(param1 in this.unsubscribedConsumers)
            {
               this.subscribe(param1,_loc2_);
            }
            else
            {
               this.refresh(param1,_loc2_);
            }
         }
         _loc2_.updateLastAccessTime();
         return _loc2_;
      }
      
      public function forciblySubscribe(param1:String) : void
      {
         var _loc2_:UserInfoLabelUpdater = null;
         if(!this.hasConsumer(param1))
         {
            _loc2_ = new UserInfoLabelUpdater();
            this.subscribe(param1,_loc2_);
            _loc2_.updateLastAccessTime();
         }
      }
      
      private function subscribe(param1:String, param2:UserInfoConsumer) : void
      {
         delete this.unsubscribedConsumers[param1];
         this.consumers[param1] = param2;
         UserNotifier(modelRegistry.getModel(UserNotifierModelBase.modelId)).subcribe(param1,param2);
      }
      
      private function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         this.consumers[param1] = param2;
         UserNotifier(modelRegistry.getModel(UserNotifierModelBase.modelId)).refresh(param1,param2);
      }
      
      private function unSubscribe(param1:Vector.<String>) : void
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            this.unsubscribedConsumers[_loc2_] = true;
            delete this.consumers[_loc2_];
         }
         UserNotifier(modelRegistry.getModel(UserNotifierModelBase.modelId)).unsubcribe(param1);
      }
      
      public function hasConsumer(param1:String) : Boolean
      {
         return param1 in this.consumers;
      }
      
      public function getConsumer(param1:String) : UserInfoConsumer
      {
         return this.consumers[param1];
      }
      
      public function unload() : void
      {
         this.truncateConsumers.stop();
         this.truncateConsumers = null;
         this.consumers = null;
         this.unsubscribedConsumers = null;
         this.serviceObject = null;
         this.stateOffer = false;
      }
      
      public function getCurrentUserId() : String
      {
         return UserNotifier(modelRegistry.getModel(UserNotifierModelBase.modelId)).getCurrentUserId();
      }
      
      public function isOffer() : Boolean
      {
         return this.stateOffer;
      }
      
      public function setOffer(param1:Boolean) : void
      {
         this.stateOffer = param1;
      }
      
      public function hasPremium(param1:String) : Boolean
      {
         return this.getCurrentUserId() == param1 && Boolean(premiumService.hasPremium());
      }
   }
}

