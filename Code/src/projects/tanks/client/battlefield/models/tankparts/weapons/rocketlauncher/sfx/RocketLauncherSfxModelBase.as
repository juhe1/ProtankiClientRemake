package projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.sfx
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RocketLauncherSfxModelBase extends Model
   {

      protected var server:RocketLauncherSfxModelServer;

      public static const modelId:Long = Long.getLong(1535860802,1721952390);

      public function RocketLauncherSfxModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RocketLauncherSfxModelServer(IModel(this));
      }

      protected function getInitParam() : RocketLauncherSfxCC
      {
         return RocketLauncherSfxCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
