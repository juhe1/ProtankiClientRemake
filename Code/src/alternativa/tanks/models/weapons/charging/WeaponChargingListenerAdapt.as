package alternativa.tanks.models.weapons.charging
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class WeaponChargingListenerAdapt implements WeaponChargingListener
   {
      
      private var object:IGameObject;
      
      private var impl:WeaponChargingListener;
      
      public function WeaponChargingListenerAdapt(param1:IGameObject, param2:WeaponChargingListener)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function handleChargingStart(param1:int) : void
      {
         var time:int = param1;
         try
         {
            Model.object = this.object;
            this.impl.handleChargingStart(time);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function handleChargingFinish(param1:int) : void
      {
         var time:int = param1;
         try
         {
            Model.object = this.object;
            this.impl.handleChargingFinish(time);
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}

