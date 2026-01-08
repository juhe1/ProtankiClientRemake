package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DiscreteWeaponCommunicationModelBase extends Model
   {

      protected var server:DiscreteWeaponCommunicationModelServer;

      private static const modelId:Long = Long.getLong(486222912,-663069007);

      public function DiscreteWeaponCommunicationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DiscreteWeaponCommunicationModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
