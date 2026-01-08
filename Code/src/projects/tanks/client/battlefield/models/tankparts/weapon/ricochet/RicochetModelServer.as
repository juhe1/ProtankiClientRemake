package projects.tanks.client.battlefield.models.tankparts.weapon.ricochet
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class RicochetModelServer
   {

      private var model:IModel;

      public function RicochetModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
      }

      public function fireDummyCommand(param1:int) : void
      {
      }

      public function hitStaticCommand(param1:int, param2:int, param3:Vector.<Vector3d>) : void
      {
      }

      public function hitTargetCommand(param1:int, param2:IGameObject, param3:int, param4:Vector3d, param5:Vector.<Vector3d>) : void
      {
      }
   }
}
