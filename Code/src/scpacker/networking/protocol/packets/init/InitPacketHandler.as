package scpacker.networking.protocol.packets.init
{
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.loader.ILoaderWindowService;
   import alternativa.tanks.servermodels.EntranceModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.loading.DispatcherModel;
   import scpacker.networking.protocol.AbstractPacketHandler;
   import scpacker.networking.protocol.AbstractPacket;
   import scpacker.networking.protocol.packets.init.ActivateProtectionInPacket;
   import scpacker.networking.protocol.packets.init.LoadResourcesInPacket;
   import scpacker.networking.protocol.packets.init.HideLoaderInPacket;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.resource.ResourcesLoader;
   import projects.tanks.client.entrance.model.entrance.entrance.EntranceModelBase;
   import platform.client.core.general.spaces.loading.dispatcher.DispatcherModelBase;
   
   public class InitPacketHandler extends AbstractPacketHandler
   {
      private var dispatcherModel:DispatcherModel;
      
      private var entranceModel:EntranceModel;
      
      private var resourcesLoader:ResourcesLoader = new ResourcesLoader();
      
      public function InitPacketHandler()
      {
         super();
         this.id = 4;
         this.dispatcherModel = DispatcherModel(modelRegistry.getModel(DispatcherModelBase.modelId));
         this.entranceModel = EntranceModel(modelRegistry.getModel(EntranceModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ActivateProtectionInPacket.id:
               this.activateProtection(param1 as ActivateProtectionInPacket);
               break;
            case LoadResourcesInPacket.id:
               this.loadResources(param1 as LoadResourcesInPacket);
               break;
            case HideLoaderInPacket.id:
               this.hideLoader();
         }
      }
      
      private function loadResources(param1:LoadResourcesInPacket) : void
      {
         this.dispatcherModel.loadDependencies(this.resourcesLoader.getResourceDependencies(param1.resourcesJson,param1.callbackId));
         Model.popObject();
      }
      
      private function hideLoader() : void
      {
         (OSGi.getInstance().getService(ILoaderWindowService) as ILoaderWindowService).hide();
         this.entranceModel.objectLoaded();
         this.entranceModel.objectLoadedPost();
      }
      
      private function activateProtection(param1:ActivateProtectionInPacket) : void
      {
         var _loc2_:ProtocolInitializer = ProtocolInitializer(OSGi.getInstance().getService(ProtocolInitializer));
         _loc2_.InitializeProtection(param1.keys);
      }
   }
}

