package projects.tanks.client.battlefield.models.tankparts.weapon.smoky
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class SmokyModelServer
   {

      private var model:IModel;

      public function SmokyModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int) : void
      {
      }

      public function fireStaticCommand(param1:int, param2:Vector3d) : void
      {
      }

      public function fireTargetCommand(param1:int, param2:IGameObject, param3:int, param4:Vector3d, param5:Vector3d, param6:Vector3d) : void
      {
      }
   }
}
