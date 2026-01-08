package projects.tanks.client.battlefield.models.user.suicide
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SuicideModelBase extends Model
   {

      protected var server:SuicideModelServer;

      private static const modelId:Long = Long.getLong(528941690,1765829096);

      public function SuicideModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SuicideModelServer(IModel(this));
      }

      protected function getInitParam() : SuicideCC
      {
         return SuicideCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
