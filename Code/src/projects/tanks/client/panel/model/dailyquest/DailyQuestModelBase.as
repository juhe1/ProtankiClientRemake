package projects.tanks.client.panel.model.dailyquest
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class DailyQuestModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(1302806391,660914812);
      
      protected var server:DailyQuestModelServer;
      
      public function DailyQuestModelBase()
      {
         super();
         this.server = new DailyQuestModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

