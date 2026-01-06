package alternativa.tanks.models.battle.battlefield
{
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   
   public class BonusPickupEffects
   {
      
      private static var conShowEffects:ConsoleVarInt;
      
      private var battleService:BattleService;
      
      private var tanks:Dictionary = new Dictionary();
      
      private var effects:Dictionary = new Dictionary();
      
      public function BonusPickupEffects(param1:BattleService)
      {
         super();
         this.battleService = param1;
         if(conShowEffects == null)
         {
            conShowEffects = new ConsoleVarInt("bonus_flash",0,0,1);
         }
      }
      
      public function addTank(param1:Tank) : void
      {
         this.tanks[param1.getUser()] = param1;
      }
      
      public function removeTank(param1:Tank) : void
      {
         this.removeEffect(param1);
         delete this.tanks[param1.getUser()];
      }
      
      public function showBonusPickup(param1:Long) : void
      {
         var _loc2_:Tank = null;
         var _loc3_:BonusPickupEffect = null;
         if(conShowEffects.value == 1)
         {
            _loc2_ = this.tanks[param1];
            if(_loc2_ != null)
            {
               _loc3_ = this.effects[param1];
               if(_loc3_ == null)
               {
                  _loc3_ = new BonusPickupEffect(_loc2_);
                  this.effects[param1] = _loc3_;
               }
               if(!_loc3_.onScene)
               {
                  this.battleService.addGraphicEffect(_loc3_);
               }
               _loc3_.init();
            }
         }
      }
      
      private function removeEffect(param1:Tank) : void
      {
         var _loc2_:BonusPickupEffect = this.effects[param1.getUser()];
         if(_loc2_ != null)
         {
            _loc2_.kill();
            delete this.effects[param1.getUser()];
         }
      }
   }
}

