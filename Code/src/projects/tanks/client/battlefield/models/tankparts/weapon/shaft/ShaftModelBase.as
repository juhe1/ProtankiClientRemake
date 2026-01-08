package projects.tanks.client.battlefield.models.tankparts.weapon.shaft
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShaftModelBase extends Model
   {

      protected var server:ShaftModelServer;

      private static const modelId:Long = Long.getLong(170467452,-1685189911);

      public function ShaftModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShaftModelServer(IModel(this));
      }

      protected function getInitParam() : ShaftCC
      {
         return ShaftCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
