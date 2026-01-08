package projects.tanks.client.battlefield.models.ultimate.effects.mammoth
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MammothUltimateModelBase extends Model
   {

      protected var server:MammothUltimateModelServer;

      private static const modelId:Long = Long.getLong(465096987,1359010901);

      public function MammothUltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MammothUltimateModelServer(IModel(this));
      }

      protected function getInitParam() : MammothUltimateCC
      {
         return MammothUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
