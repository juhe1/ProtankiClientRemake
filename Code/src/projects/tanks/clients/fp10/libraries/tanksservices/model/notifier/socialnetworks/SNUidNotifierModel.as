package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.socialnetworks
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import projects.tanks.client.tanksservices.model.notifier.socialnetworks.ISNUidNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.socialnetworks.SNUidNotifierData;
   import projects.tanks.client.tanksservices.model.notifier.socialnetworks.SNUidNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   
   [ModelInfo]
   public class SNUidNotifierModel extends SNUidNotifierModelBase implements ISNUidNotifierModelBase, UserRefresh
   {
      
      private var data:Dictionary = new Dictionary();
      
      public function SNUidNotifierModel()
      {
         super();
      }
      
      public function setSNUid(param1:Vector.<SNUidNotifierData>) : void
      {
         var _loc2_:SNUidNotifierData = null;
         for each(_loc2_ in param1)
         {
            this.setAndUpdateConsumer(_loc2_);
         }
      }
      
      private function setAndUpdateConsumer(param1:SNUidNotifierData) : void
      {
         var _loc4_:UserInfoConsumer = null;
         var _loc2_:String = param1.userId;
         this.data[_loc2_] = param1.snUid;
         var _loc3_:UserNotifier = UserNotifier(object.adapt(UserNotifier));
         if(_loc3_.hasDataConsumer(_loc2_))
         {
            _loc4_ = _loc3_.getDataConsumer(_loc2_);
            _loc4_.setSNUid(param1.snUid);
         }
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         if(param1 in this.data)
         {
            param2.setSNUid(this.data[param1]);
         }
      }
      
      public function remove(param1:String) : void
      {
         delete this.data[param1];
      }
   }
}

