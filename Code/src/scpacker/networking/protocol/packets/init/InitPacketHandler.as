package scpacker.networking.protocol.packets.init
{
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.loader.ILoaderWindowService;
   import alternativa.tanks.servermodels.EntranceModel;
   import scpacker.utils.ResourcesLoader;
   import platform.client.fp10.core.model.impl.Model;
   import platform.loading.DispatcherModel;
   import scpacker.networking.protocol.AbstractPacketHandler;
   import scpacker.networking.protocol.AbstractPacket;
   import scpacker.networking.protocol.packets.init.ActivateProtection;
   import scpacker.networking.protocol.packets.init.LoadResources;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.resource.ResourcesLoader;
   
   public class InitPacketHandler extends AbstractPacketHandler
   {
      private var dispatcherModel:DispatcherModel;
      
      private var entranceModel:EntranceModel;
      
      private var resourcesLoader:ResourcesLoader = new ResourcesLoader();
      
      public function InitPacketHandler()
      {
         super();
         this.id = 4;
         this.dispatcherModel = DispatcherModel(modelRegistry.getModel(Long.getLong(191355032,163351191)));
         this.entranceModel = EntranceModel(modelRegistry.getModel(Long.getLong(687101726,-1582366168)));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case 2001736388:
               this.activateProtection(param1 as ActivateProtection);
               break;
            case -1797047325:
               this.loadResources(param1 as LoadResources);
               break;
            case -1282173466:
               this.hideLoader();
         }
      }
      
      private function loadResources(param1:LoadResources) : void
      {
         this.dispatcherModel.loadDependencies(this.resourcesLoader.getResourceDependencies(param1.BattlesJson,param1.CallbackID));
         Model.popObject();
      }
      
      private function hideLoader() : void
      {
         (OSGi.getInstance().getService(ILoaderWindowService) as ILoaderWindowService).hide();
         this.entranceModel.objectLoadedPost();
      }
      
      private function activateProtection(param1:ActivateProtection) : void
      {
         var _loc2_:ProtocolInitializer = ProtocolInitializer(OSGi.getInstance().getService(ProtocolInitializer));
         _loc2_.InitializeProtection(param1.Keys);
      }
   }
}

