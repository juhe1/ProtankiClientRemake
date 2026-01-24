package alternativa.tanks.models.sfx.smoke
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.models.tank.ITankModel;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.HullSmokeModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.IHullSmokeModelBase;
   
   [ModelInfo]
   public class HullSmokeModel extends HullSmokeModelBase implements HullSmoke, IHullSmokeModelBase, BattleEventListener
   {
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var renders:Dictionary = new Dictionary();
      
      private var controlStates:Dictionary = new Dictionary();
      
      public function HullSmokeModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
         this.battleEventSupport.activateHandlers();
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         var renderer:HullSmokeRenderer = null;
         var event:TankAddedToBattleEvent = param1;
         var tankModel:ITankModel = ITankModel(event.tank.getUser().adapt(ITankModel));
         Model.object = tankModel.getTankSet().hull;
         try
         {
            if(!getInitParam().enabled)
            {
               return;
            }
            renderer = new HullSmokeRenderer(event.tank,getInitParam());
            battleService.getBattleScene3D().addRenderer(renderer);
            this.renders[event.tank.getUserId()] = renderer;
         }
         finally
         {
            Model.popObject();
         }
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         var _loc2_:HullSmokeRenderer = HullSmokeRenderer(this.renders[param1.tank.getUserId()]);
         if(_loc2_ == null)
         {
            return;
         }
         battleService.getBattleScene3D().removeRenderer(_loc2_);
         delete this.renders[param1.tank.getUserId()];
      }
      
      public function controlChanged(param1:IGameObject, param2:int) : void
      {
         var _loc3_:HullSmokeRenderer = HullSmokeRenderer(this.renders[param1.id]);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = int(this.controlStates[param1.id]);
         var _loc5_:Boolean = this.isForward(param2);
         var _loc6_:Boolean = this.isForward(_loc4_);
         if(_loc5_ && !_loc6_)
         {
            _loc3_.start();
         }
         else if(!_loc5_ && _loc6_)
         {
            _loc3_.stop();
         }
         else if(_loc4_ != param2)
         {
            _loc3_.changeDirection();
         }
         this.controlStates[param1.id] = param2;
      }
      
      private function isForward(param1:int) : Boolean
      {
         return param1 % 2 != 0;
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
   }
}

