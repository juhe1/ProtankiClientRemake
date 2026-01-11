package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShaftShootSFXModelBase extends Model
   {

      protected var server:ShaftShootSFXModelServer;

      public static const modelId:Long = Long.getLong(2117558336,-406639565);

      public function ShaftShootSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShaftShootSFXModelServer(IModel(this));
      }

      protected function getInitParam() : ShaftShootSFXCC
      {
         return ShaftShootSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
