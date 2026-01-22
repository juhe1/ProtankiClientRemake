package projects.tanks.client.tanksservices.model.notifier.socialnetworks
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SNUidNotifierModelBase extends Model
   {

      protected var server:SNUidNotifierModelServer;

      public static const modelId:Long = Long.getLong(1741772027,-10049568);

      public function SNUidNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SNUidNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : SNUidNotifierData
      {
         return SNUidNotifierData(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
