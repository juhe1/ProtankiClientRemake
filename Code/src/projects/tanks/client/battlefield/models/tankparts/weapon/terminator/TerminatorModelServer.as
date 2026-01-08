package projects.tanks.client.battlefield.models.tankparts.weapon.terminator
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class TerminatorModelServer
   {

      private var model:IModel;

      public function TerminatorModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function primaryCharge(param1:int, param2:int) : void
      {
      }

      public function primaryDummyShot(param1:int, param2:int) : void
      {
      }

      public function primaryShot(param1:int, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:Vector.<int>, param6:Vector.<Vector3d>, param7:Vector.<Vector3d>, param8:int) : void
      {
      }

      public function secondaryHide(param1:int) : void
      {
      }

      public function secondaryOpen(param1:int) : void
      {
      }
   }
}
