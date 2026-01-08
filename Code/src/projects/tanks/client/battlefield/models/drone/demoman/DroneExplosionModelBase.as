package projects.tanks.client.battlefield.models.drone.demoman
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DroneExplosionModelBase extends Model
   {

      protected var server:DroneExplosionModelServer;

      private static const modelId:Long = Long.getLong(327725701,-804290777);

      public function DroneExplosionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DroneExplosionModelServer(IModel(this));
      }

      protected function getInitParam() : DroneExplosionCC
      {
         return DroneExplosionCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
