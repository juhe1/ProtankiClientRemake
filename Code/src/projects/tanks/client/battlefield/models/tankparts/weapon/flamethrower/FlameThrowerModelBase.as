package projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FlameThrowerModelBase extends Model
   {

      protected var server:FlameThrowerModelServer;

      private static const modelId:Long = Long.getLong(1034700989,1212373553);

      public function FlameThrowerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FlameThrowerModelServer(IModel(this));
      }

      protected function getInitParam() : FlameThrowerCC
      {
         return FlameThrowerCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
