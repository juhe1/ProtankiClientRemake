package projects.tanks.client.battleservice.model.statistics
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class StatisticsModelBase extends Model
   {
      
      public static var modelId:Long = Long.getLong(485575169,-17734339);
      
      protected var server:StatisticsModelServer;
      
      public function StatisticsModelBase()
      {
         super();
         this.server = new StatisticsModelServer(IModel(this));
      }
      
      protected function getInitParam() : StatisticsModelCC
      {
         return StatisticsModelCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

