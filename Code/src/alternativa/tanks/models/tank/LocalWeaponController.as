package alternativa.tanks.models.tank
{
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.TankControlLockBits;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.utils.BitMask;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class LocalWeaponController extends BattleRunnerProvider implements IWeaponController
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var weapon:Weapon;
      
      private var lockMask:BitMask = new BitMask();
      
      public function LocalWeaponController(param1:Weapon)
      {
         super();
         this.weapon = param1;
         this.lockMask.setBits(TankControlLockBits.DEAD);
      }
      
      public function activateWeapon() : void
      {
         this.weapon.activate();
      }
      
      public function deactivateWeapon() : void
      {
         this.weapon.deactivate();
      }
      
      public function lockWeapon(param1:int, param2:Boolean) : void
      {
         var _loc3_:Boolean = this.lockMask.isEmpty();
         this.lockMask.setBits(param1);
         if(_loc3_)
         {
            this.weapon.disable(param2);
         }
      }
      
      public function unlockWeapon(param1:int) : void
      {
         var _loc2_:Boolean = this.lockMask.isEmpty();
         this.lockMask.clearBits(param1);
         if(!_loc2_ && this.lockMask.isEmpty())
         {
            this.weapon.enable();
         }
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return this.weapon.getResistanceProperty();
      }
   }
}

