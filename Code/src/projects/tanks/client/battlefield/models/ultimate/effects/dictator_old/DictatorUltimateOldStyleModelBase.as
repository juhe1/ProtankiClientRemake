package projects.tanks.client.battlefield.models.ultimate.effects.dictator_old
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DictatorUltimateOldStyleModelBase extends Model
   {

      protected var server:DictatorUltimateOldStyleModelServer;

      private static const modelId:Long = Long.getLong(1552091197,1575861227);

      public function DictatorUltimateOldStyleModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DictatorUltimateOldStyleModelServer(IModel(this));
      }

      protected function getInitParam() : DictatorUltimateOldStyleCC
      {
         return DictatorUltimateOldStyleCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
