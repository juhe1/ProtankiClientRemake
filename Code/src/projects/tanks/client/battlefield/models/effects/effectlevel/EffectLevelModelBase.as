package projects.tanks.client.battlefield.models.effects.effectlevel
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EffectLevelModelBase extends Model
   {

      protected var server:EffectLevelModelServer;

      private static const modelId:Long = Long.getLong(735266884,-238307683);

      public function EffectLevelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EffectLevelModelServer(IModel(this));
      }

      protected function getInitParam() : EffectLevelCC
      {
         return EffectLevelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
