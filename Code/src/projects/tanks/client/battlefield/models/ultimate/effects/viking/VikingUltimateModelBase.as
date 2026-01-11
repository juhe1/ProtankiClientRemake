package projects.tanks.client.battlefield.models.ultimate.effects.viking
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class VikingUltimateModelBase extends Model
   {

      protected var server:VikingUltimateModelServer;

      public static const modelId:Long = Long.getLong(1758244583,2134467693);

      public function VikingUltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new VikingUltimateModelServer(IModel(this));
      }

      protected function getInitParam() : VikingUltimateCC
      {
         return VikingUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
