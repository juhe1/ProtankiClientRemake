package projects.tanks.client.battlefield.models.battle.jgr
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class JuggernautModelBase extends Model
   {

      protected var server:JuggernautModelServer;

      private static const modelId:Long = Long.getLong(1833384627,1931960874);

      public function JuggernautModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new JuggernautModelServer(IModel(this));
      }

      protected function getInitParam() : JuggernautCC
      {
         return JuggernautCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
