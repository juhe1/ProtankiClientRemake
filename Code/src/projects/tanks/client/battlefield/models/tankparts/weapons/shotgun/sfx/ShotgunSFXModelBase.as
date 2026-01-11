package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShotgunSFXModelBase extends Model
   {

      protected var server:ShotgunSFXModelServer;

      public static const modelId:Long = Long.getLong(179431987,214974876);

      public function ShotgunSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShotgunSFXModelServer(IModel(this));
      }

      protected function getInitParam() : ShotgunSFXCC
      {
         return ShotgunSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
