package projects.tanks.client.panel.model.presents
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PresentsSettingsModelBase extends Model
   {

      protected var server:PresentsSettingsModelServer;

      public static const modelId:Long = Long.getLong(1701514952,2131242841);

      public function PresentsSettingsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PresentsSettingsModelServer(IModel(this));
      }

      protected function getInitParam() : PresentsSettingsCC
      {
         return PresentsSettingsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
