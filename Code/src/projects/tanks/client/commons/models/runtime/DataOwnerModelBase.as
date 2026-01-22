package projects.tanks.client.commons.models.runtime
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DataOwnerModelBase extends Model
   {

      protected var server:DataOwnerModelServer;

      public static const modelId:Long = Long.getLong(1160870944,208895362);

      public function DataOwnerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DataOwnerModelServer(IModel(this));
      }

      protected function getInitParam() : DataOwnerCC
      {
         return DataOwnerCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
