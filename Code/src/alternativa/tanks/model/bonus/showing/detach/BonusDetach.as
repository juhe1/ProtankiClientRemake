package alternativa.tanks.model.bonus.showing.detach
{
   import flash.events.Event;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.flash.commons.models.detach.Detach;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.commons.models.detach.DetachModelBase;
   
   public class BonusDetach
   {
      [Inject] // added
      static public var modelRegistry:ModelRegistry;

      private var object:IGameObject;
      
      public function BonusDetach(param1:IGameObject)
      {
         super();
         this.object = param1;
      }
      
      public function detach(param1:Event = null) : void
      {
         Detach(modelRegistry.getModel(DetachModelBase.modelId)).detach();
      }
   }
}

