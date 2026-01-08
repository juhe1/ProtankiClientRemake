package projects.tanks.client.battlefield.models.ultimate.effects.dictator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DictatorUltimateModelBase extends Model
   {

      protected var server:DictatorUltimateModelServer;

      private static const modelId:Long = Long.getLong(1534471818,-1953347155);

      public function DictatorUltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DictatorUltimateModelServer(IModel(this));
      }

      protected function getInitParam() : DictatorUltimateCC
      {
         return DictatorUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
