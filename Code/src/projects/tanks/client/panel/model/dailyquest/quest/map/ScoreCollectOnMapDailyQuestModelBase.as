package projects.tanks.client.panel.model.dailyquest.quest.map
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class ScoreCollectOnMapDailyQuestModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(1987237204,-990754365);
      
      protected var server:ScoreCollectOnMapDailyQuestModelServer;
      
      public function ScoreCollectOnMapDailyQuestModelBase()
      {
         super();
         this.server = new ScoreCollectOnMapDailyQuestModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

