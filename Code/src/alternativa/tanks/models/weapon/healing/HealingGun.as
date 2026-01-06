package alternativa.tanks.models.weapon.healing
{
   import alternativa.tanks.battle.objects.tank.Tank;
   
   public interface HealingGun
   {
      
      function onTargetLost(param1:Tank) : void;
   }
}

