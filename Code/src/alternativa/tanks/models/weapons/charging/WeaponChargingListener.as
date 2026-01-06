package alternativa.tanks.models.weapons.charging
{
   [ModelInterface]
   public interface WeaponChargingListener
   {
      
      function handleChargingStart(param1:int) : void;
      
      function handleChargingFinish(param1:int) : void;
   }
}

