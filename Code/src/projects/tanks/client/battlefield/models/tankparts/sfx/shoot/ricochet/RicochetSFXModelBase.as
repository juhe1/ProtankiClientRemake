package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RicochetSFXModelBase extends Model
   {

      protected var server:RicochetSFXModelServer;

      private static const modelId:Long = Long.getLong(1224006945,1002444060);

      public function RicochetSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RicochetSFXModelServer(IModel(this));
      }

      protected function getInitParam() : RicochetSFXCC
      {
         return RicochetSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
