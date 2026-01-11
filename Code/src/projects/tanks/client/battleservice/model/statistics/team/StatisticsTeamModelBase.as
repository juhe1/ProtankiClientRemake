package projects.tanks.client.battleservice.model.statistics.team
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class StatisticsTeamModelBase extends Model
   {
      
      public static var modelId:Long = Long.getLong(183455729,-2099733819);
      
      protected var server:StatisticsTeamModelServer;
      
      public function StatisticsTeamModelBase()
      {
         super();
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

