package alternativa.tanks.servermodels
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.loader.ILoaderWindowService;
   import alternativa.tanks.service.IEntranceClientFacade;
   import alternativa.tanks.service.IEntranceServerFacade;
   import flash.events.Event;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.model.ObjectUnloadPostListener;
   import projects.tanks.client.entrance.model.entrance.entrance.EntranceModelBase;
   import projects.tanks.client.entrance.model.entrance.entrance.IEntranceModelBase;
   import projects.tanks.clients.flash.commons.models.captcha.IServerCaptcha;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.commons.models.captcha.CaptchaModelBase;
   import platform.client.fp10.core.model.impl.Model;
   
   [ModelInfo]
   public class EntranceModel extends EntranceModelBase implements IEntranceModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, ObjectUnloadPostListener
   {
      
      [Inject] // added
      public static var serverFacade:IEntranceServerFacade;
      
      [Inject] // added
      public static var clientFacade:IEntranceClientFacade;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var loaderWindow:ILoaderWindowService;

      [Inject] // added
      public static var modelRegistry:ModelRegistry;
      
      public function EntranceModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         clientFacade.showView();
         clientFacade.antiAddictionEnabled = false;
         display.stage.dispatchEvent(new Event("EntranceModel.objectLoaded",true));
      }
      
      public function objectLoadedPost() : void
      {
         serverFacade.entranceObject = platform.client.fp10.core.model.impl.Model.currentObject;
         clientFacade.entranceObject = platform.client.fp10.core.model.impl.Model.currentObject;
         IServerCaptcha(modelRegistry.getModel(CaptchaModelBase.modelId)).bindFacade(clientFacade);
      }
      
      public function objectUnloaded() : void
      {
         IServerCaptcha(modelRegistry.getModel(CaptchaModelBase.modelId)).unbindFacade();
         loaderWindow.show();
      }
      
      public function objectUnloadedPost() : void
      {
         clientFacade.hideView();
      }
   }
}

