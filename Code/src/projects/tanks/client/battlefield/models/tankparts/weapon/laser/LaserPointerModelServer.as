package projects.tanks.client.battlefield.models.tankparts.weapon.laser
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class LaserPointerModelServer
   {

      private var model:IModel;

      public function LaserPointerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function aimAtTank(param1:IGameObject, param2:Vector3d) : void
      {
      }

      public function hide() : void
      {
      }

      public function updateDirection(param1:Number) : void
      {
      }
   }
}
