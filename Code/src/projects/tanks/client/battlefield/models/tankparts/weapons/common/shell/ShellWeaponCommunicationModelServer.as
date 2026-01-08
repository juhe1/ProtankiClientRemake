package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class ShellWeaponCommunicationModelServer
   {

      private var model:IModel;

      public function ShellWeaponCommunicationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function tryToDummyShoot(param1:int, param2:int) : void
      {
      }

      public function tryToHit(param1:int, param2:ShellHit) : void
      {
      }

      public function tryToShoot(param1:int, param2:int, param3:int, param4:Vector3d) : void
      {
      }

      public function tryToShootWithTarget(param1:int, param2:int, param3:int, param4:Vector3d, param5:TargetPosition, param6:Vector3d) : void
      {
      }
   }
}
