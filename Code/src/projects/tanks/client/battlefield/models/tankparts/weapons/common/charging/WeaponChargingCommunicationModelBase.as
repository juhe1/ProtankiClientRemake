package projects.tanks.client.battlefield.models.tankparts.weapons.common.charging
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class WeaponChargingCommunicationModelBase extends Model
   {

      protected var server:WeaponChargingCommunicationModelServer;

      private static const modelId:Long = Long.getLong(1249124405,67678961);

      public function WeaponChargingCommunicationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WeaponChargingCommunicationModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
