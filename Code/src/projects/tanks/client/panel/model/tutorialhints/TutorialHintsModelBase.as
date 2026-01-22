package projects.tanks.client.panel.model.tutorialhints
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TutorialHintsModelBase extends Model
   {

      protected var server:TutorialHintsModelServer;

      public static const modelId:Long = Long.getLong(1524013763,797788828);

      public function TutorialHintsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TutorialHintsModelServer(IModel(this));
      }

      protected function getInitParam() : TutorialHintsCC
      {
         return TutorialHintsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
