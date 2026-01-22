package projects.tanks.client.panel.model.quest.notifier
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class QuestNotifierModelBase extends Model
   {

      protected var server:QuestNotifierModelServer;

      public static const modelId:Long = Long.getLong(2083723058,-1617932508);

      public function QuestNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new QuestNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : QuestNotifierCC
      {
         return QuestNotifierCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
