package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming.ShotGunAimingCC;

   public class ShotgunHittingModelBase extends Model
   {

      protected var server:ShotgunHittingModelServer;

      public static const modelId:Long = Long.getLong(1519945329,-715940911);

      public function ShotgunHittingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShotgunHittingModelServer(IModel(this));
      }

      protected function getInitParam() : ShotGunAimingCC
      {
         return ShotGunAimingCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
