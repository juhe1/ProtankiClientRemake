package projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.radio
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RocketLauncherRadioExplosionModelBase extends Model
   {

      protected var server:RocketLauncherRadioExplosionModelServer;

      private static const modelId:Long = Long.getLong(993900446,591673085);

      public function RocketLauncherRadioExplosionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RocketLauncherRadioExplosionModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
