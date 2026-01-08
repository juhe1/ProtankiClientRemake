package projects.tanks.client.battlefield.models.drone
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DroneIndicatorModelBase extends Model
   {

      protected var server:DroneIndicatorModelServer;

      private static const modelId:Long = Long.getLong(1936258281,-1608612342);

      public function DroneIndicatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DroneIndicatorModelServer(IModel(this));
      }

      protected function getInitParam() : DroneIndicatorCC
      {
         return DroneIndicatorCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
