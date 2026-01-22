package projects.tanks.client.panel.model.kitoffer
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.panel.model.kitoffer.log.KitOfferAction;

   public class KitOfferModelServer
   {

      private var model:IModel;

      public function KitOfferModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function logAction(param1:IGameObject, param2:KitOfferAction) : void
      {
      }
   }
}
