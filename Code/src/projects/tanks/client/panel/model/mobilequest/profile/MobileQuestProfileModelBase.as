package projects.tanks.client.panel.model.mobilequest.profile
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MobileQuestProfileModelBase extends Model
   {

      protected var server:MobileQuestProfileModelServer;

      public static const modelId:Long = Long.getLong(1240219703,-1345063692);

      public function MobileQuestProfileModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MobileQuestProfileModelServer(IModel(this));
      }

      protected function getInitParam() : MobileQuestProfileCC
      {
         return MobileQuestProfileCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
