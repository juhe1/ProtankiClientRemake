package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.uid
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import projects.tanks.client.tanksservices.model.notifier.uid.IUidNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierData;
   import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   
   [ModelInfo]
   public class UidNotifierModel extends UidNotifierModelBase implements IUidNotifierModelBase, UserRefresh
   {
      
      private var data:Dictionary = new Dictionary();
      
      public function UidNotifierModel()
      {
         super();
      }
      
      public function setUid(param1:Vector.<UidNotifierData>) : void
      {
         var _loc2_:UidNotifierData = null;
         for each(_loc2_ in param1)
         {
            this.setAndUpdateConsumer(_loc2_);
         }
      }
      
      private function setAndUpdateConsumer(param1:UidNotifierData) : void
      {
         var _loc4_:UserInfoConsumer = null;
         var _loc2_:String = param1.userId;
         this.data[_loc2_] = param1.uid;
         var _loc3_:UserNotifier = UserNotifier(object.adapt(UserNotifier));
         if(_loc3_.hasDataConsumer(_loc2_))
         {
            _loc4_ = _loc3_.getDataConsumer(_loc2_);
            _loc4_.setUid(param1.uid);
         }
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         if(param1 in this.data)
         {
            param2.setUid(this.data[param1]);
         }
      }
      
      public function remove(param1:String) : void
      {
         delete this.data[param1];
      }
   }
}

