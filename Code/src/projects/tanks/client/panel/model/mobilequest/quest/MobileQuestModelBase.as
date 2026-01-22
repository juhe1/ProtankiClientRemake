package projects.tanks.client.panel.model.mobilequest.quest
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MobileQuestModelBase extends Model
   {

      protected var server:MobileQuestModelServer;

      public static const modelId:Long = Long.getLong(2137205145,748417604);

      public function MobileQuestModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MobileQuestModelServer(IModel(this));
      }

      protected function getInitParam() : MobileQuestCC
      {
         return MobileQuestCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
