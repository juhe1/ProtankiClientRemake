package projects.tanks.client.panel.model.quest.daily.type.bonus
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusCatchDailyQuestModelBase extends Model
   {

      protected var server:BonusCatchDailyQuestModelServer;

      public static const modelId:Long = Long.getLong(170908502,1988359357);

      public function BonusCatchDailyQuestModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusCatchDailyQuestModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
