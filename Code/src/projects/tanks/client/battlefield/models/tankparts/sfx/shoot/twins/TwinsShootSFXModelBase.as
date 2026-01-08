package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TwinsShootSFXModelBase extends Model
   {

      protected var server:TwinsShootSFXModelServer;

      private static const modelId:Long = Long.getLong(1791035142,-1712503825);

      public function TwinsShootSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TwinsShootSFXModelServer(IModel(this));
      }

      protected function getInitParam() : TwinsShootSFXCC
      {
         return TwinsShootSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
