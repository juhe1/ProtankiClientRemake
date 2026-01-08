package projects.tanks.client.battlefield.models.tankparts.weapons.common.stream
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class StreamWeaponCommunicationModelServer
   {

      private var model:IModel;

      public function StreamWeaponCommunicationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function startFire(param1:int) : void
      {
      }

      public function stopFire(param1:int) : void
      {
      }

      public function updateTargets(param1:int, param2:Vector3d, param3:Vector.<TargetPosition>) : void
      {
      }

      public function updateTargetsDummy(param1:int, param2:Vector3d) : void
      {
      }
   }
}
