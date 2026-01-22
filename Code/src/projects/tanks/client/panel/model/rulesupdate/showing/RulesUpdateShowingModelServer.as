package projects.tanks.client.panel.model.rulesupdate.showing
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class RulesUpdateShowingModelServer
   {

      private var model:IModel;

      public function RulesUpdateShowingModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function userAcceptedRules() : void
      {
      }
   }
}
