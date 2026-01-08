package projects.tanks.client.battlefield.models.tankparts.weapon.twins
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class TwinsModelServer
   {

      private var model:IModel;

      public function TwinsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int, param2:int, param3:int, param4:Vector3d) : void
      {
      }

      public function fireDummyCommand(param1:int, param2:int) : void
      {
      }

      public function hitStaticCommand(param1:int, param2:int, param3:Vector3d) : void
      {
      }

      public function hitTargetCommand(param1:int, param2:int, param3:IGameObject, param4:Vector3d, param5:Vector3d) : void
      {
      }
   }
}
