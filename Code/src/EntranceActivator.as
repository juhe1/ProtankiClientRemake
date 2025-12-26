package
{
   import projects.tanks.clients.fp10.models.tankspanelmodelflash.Activator;
   import projects.tanks.clients.fp10.models.tankschatmodelflash.Activator;
   import alternativa.types.Long;
   import projects.tanks.clients.flash.commons.osgi.Activator;
   import platform.client.fp10.core.osgi.ClientActivator;
   import projects.tanks.clients.fp10.models.tanksgaragemodelflash.Activator;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.tanks.bg.IBackgroundService;
   import projects.tanks.clients.fp10.tanksformsflash.Activator;
   import projects.tanks.clients.fp10.models.tanksusermodelflash.Activator;
   import projects.tanks.clients.flash.resources.osgi.Activator;
   import projects.tanks.clients.flash.commonsflash.Activator;
   import platform.clients.fp10.libraries.alternativaclient.Activator;
   import init.TanksFormsActivator;
   import alternativa.init.GarageModelActivator;
   import alternativa.init.UserModelActivator;
   import platform.clients.fp10.models.alternativaspacesmodelsflash.Activator;
   import projects.tanks.clients.fp10.models.tanksbattleselectmodelflash.Activator;
   import alternativa.protocol.osgi.ProtocolActivator;
   import projects.tanks.clients.flash.resources.Activator;
   import scpacker.networking.Network;
   import projects.tanks.clients.fp10.libraries.tanksservicesflash.Activator;
   import platform.clients.fp10.commonsflash.Activator;
   import platform.clients.fp10.libraries.alternativaclientflash.Activator;
   import alternativa.init.TanksServicesActivator;
   import alternativa.init.TanksFonts;
   import alternativa.init.PanelModelActivator;
   //import alternativa.init.BattleSelectModelActivator;
   
   public class EntranceActivator implements IBundleActivator
   {
      public function EntranceActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         var l:Long;
         var ls:List_skin;
         var tls:TileList_skin;
         var sbti:ScrollBar_thumbIcon;
         var spus:ScrollPane_upSkin;
         var osgi:OSGi = param1;
         new TanksServicesActivator().start(osgi);
         new ProtocolActivator().start(osgi);
         new ClientActivator().start(osgi);
         new platform.clients.fp10.libraries.alternativaclientflash.Activator().start(osgi);
         new platform.clients.fp10.commonsflash.Activator().start(osgi);
         new TanksFonts().start(osgi);
         new platform.clients.fp10.models.alternativaspacesmodelsflash.Activator().start(osgi);
         new projects.tanks.clients.flash.commonsflash.Activator().start(osgi);
         new projects.tanks.clients.fp10.libraries.tanksservicesflash.Activator().start(osgi);
         new projects.tanks.clients.fp10.models.tankspanelmodelflash.Activator().start(osgi);
         new PanelModelActivator().start(osgi);
         new projects.tanks.clients.fp10.models.tankschatmodelflash.Activator().start(osgi);
         new projects.tanks.clients.fp10.models.tanksgaragemodelflash.Activator().start(osgi);
         new projects.tanks.clients.fp10.tanksformsflash.Activator().start(osgi);
         new projects.tanks.clients.flash.commons.osgi.Activator().start(osgi);
         new UserModelActivator().start(osgi);
         new projects.tanks.clients.fp10.models.tanksusermodelflash.Activator().start(osgi);
         new projects.tanks.clients.fp10.models.tanksbattleselectmodelflash.Activator().start(osgi);
         new projects.tanks.clients.flash.resources.osgi.Activator().start(osgi);
         //new projects.tanks.clients.flash.resources.Activator().start(osgi);
         //new BattleSelectModelActivator().start(osgi);
         new TanksFormsActivator().start(osgi);
         new GarageModelActivator().start(osgi);
         l = new Long(1749,816);
         osgi.injectService(IBackgroundService,function(param1:Object):void
         {
            Network.backgroundService = IBackgroundService(param1);
         },function():IBackgroundService
         {
            return Network.backgroundService;
         });
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

