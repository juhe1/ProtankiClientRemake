package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle
{
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierModelBase;
   import projects.tanks.client.tanksservices.model.notifier.battle.IBattleNotifierModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.tanksservices.model.listener.UserNotifierModelBase;
   
   [ModelInfo]
   public class BattleNotifierModel extends BattleNotifierModelBase implements IBattleNotifierModelBase, UserRefresh, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var battleNotifierService:IBattleNotifierService;

      [Inject] // added
      public static var modelRegistry:ModelRegistry;
      
      private var battleLinkData:Dictionary;
      
      public function BattleNotifierModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         this.battleLinkData = new Dictionary();
      }
      
      public function objectUnloaded() : void
      {
         this.battleLinkData = null;
      }
      
      public function setBattle(param1:Vector.<BattleNotifierData>) : void
      {
         var _loc5_:BattleNotifierData = null;
         var _loc2_:Vector.<BattleLinkData> = new Vector.<BattleLinkData>(param1.length);
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc2_[_loc4_] = this.setAndUpdateConsumer(_loc5_);
            _loc4_++;
         }
         battleNotifierService.setBattle(_loc2_);
      }
      
      private function setAndUpdateConsumer(param1:BattleNotifierData) : BattleLinkData
      {
         var _loc2_:String = param1.userId;
         var _loc3_:BattleLinkData = new BattleLinkData(_loc2_,param1);
         this.battleLinkData[_loc2_] = _loc3_;
         this.setBattleLinkForConsumer(_loc2_,_loc3_);
         return _loc3_;
      }
      
      private function setBattleLinkForConsumer(param1:String, param2:BattleLinkData) : void
      {
         var _loc4_:UserInfoConsumer = null;
         var _loc3_:UserNotifier = UserNotifier(modelRegistry.getModel(UserNotifierModelBase.modelId));
         if(_loc3_.hasDataConsumer(param1))
         {
            _loc4_ = _loc3_.getDataConsumer(param1);
            _loc4_.setBattleUrl(param2);
         }
      }
      
      public function refresh(param1:String, param2:UserInfoConsumer) : void
      {
         if(param1 in this.battleLinkData)
         {
            param2.setBattleUrl(this.battleLinkData[param1]);
         }
      }
      
      public function remove(param1:String) : void
      {
         delete this.battleLinkData[param1];
         this.setBattleLinkForConsumer(param1,null);
      }
      
      public function leaveBattle(param1:String) : void
      {
         battleNotifierService.leaveBattle(param1);
         this.remove(param1);
      }
      
      public function leaveGroup(param1:String) : void
      {
         this.remove(param1);
      }
   }
}

