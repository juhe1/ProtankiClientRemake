package projects.tanks.client.panel.model.dailyquest.quest.goal.equip
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class CaptureGoalWithEquipDailyQuestModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(1946491975,212873830);
      
      protected var server:CaptureGoalWithEquipDailyQuestModelServer;
      
      public function CaptureGoalWithEquipDailyQuestModelBase()
      {
         super();
         this.server = new CaptureGoalWithEquipDailyQuestModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

