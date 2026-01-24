package alternativa.tanks.models.bonus.region
{
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.models.bonus.goldbonus.IGoldBonus;
   import alternativa.tanks.services.bonusregion.IBonusRegionService;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionsModelBase;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.IBonusRegionsModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class BonusRegionsModel extends BonusRegionsModelBase implements IBonusRegionsModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, BattleEventListener
   {
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var bonusRegionService:IBonusRegionService;
      
      private var battleEventSupport:BattleEventSupport;
      
      public function BonusRegionsModel()
      {
         super();
         this.init();
      }
      
      private static function onTankLoaded(param1:TankLoadedEvent) : void
      {
         if(param1.isLocal)
         {
            bonusRegionService.setTank(param1.tank);
         }
      }
      
      private function init() : void
      {
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,onTankLoaded);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         bonusRegionService.prepare(getInitParam().bonusRegionResources);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         bonusRegionService.addFewRegions(getInitParam().bonusRegions);
         var _loc1_:IGoldBonus = IGoldBonus(object.adapt(IGoldBonus));
         bonusRegionService.addFewRegions(_loc1_.getRegions());
         if(battleInfoService.isSpectatorMode())
         {
            bonusRegionService.showAll();
         }
         else
         {
            this.battleEventSupport.activateHandlers();
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         if(!battleInfoService.isSpectatorMode())
         {
            this.battleEventSupport.deactivateHandlers();
         }
         bonusRegionService.destroy();
      }
   }
}

