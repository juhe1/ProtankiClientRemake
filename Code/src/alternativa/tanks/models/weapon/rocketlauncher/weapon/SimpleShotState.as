package alternativa.tanks.models.weapon.rocketlauncher.weapon
{
   import flash.utils.getTimer;
   
   public class SimpleShotState implements RocketLauncherWeaponState
   {
      
      private static const SWITCH_INTERVAL:int = 200;
      
      private var weapon:RocketLauncherWeapon;
      
      private var switchStateTime:int;
      
      private var reloadTime:int;
      
      private var canExplodeRockets:Boolean;
      
      public function SimpleShotState(param1:RocketLauncherWeapon, param2:int)
      {
         super();
         this.weapon = param1;
         this.reloadTime = param2;
         this.canExplodeRockets = param1.canExplodeRockets();
      }
      
      public function getStatus() : Number
      {
         return Math.min(1 - (this.weapon.getReloadingEndTime() - getTimer()) / this.weapon.getReloadingDuration(),1);
      }
      
      public function update(param1:int) : void
      {
         if(this.weapon.canShoot(param1) && param1 >= this.switchStateTime)
         {
            this.weapon.switchToSalvoState(param1);
         }
      }
      
      public function start(param1:int) : void
      {
         this.switchStateTime = param1 + SWITCH_INTERVAL;
         if(!this.weapon.canShoot(param1) && this.canExplodeRockets)
         {
            this.weapon.explodeRockets();
         }
      }
      
      public function stop(param1:int) : void
      {
         if(this.weapon.canShoot(param1))
         {
            this.weapon.simpleShoot(param1);
         }
      }
      
      public function getReloadTime() : int
      {
         return this.reloadTime;
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.weapon = null;
      }
   }
}

