package projects.tanks.client.battleservice.model.statistics.team
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class StatisticsTeamModelBase extends Model
   {

      protected var server:StatisticsTeamModelServer;

      public static const modelId:Long = Long.getLong(183455729,-2099733819);

      public function StatisticsTeamModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new StatisticsTeamModelServer(IModel(this));
      }

      protected function getInitParam() : StatisticsTeamCC
      {
         return StatisticsTeamCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
