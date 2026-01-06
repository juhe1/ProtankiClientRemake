package alternativa.tanks.models.tank.killhandlers
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.LocalTankKilledEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.physics.CollisionGroup;
   import platform.client.fp10.core.type.IGameObject;
   
   public class LocalTankDieHandler extends CommonTankDieHandler implements TankDieHandler
   {
      
      public function LocalTankDieHandler()
      {
         super();
      }
      
      private static function disableBonusesPickup(param1:ITankModel) : void
      {
         var _loc2_:Tank = param1.getTank();
         _loc2_.setBodyCollisionGroup(_loc2_.getBodyCollisionGroup() & ~CollisionGroup.BONUS_WITH_TANK);
      }
      
      public function handleTankDie(param1:IGameObject, param2:int) : void
      {
         var _loc3_:ITankModel = getTankModel(param1);
         _loc3_.sendStateCorrection(true);
         _loc3_.sendDeathConfirmationCommand();
         killTank(param1,param2);
         disableBonusesPickup(_loc3_);
         var _loc4_:BattleService = battleService;
         _loc4_.lockFollowCamera();
         _loc4_.recalculateFollowCamera();
         var _loc5_:BattleEventDispatcher = battleEventDispatcher;
         _loc5_.dispatchEvent(LocalTankKilledEvent.EVENT);
      }
   }
}

