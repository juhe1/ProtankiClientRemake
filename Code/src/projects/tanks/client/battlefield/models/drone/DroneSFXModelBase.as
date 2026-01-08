package projects.tanks.client.battlefield.models.drone
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DroneSFXModelBase extends Model
   {

      protected var server:DroneSFXModelServer;

      private static const modelId:Long = Long.getLong(2558086,-1197244864);

      public function DroneSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DroneSFXModelServer(IModel(this));
      }

      protected function getInitParam() : DroneSFXCC
      {
         return DroneSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
