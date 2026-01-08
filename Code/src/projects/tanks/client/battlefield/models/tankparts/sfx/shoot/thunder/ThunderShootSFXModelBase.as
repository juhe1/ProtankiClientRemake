package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ThunderShootSFXModelBase extends Model
   {

      protected var server:ThunderShootSFXModelServer;

      private static const modelId:Long = Long.getLong(1907120794,-320511521);

      public function ThunderShootSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ThunderShootSFXModelServer(IModel(this));
      }

      protected function getInitParam() : ThunderShootSFXCC
      {
         return ThunderShootSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
