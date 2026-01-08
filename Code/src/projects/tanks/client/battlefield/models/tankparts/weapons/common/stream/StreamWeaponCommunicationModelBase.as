package projects.tanks.client.battlefield.models.tankparts.weapons.common.stream
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class StreamWeaponCommunicationModelBase extends Model
   {

      protected var server:StreamWeaponCommunicationModelServer;

      private static const modelId:Long = Long.getLong(2040386917,729965137);

      public function StreamWeaponCommunicationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new StreamWeaponCommunicationModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
