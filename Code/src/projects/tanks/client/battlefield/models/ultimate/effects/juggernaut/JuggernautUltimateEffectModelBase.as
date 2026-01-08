package projects.tanks.client.battlefield.models.ultimate.effects.juggernaut
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class JuggernautUltimateEffectModelBase extends Model
   {

      protected var server:JuggernautUltimateEffectModelServer;

      private static const modelId:Long = Long.getLong(2082898043,-1742089564);

      public function JuggernautUltimateEffectModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new JuggernautUltimateEffectModelServer(IModel(this));
      }

      protected function getInitParam() : JuggernautUltimateCC
      {
         return JuggernautUltimateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
