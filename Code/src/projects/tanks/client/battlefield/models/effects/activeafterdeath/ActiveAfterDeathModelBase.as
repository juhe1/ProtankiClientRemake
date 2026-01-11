package projects.tanks.client.battlefield.models.effects.activeafterdeath
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ActiveAfterDeathModelBase extends Model
   {

      protected var server:ActiveAfterDeathModelServer;

      public static const modelId:Long = Long.getLong(1901483815,1408063475);

      public function ActiveAfterDeathModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ActiveAfterDeathModelServer(IModel(this));
      }

      protected function getInitParam() : ActiveAfterDeathCC
      {
         return ActiveAfterDeathCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
