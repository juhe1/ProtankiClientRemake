package projects.tanks.client.battlefield.models.tankparts.weapon.terminator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TerminatorModelBase extends Model
   {

      protected var server:TerminatorModelServer;

      private static const modelId:Long = Long.getLong(1596182265,-1705134735);

      public function TerminatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TerminatorModelServer(IModel(this));
      }

      protected function getInitParam() : TerminatorCC
      {
         return TerminatorCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
