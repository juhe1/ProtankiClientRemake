package projects.tanks.client.battlefield.models.effects.description
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EffectDescriptionModelBase extends Model
   {

      protected var server:EffectDescriptionModelServer;

      private static const modelId:Long = Long.getLong(1345545806,-1145690082);

      public function EffectDescriptionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EffectDescriptionModelServer(IModel(this));
      }

      protected function getInitParam() : EffectDescriptionCC
      {
         return EffectDescriptionCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
