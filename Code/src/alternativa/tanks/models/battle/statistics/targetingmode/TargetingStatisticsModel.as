package alternativa.tanks.models.battle.statistics.targetingmode
{
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TargetingModeChangedEvent;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingMode;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.statistics.targetingmode.ITargetingStatisticsModelBase;
   import projects.tanks.client.battlefield.models.statistics.targetingmode.TargetingStatisticsModelBase;
   
   [ModelInfo]
   public class TargetingStatisticsModel extends TargetingStatisticsModelBase implements ITargetingStatisticsModelBase, ObjectLoadListener, ObjectUnloadListener, BattleEventListener
   {
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var gameObject:IGameObject;
      
      private var mode:int;
      
      private var spawned:Boolean;
      
      public function TargetingStatisticsModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         battleEventDispatcher.addBattleEventListener(TargetingModeChangedEvent,this);
         battleEventDispatcher.addBattleEventListener(TankAddedToBattleEvent,this);
         this.gameObject = object;
         this.mode = TargetingMode.REMOTE;
         this.spawned = false;
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         battleEventDispatcher.removeBattleEventListener(TargetingModeChangedEvent,this);
         battleEventDispatcher.removeBattleEventListener(TankAddedToBattleEvent,this);
         this.gameObject = null;
      }
      
      private function sendStatistics(param1:int) : void
      {
         switch(param1)
         {
            case TargetingMode.KEYBOARD:
               server.switchTargetingMode(projects.tanks.client.battlefield.models.statistics.targetingmode.TargetingMode.KEYBOARD);
               break;
            case TargetingMode.MOUSE_LOOK:
               server.switchTargetingMode(projects.tanks.client.battlefield.models.statistics.targetingmode.TargetingMode.MOUSE_LOOK);
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:TargetingModeChangedEvent = param1 as TargetingModeChangedEvent;
         if(_loc2_ != null)
         {
            if(_loc2_.targetingMode != this.mode)
            {
               if(this.spawned)
               {
                  this.send(_loc2_.targetingMode);
               }
               this.mode = _loc2_.targetingMode;
            }
         }
         var _loc3_:TankAddedToBattleEvent = param1 as TankAddedToBattleEvent;
         if(_loc3_ != null && _loc3_.isLocal)
         {
            this.spawned = true;
            this.send(this.mode);
         }
      }
      
      private function send(param1:int) : void
      {
         Model.object = this.gameObject;
         this.sendStatistics(param1);
         Model.popObject();
      }
   }
}

