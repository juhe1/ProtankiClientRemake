package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SmokyShootSFXModelBase extends Model
   {

      protected var server:SmokyShootSFXModelServer;

      public static const modelId:Long = Long.getLong(407046073,1894066655);

      public function SmokyShootSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SmokyShootSFXModelServer(IModel(this));
      }

      protected function getInitParam() : SmokyShootSFXCC
      {
         return SmokyShootSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
