package alternativa.tanks.models.tank.pause
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.TankControlLockBits;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.IdleKickTime;
   import alternativa.tanks.models.tank.event.LocalTankLoadListener;
   import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
   import alternativa.tanks.models.tank.support.PauseSupport;
   import projects.tanks.client.battlefield.models.user.pause.ITankPauseModelBase;
   import projects.tanks.client.battlefield.models.user.pause.TankPauseModelBase;
   
   [ModelInfo]
   public class TankPauseModel extends TankPauseModelBase implements ITankPauseModelBase, ITankPause, LocalTankLoadListener, LocalTankUnloadListener
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var idleKickTime:IdleKickTime = new IdleKickTime();
      
      public function TankPauseModel()
      {
         super();
      }
      
      public function localTankLoaded(param1:Boolean) : void
      {
         var _loc2_:Boolean = Boolean(battleService.isLocalTankPaused());
         putData(PauseSupport,new PauseSupport(object,this.idleKickTime,_loc2_));
      }
      
      public function localTankUnloaded(param1:Boolean) : void
      {
         getData(PauseSupport).close();
         clearData(PauseSupport);
      }
      
      public function enablePause() : void
      {
         battleService.setLocalTankPaused(true);
         var _loc1_:ITankModel = ITankModel(object.adapt(ITankModel));
         _loc1_.lockMovementControl(TankControlLockBits.PAUSE);
         _loc1_.getWeaponController().lockWeapon(TankControlLockBits.PAUSE,true);
      }
      
      public function disablePause() : void
      {
         battleService.setLocalTankPaused(false);
         var _loc1_:ITankModel = ITankModel(object.adapt(ITankModel));
         _loc1_.unlockMovementControl(TankControlLockBits.PAUSE);
         _loc1_.getWeaponController().unlockWeapon(TankControlLockBits.PAUSE);
         this.resetIdleKickTime();
         server.disablePause();
      }
      
      public function resetIdleKickTime() : void
      {
         this.idleKickTime.reset(battleService.getIdleKickPeriod());
      }
   }
}

