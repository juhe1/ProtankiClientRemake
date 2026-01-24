package projects.tanks.client.panel.model.dailyquest.quest.goal
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class CaptureGoalDailyQuestModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(347671443,1825907790);
      
      protected var server:CaptureGoalDailyQuestModelServer;
      
      public function CaptureGoalDailyQuestModelBase()
      {
         super();
         this.server = new CaptureGoalDailyQuestModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

