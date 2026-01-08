package projects.tanks.client.battlefield.models.user.bossstate
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BossStateModelBase extends Model
   {

      protected var server:BossStateModelServer;

      private static const modelId:Long = Long.getLong(1177132817,1695744884);

      public function BossStateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BossStateModelServer(IModel(this));
      }

      protected function getInitParam() : BossStateCC
      {
         return BossStateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
