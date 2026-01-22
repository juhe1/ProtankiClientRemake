package projects.tanks.client.panel.model.shop.indemnity
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class IndemnityModelBase extends Model
   {

      protected var server:IndemnityModelServer;

      public static const modelId:Long = Long.getLong(1847639326,476338528);

      public function IndemnityModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new IndemnityModelServer(IModel(this));
      }

      protected function getInitParam() : IndemnityCC
      {
         return IndemnityCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
