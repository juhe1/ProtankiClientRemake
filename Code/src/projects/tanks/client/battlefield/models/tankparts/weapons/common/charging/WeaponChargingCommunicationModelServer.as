package projects.tanks.client.battlefield.models.tankparts.weapons.common.charging
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class WeaponChargingCommunicationModelServer
   {

      private var model:IModel;

      public function WeaponChargingCommunicationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function finishCharging(param1:int) : void
      {
      }

      public function startCharging(param1:int) : void
      {
      }
   }
}
