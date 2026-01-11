package projects.tanks.client.battlefield.models.user.temperature
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankTemperatureModelBase extends Model
   {

      protected var server:TankTemperatureModelServer;

      public static const modelId:Long = Long.getLong(1044732133,1674200214);

      public function TankTemperatureModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankTemperatureModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
