package projects.tanks.client.battlefield.models.ultimate.effects.titan
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TitanUltimateModelBase extends Model
   {

      protected var server:TitanUltimateModelServer;

      public static const modelId:Long = Long.getLong(1981801083,1760802737);

      public function TitanUltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TitanUltimateModelServer(IModel(this));
      }

      protected function getInitParam() : TitanUltimateCC
      {
         return TitanUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
