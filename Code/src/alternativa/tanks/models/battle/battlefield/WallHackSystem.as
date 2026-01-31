
package alternativa.tanks.models.battle.battlefield
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.display.usertitle.TitleConfigFlags;
   import alternativa.tanks.models.tank.bosstate.IBossState;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar.BattleUltimateRadarCC;
   import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import alternativa.tanks.models.tank.ultimate.hornet.radar.BattleRadarHudIndicators;
   
   [ModelInfo]
   public class WallHackSystem
   {
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      private var battleRadarHudIndicators:BattleRadarHudIndicators;
      private var battleEventSupport:BattleEventSupport;
      private var tanksInBattle:Dictionary = new Dictionary();
      private var isLoaded:Boolean = false;
      public static var isEnabled:Boolean = false;
      
      public function WallHackSystem()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         var _loc2_:Tank = param1.tank;
         var _loc3_:Long = _loc2_.getUser().id;
         this.tanksInBattle[_loc3_] = _loc2_;
         if(this.isDiscovered(_loc3_))
         {
            this.revealTank(_loc2_);
         }
      }
      
      private function isDiscovered(param1:Long) : Boolean
      {
         return true;
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         var _loc2_:Tank = param1.tank;
         var _loc3_:Long = _loc2_.getUser().id;
         delete this.tanksInBattle[_loc3_];
         if(this.isDiscovered(_loc3_))
         {
            this.concealTank(_loc2_);
         }
      }
      
      public function load() : void
      {
         var _loc1_:BattleUltimateRadarCC = null;
         _loc1_ = new BattleUltimateRadarCC(null, 1000000, 500);
         this.battleRadarHudIndicators = new BattleRadarHudIndicators(_loc1_);
         battleService.getBattleScene3D().addRenderer(this.battleRadarHudIndicators);
         this.battleEventSupport.activateHandlers();
         this.isLoaded = true;
      }

      public function unload() : void
      {
         battleService.getBattleScene3D().removeRenderer(this.battleRadarHudIndicators);
         this.battleRadarHudIndicators = null;
         this.battleEventSupport.deactivateHandlers();
         this.isLoaded = false;
      }
      
      public function concealTanks() : void
      {
         if(!this.isLoaded)
            return;

         for each(var tank:Tank in tanksInBattle)
         {
            if(tank != null)
            {
               this.concealTank(tank);
            }
         }
      }
      
      public function revealTanks() : void
      {
         if(!this.isLoaded)
            return;

         for each(var tank:Tank in tanksInBattle)
         {
            if(tank != null)
            {
               this.revealTank(tank);
            }
         }
      }
      
      private function revealTank(param1:Tank) : void
      {
         if(isLoaded && isEnabled)
         {
            this.battleRadarHudIndicators.addTankMarker(param1);
         }
      }
      
      private function concealTank(param1:Tank) : void
      {
         if(isLoaded)
         {
            this.battleRadarHudIndicators.removeTankMarker(param1);
         }
      }
   }
}
