package projects.tanks.client.panel.model.dailyquest.quest.mode
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class DailyQuestWithModeModelBase extends Model
   {
      
      public static var modelId:Long = Long.getLong(821104050,858728004);
      
      protected var server:DailyQuestWithModeModelServer;
      
      public function DailyQuestWithModeModelBase()
      {
         super();
         this.server = new DailyQuestWithModeModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

