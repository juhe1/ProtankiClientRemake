package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ArtillerySfxModelBase extends Model
   {

      protected var server:ArtillerySfxModelServer;

      private static const modelId:Long = Long.getLong(1047583544,1567719516);

      public function ArtillerySfxModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ArtillerySfxModelServer(IModel(this));
      }

      protected function getInitParam() : ArtillerySfxCC
      {
         return ArtillerySfxCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
