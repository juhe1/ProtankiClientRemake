package projects.tanks.client.battlefield.models.statistics.targetingmode
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class TargetingStatisticsModelServer
   {

      private var model:IModel;

      public function TargetingStatisticsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function switchTargetingMode(param1:TargetingMode) : void
      {
      }
   }
}
