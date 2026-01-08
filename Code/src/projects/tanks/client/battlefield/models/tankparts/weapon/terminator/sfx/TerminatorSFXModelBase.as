package projects.tanks.client.battlefield.models.tankparts.weapon.terminator.sfx
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TerminatorSFXModelBase extends Model
   {

      protected var server:TerminatorSFXModelServer;

      private static const modelId:Long = Long.getLong(1446106501,1517097209);

      public function TerminatorSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TerminatorSFXModelServer(IModel(this));
      }

      protected function getInitParam() : TerminatorSFXCC
      {
         return TerminatorSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
