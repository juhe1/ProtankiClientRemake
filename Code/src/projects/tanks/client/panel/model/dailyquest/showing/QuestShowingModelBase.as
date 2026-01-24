package projects.tanks.client.panel.model.dailyquest.showing
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;

   public class QuestShowingModelBase extends Model
   {
      protected var server:QuestShowingModelServer;

      static public var modelId:Long = Long.getLong(1726782619,1524609945);

      public function QuestShowingModelBase()
      {
         super();
         this.server = new QuestShowingModelServer(this);
      }

      override public function get id() : Long
      {
         return QuestShowingModelBase.modelId;
      }
   }
}
