package projects.tanks.client.battlefield.models.ultimate.common
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UltimateModelBase extends Model
   {

      protected var server:UltimateModelServer;

      public static const modelId:Long = Long.getLong(1502954923,909786804);

      public function UltimateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UltimateModelServer(IModel(this));
      }

      protected function getInitParam() : UltimateCC
      {
         return UltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
