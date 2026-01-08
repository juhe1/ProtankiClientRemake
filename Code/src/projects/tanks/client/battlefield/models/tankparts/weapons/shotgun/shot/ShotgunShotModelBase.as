package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShotgunShotModelBase extends Model
   {

      protected var server:ShotgunShotModelServer;

      private static const modelId:Long = Long.getLong(1366230363,-857495328);

      public function ShotgunShotModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShotgunShotModelServer(IModel(this));
      }

      protected function getInitParam() : ShotgunShotCC
      {
         return ShotgunShotCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
