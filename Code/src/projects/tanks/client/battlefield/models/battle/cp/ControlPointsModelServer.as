package projects.tanks.client.battlefield.models.battle.cp
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ControlPointsModelServer
   {

      private var model:IModel;

      public function ControlPointsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function forceUpdatePoint(param1:int) : void
      {
      }
   }
}
