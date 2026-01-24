package alternativa.tanks.models.bonus.battlefield
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.bonuses.Bonus;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.battlefield.BattlefieldEvents;
   import alternativa.tanks.models.effects.common.IBonusCommonModel;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;
   import projects.tanks.client.battlefield.models.bonus.battle.battlefield.BattlefieldBonusesModelBase;
   import projects.tanks.client.battlefield.models.bonus.battle.battlefield.IBattlefieldBonusesModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import scpacker.utils.LongUtils;
   import alternativa.types.Long;
   
   [ModelInfo]
   public class BattlefieldBonusesModel extends BattlefieldBonusesModelBase implements IBattlefieldBonusesModelBase, BattleEventListener, BattlefieldEvents
   {
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var userInfoService:BattleUserInfoService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      private var bonuses:Dictionary = new Dictionary();
      
      public function BattlefieldBonusesModel()
      {
         super();
         battleEventDispatcher.addBattleEventListener(BattleFinishEvent,this);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.removeAllBonuses();
      }
      
      private function removeAllBonuses() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.bonuses)
         {
            this.removeBonus(_loc1_);
         }
      }
      
      private function spawnBonus(param1:IGameObject, param2:Long, param3:Vector3d, param4:int, param5:Boolean) : void
      {
         var _loc6_:IBonusCommonModel = null;
         var _loc7_:Bonus = null;
         if(param1 != null)
         {
            _loc6_ = IBonusCommonModel(param1.adapt(IBonusCommonModel));
            _loc7_ = _loc6_.getBonus(param2);
            _loc7_.spawn(new Vector3(param3.x,param3.y,param3.z),param4,getInitParam().bonusFallSpeed,param5,getFunctionWrapper(this.onBonusTankCollision));
            this.bonuses[_loc7_.bonusId] = _loc7_;
         }
      }
      
      private function onBonusTankCollision(param1:Bonus) : void
      {
         battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.attemptToTakeBonus(param1.bonusId);
      }
      
      [Obfuscation(rename="false")]
      public function spawnBonuses(param1:Vector.<BonusSpawnData>) : void
      {
         var _loc2_:BonusSpawnData = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               this.spawnBonus(_loc2_.battleBonusObject,_loc2_.bonusId,_loc2_.spawnPosition,0,false);
            }
         }
      }

      public function initBonuses(param1:Vector.<BonusSpawnData>) : void
      {
         var _loc2_:BonusSpawnData = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               this.spawnBonus(_loc2_.battleBonusObject,_loc2_.bonusId,_loc2_.spawnPosition,_loc2_.lifeTime,false);
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function removeBonuses(param1:Vector.<Long>) : void
      {
         var _loc2_:Long = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               this.removeBonus(_loc2_);
            }
         }
      }
      
      private function removeBonus(param1:Long) : void
      {
         var _loc2_:Bonus = this.bonuses[param1];
         if(_loc2_ != null)
         {
            delete this.bonuses[param1];
            _loc2_.remove();
         }
      }
      
      [Obfuscation(rename="false")]
      public function bonusTaken(param1:Long) : void
      {
         var _loc2_:Bonus = this.bonuses[param1];
         if(_loc2_ != null)
         {
            delete this.bonuses[param1];
            _loc2_.pickup();
         }
      }
      
      [Obfuscation(rename="false")]
      public function attemptToTakeBonusFailedTankNotActive(param1:Long) : void
      {
         var _loc2_:Bonus = this.bonuses[param1];
         if(_loc2_ != null)
         {
            _loc2_.enableTrigger();
         }
      }
      
      public function onBattleLoaded() : void
      {
         this.createExistingBonuses();
      }
      
      private function createExistingBonuses() : void
      {
         var _loc1_:BonusSpawnData = null;
         for each(_loc1_ in getInitParam().bonuses)
         {
            this.spawnBonus(_loc1_.battleBonusObject,_loc1_.bonusId,_loc1_.spawnPosition,_loc1_.lifeTime,false);
         }
         getInitParam().bonuses = null;
      }
      
      [Obfuscation(rename="false")]
      public function spawnBonusesOnGround(param1:Vector.<BonusSpawnData>) : void
      {
         var _loc2_:BonusSpawnData = null;
         for each(_loc2_ in param1)
         {
            this.spawnBonus(_loc2_.battleBonusObject,_loc2_.bonusId,_loc2_.spawnPosition,0,true);
         }
      }
   }
}

