package projects.tanks.client.battlefield.models.battle.assault
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AssaultModelBase extends Model
   {

      protected var server:AssaultModelServer;

      private static const modelId:Long = Long.getLong(1012996430,-1521107309);

      public function AssaultModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AssaultModelServer(IModel(this));
      }

      protected function getInitParam() : AssaultCC
      {
         return AssaultCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
