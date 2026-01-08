package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class DiscreteWeaponCommunicationModelServer
   {

      private var model:IModel;

      public function DiscreteWeaponCommunicationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function tryToDummyShoot(param1:int, param2:Vector3d) : void
      {
      }

      public function tryToShoot(param1:int, param2:Vector3d, param3:Vector.<TargetPosition>) : void
      {
      }
   }
}
