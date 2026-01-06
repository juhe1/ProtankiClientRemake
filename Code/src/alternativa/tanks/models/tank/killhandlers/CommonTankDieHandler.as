package alternativa.tanks.models.tank.killhandlers
{
   import alternativa.tanks.battle.BattleRunner;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.death.TankDeadEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.TankControlLockBits;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.configuration.TankConfiguration;
   import alternativa.tanks.models.tank.explosion.ITankExplosionModel;
   import alternativa.tanks.models.tank.hullcommon.HullCommon;
   import alternativa.tanks.models.tank.spawn.ReadyToSpawnTask;
   import alternativa.tanks.sfx.LightAnimation;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class CommonTankDieHandler
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      public function CommonTankDieHandler()
      {
         super();
      }
      
      protected static function getTankModel(param1:IGameObject) : ITankModel
      {
         return ITankModel(param1.adapt(ITankModel));
      }
      
      private static function createDeathEffects(param1:Tank) : void
      {
         param1.getBody().clearAccumulators();
         param1.getBody().state.velocity.z = param1.getBody().state.velocity.z + 500;
         param1.getBody().state.angularVelocity.reset(2,2,2);
         param1.getSkin().setDeadState();
         var _loc2_:TankConfiguration = TankConfiguration(param1.user.adapt(TankConfiguration));
         var _loc3_:IGameObject = _loc2_.getHullObject();
         var _loc4_:ITankExplosionModel = ITankExplosionModel(_loc3_.adapt(ITankExplosionModel));
         _loc4_.createExplosionEffects(_loc3_,param1,getExplosionAnimation(_loc3_));
      }
      
      private static function getExplosionAnimation(param1:IGameObject) : LightAnimation
      {
         var _loc2_:LightingSFXEntity = HullCommon(param1.adapt(HullCommon)).getCC().lightingSFXEntity;
         return new LightingSfx(_loc2_).createAnimation("explosion");
      }
      
      protected function killTank(param1:IGameObject, param2:int) : void
      {
         var _loc3_:ITankModel = getTankModel(param1);
         _loc3_.lockMovementControl(TankControlLockBits.DEAD);
         _loc3_.getWeaponController().lockWeapon(TankControlLockBits.DEAD,false);
         _loc3_.getWeaponController().deactivateWeapon();
         var _loc4_:Tank = _loc3_.getTank();
         _loc4_.kill();
         var _loc5_:BattleRunner = battleService.getBattleRunner();
         _loc5_.addLogicUnit(new ReadyToSpawnTask(getTimer() + param2,_loc4_));
         createDeathEffects(_loc4_);
         battleEventDispatcher.dispatchEvent(new TankDeadEvent(param1));
      }
   }
}

