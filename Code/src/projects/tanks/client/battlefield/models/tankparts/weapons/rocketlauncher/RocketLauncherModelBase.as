package projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RocketLauncherModelBase extends Model
   {

      protected var server:RocketLauncherModelServer;

      private static const modelId:Long = Long.getLong(941970784,-960815088);

      public function RocketLauncherModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RocketLauncherModelServer(IModel(this));
      }

      protected function getInitParam() : RocketLauncherCC
      {
         return RocketLauncherCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
