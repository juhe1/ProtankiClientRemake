package projects.tanks.client.tanksservices.model.rankloader
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RankLoaderModelBase extends Model
   {

      protected var server:RankLoaderModelServer;

      public static const modelId:Long = Long.getLong(821241413,-534454215);

      public function RankLoaderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RankLoaderModelServer(IModel(this));
      }

      protected function getInitParam() : RankLoaderCC
      {
         return RankLoaderCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
