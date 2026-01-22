package projects.tanks.client.panel.model.quest.daily.type.goal.equip
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CaptureGoalWithEquipDailyQuestModelBase extends Model
   {

      protected var server:CaptureGoalWithEquipDailyQuestModelServer;

      public static const modelId:Long = Long.getLong(941686527,1251303096);

      public function CaptureGoalWithEquipDailyQuestModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new CaptureGoalWithEquipDailyQuestModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
