package projects.tanks.client.battlefield.models.ultimate.effects.hunter
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class HunterUltimateModelBase extends Model
   {

      protected var server:HunterUltimateModelServer;

      public static const modelId:Long = Long.getLong(1026046526,1304951507);

      public function HunterUltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new HunterUltimateModelServer(IModel(this));
      }

      protected function getInitParam() : HunterUltimateCC
      {
         return HunterUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
