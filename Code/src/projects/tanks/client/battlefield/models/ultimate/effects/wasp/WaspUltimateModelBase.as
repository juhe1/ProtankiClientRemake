package projects.tanks.client.battlefield.models.ultimate.effects.wasp
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class WaspUltimateModelBase extends Model
   {

      protected var server:WaspUltimateModelServer;

      public static const modelId:Long = Long.getLong(706050434,1960652493);

      public function WaspUltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WaspUltimateModelServer(IModel(this));
      }

      protected function getInitParam() : WaspUltimateCC
      {
         return WaspUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
