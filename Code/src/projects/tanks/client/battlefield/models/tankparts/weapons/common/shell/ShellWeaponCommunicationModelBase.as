package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShellWeaponCommunicationModelBase extends Model
   {

      protected var server:ShellWeaponCommunicationModelServer;

      public static const modelId:Long = Long.getLong(288784246,84754739);

      public function ShellWeaponCommunicationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShellWeaponCommunicationModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
