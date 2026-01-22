package projects.tanks.client.tanksservices.model.notifier.uid
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UidNotifierModelBase extends Model
   {

      protected var server:UidNotifierModelServer;

      public static const modelId:Long = Long.getLong(990863444,376077627);

      public function UidNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UidNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : UidNotifierData
      {
         return UidNotifierData(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
