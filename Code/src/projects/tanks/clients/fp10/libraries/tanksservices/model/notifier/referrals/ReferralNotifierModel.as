package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.referrals
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import projects.tanks.client.tanksservices.model.notifier.referrals.IReferralNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.referrals.ReferralNotifierData;
   import projects.tanks.client.tanksservices.model.notifier.referrals.ReferralNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   
   [ModelInfo]
   public class ReferralNotifierModel extends ReferralNotifierModelBase implements IReferralNotifierModelBase, UserRefresh
   {
      
      private var data:Dictionary = new Dictionary();
      
      public function ReferralNotifierModel()
      {
         super();
      }
      
      public function setIsReferral(param1:Vector.<ReferralNotifierData>) : void
      {
         var _loc2_:ReferralNotifierData = null;
         for each(_loc2_ in param1)
         {
            this.setAndUpdateConsumer(_loc2_);
         }
      }
      
      private function setAndUpdateConsumer(param1:ReferralNotifierData) : void
      {
         var _loc4_:UserInfoConsumer = null;
         var _loc2_:String = param1.userId;
         this.data[_loc2_] = param1.referral;
         var _loc3_:UserNotifier = UserNotifier(object.adapt(UserNotifier));
         if(_loc3_.hasDataConsumer(_loc2_))
         {
            _loc4_ = _loc3_.getDataConsumer(_loc2_);
            _loc4_.setIsReferral(param1.referral);
         }
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         if(param1 in this.data)
         {
            param2.setIsReferral(this.data[param1]);
         }
      }
      
      public function remove(param1:String) : void
      {
         delete this.data[param1];
      }
   }
}

