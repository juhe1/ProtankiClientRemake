package projects.tanks.client.chat.models.news.showing
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NewsShowingModelBase extends Model
   {

      protected var server:NewsShowingModelServer;

      public static const modelId:Long = Long.getLong(202181824,-248161435);

      public function NewsShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NewsShowingModelServer(IModel(this));
      }

      protected function getInitParam() : NewsShowingCC
      {
         return NewsShowingCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
