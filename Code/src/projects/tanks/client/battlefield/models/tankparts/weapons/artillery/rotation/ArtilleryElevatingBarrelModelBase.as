package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ArtilleryElevatingBarrelModelBase extends Model
   {

      protected var server:ArtilleryElevatingBarrelModelServer;

      public static const modelId:Long = Long.getLong(2038268188,-682177215);

      public function ArtilleryElevatingBarrelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ArtilleryElevatingBarrelModelServer(IModel(this));
      }

      protected function getInitParam() : ArtilleryElevatingBarrelCC
      {
         return ArtilleryElevatingBarrelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
