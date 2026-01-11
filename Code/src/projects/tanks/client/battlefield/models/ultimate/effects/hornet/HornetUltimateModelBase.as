package projects.tanks.client.battlefield.models.ultimate.effects.hornet
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class HornetUltimateModelBase extends Model
   {

      protected var server:HornetUltimateModelServer;

      public static const modelId:Long = Long.getLong(1679670805,-112284013);

      public function HornetUltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new HornetUltimateModelServer(IModel(this));
      }

      protected function getInitParam() : HornetUltimateCC
      {
         return HornetUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
