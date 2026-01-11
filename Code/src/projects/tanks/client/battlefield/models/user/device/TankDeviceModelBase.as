package projects.tanks.client.battlefield.models.user.device
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankDeviceModelBase extends Model
   {

      protected var server:TankDeviceModelServer;

      public static const modelId:Long = Long.getLong(354029990,178111282);

      public function TankDeviceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankDeviceModelServer(IModel(this));
      }

      protected function getInitParam() : TankDeviceCC
      {
         return TankDeviceCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
