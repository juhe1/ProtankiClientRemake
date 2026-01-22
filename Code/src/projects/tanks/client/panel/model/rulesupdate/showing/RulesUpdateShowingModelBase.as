package projects.tanks.client.panel.model.rulesupdate.showing
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RulesUpdateShowingModelBase extends Model
   {

      protected var server:RulesUpdateShowingModelServer;

      public static const modelId:Long = Long.getLong(339112017,194970316);

      public function RulesUpdateShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RulesUpdateShowingModelServer(IModel(this));
      }

      protected function getInitParam() : RulesUpdateShowingCC
      {
         return RulesUpdateShowingCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
