package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.rank
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import projects.tanks.client.tanksservices.model.notifier.rank.IRankNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierData;
   import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.tanksservices.model.listener.UserNotifierModelBase;
   
   [ModelInfo]
   public class RankNotifierModel extends RankNotifierModelBase implements IRankNotifierModelBase, UserRefresh
   {

      [Inject] // added
      public static var modelRegistry:ModelRegistry;
      
      private var data:Dictionary = new Dictionary();
      
      public function RankNotifierModel()
      {
         super();
      }
      
      public function setRank(param1:Vector.<RankNotifierData>) : void
      {
         var _loc2_:RankNotifierData = null;
         for each(_loc2_ in param1)
         {
            this.setAndUpdateConsumer(_loc2_);
         }
      }
      
      public function setAndUpdateConsumer(param1:RankNotifierData) : void
      {
         var _loc4_:UserInfoConsumer = null;
         var _loc2_:String = param1.userId;
         this.data[_loc2_] = param1.rank;
         var _loc3_:UserNotifier = UserNotifier(modelRegistry.getModel(UserNotifierModelBase.modelId));
         if(_loc3_.hasDataConsumer(_loc2_))
         {
            _loc4_ = _loc3_.getDataConsumer(_loc2_);
            _loc4_.setRank(param1.rank);
         }
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         if(param1 in this.data)
         {
            param2.setRank(this.data[param1]);
         }
      }
      
      public function remove(param1:String) : void
      {
         delete this.data[param1];
      }
   }
}

