package projects.tanks.client.panel.model.dailyquest.quest.bonus
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class BonusCatchDailyQuestModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(316972997,1784029669);
      
      protected var server:BonusCatchDailyQuestModelServer;
      
      public function BonusCatchDailyQuestModelBase()
      {
         super();
         this.server = new BonusCatchDailyQuestModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

