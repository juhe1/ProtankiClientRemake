package alternativa.tanks.models.battle.tdm
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.TeamDMTargetEvaluator;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.weapon.ricochet.TeamDMRicochetTargetEvaluator;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battleservice.model.battle.tdm.BattleTDMModelBase;
   import projects.tanks.client.battleservice.model.battle.tdm.IBattleTDMModelBase;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   [ModelInfo]
   public class BattleTDMModel extends BattleTDMModelBase implements IBattleTDMModelBase, ObjectLoadPostListener, ObjectUnloadListener, BattleEventListener, BattleModel
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var targetEvaluators:Vector.<TeamDMTargetEvaluator>;
      
      public function BattleTDMModel()
      {
         super();
      }
      
      public function getBattleType() : BattleType
      {
         return BattleType.TDM;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         this.targetEvaluators = new Vector.<TeamDMTargetEvaluator>();
         var _loc1_:TDMCommonTargetEvaluator = new TDMCommonTargetEvaluator();
         battleService.setCommonTargetEvaluator(_loc1_);
         this.targetEvaluators.push(_loc1_);
         var _loc2_:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
         battleService.setHealingGunTargetEvaluator(_loc2_);
         this.targetEvaluators.push(_loc2_);
         var _loc3_:TDMRailgunTargetEvaluator = new TDMRailgunTargetEvaluator();
         battleService.setRailgunTargetEvaluator(_loc3_);
         this.targetEvaluators.push(_loc3_);
         var _loc4_:TeamDMRicochetTargetEvaluator = new TeamDMRicochetTargetEvaluator();
         battleService.setRicochetTargetEvaluator(_loc4_);
         this.targetEvaluators.push(_loc4_);
         battleEventDispatcher.addBattleEventListener(LocalTankActivationEvent,this);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         this.targetEvaluators = null;
         battleService.setCommonTargetEvaluator(null);
         battleService.setHealingGunTargetEvaluator(null);
         battleService.setRailgunTargetEvaluator(null);
         battleService.setRicochetTargetEvaluator(null);
         battleEventDispatcher.removeBattleEventListener(LocalTankActivationEvent,this);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc3_:TeamDMTargetEvaluator = null;
         var _loc2_:BattleTeam = LocalTankActivationEvent(param1).tank.teamType;
         for each(_loc3_ in this.targetEvaluators)
         {
            _loc3_.setLocalTeamType(_loc2_);
         }
      }
   }
}

