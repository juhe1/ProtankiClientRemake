package alternativa.tanks.models.tank.support
{
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.models.tank.ITankModel;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   
   public class StateCorrectionSupport implements AutoClosable, BattleEventListener
   {
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var localUser:IGameObject;
      
      private var battleEventSupport:BattleEventSupport;
      
      public function StateCorrectionSupport(param1:IGameObject)
      {
         super();
         this.localUser = param1;
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
         this.battleEventSupport.addEventHandler(StateCorrectionEvent,this.onStateCorrectionRequest);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.activateHandlers();
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         var _loc2_:ITankModel = null;
         if(param1.tank.getUser() == this.localUser)
         {
            _loc2_ = ITankModel(this.localUser.adapt(ITankModel));
            _loc2_.enableStateCorrection();
         }
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         var _loc2_:ITankModel = null;
         if(param1.tank.getUser() == this.localUser)
         {
            _loc2_ = ITankModel(this.localUser.adapt(ITankModel));
            _loc2_.disableStateCorrection();
         }
      }
      
      private function onStateCorrectionRequest(param1:StateCorrectionEvent) : void
      {
         var _loc2_:ITankModel = ITankModel(this.localUser.adapt(ITankModel));
         _loc2_.sendStateCorrection(param1.mandatory);
      }
      
      private function onBattleFinish(param1:Object) : void
      {
         var _loc2_:ITankModel = ITankModel(this.localUser.adapt(ITankModel));
         _loc2_.disableStateCorrection();
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.battleEventSupport.deactivateHandlers();
         this.battleEventSupport = null;
         this.localUser = null;
      }
   }
}

