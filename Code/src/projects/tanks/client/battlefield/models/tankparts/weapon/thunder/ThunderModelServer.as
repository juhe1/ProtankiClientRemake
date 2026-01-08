package projects.tanks.client.battlefield.models.tankparts.weapon.thunder
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class ThunderModelServer
   {

      private var model:IModel;

      public function ThunderModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function shootCommand(param1:int) : void
      {
      }

      public function shootStaticCommand(param1:int, param2:Vector3d) : void
      {
      }

      public function shootTargetCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:int, param5:Vector3d, param6:Vector3d) : void
      {
      }
   }
}
