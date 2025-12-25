package
{
   import projects.tanks.clients.fp10.models.tankspanelmodel.Activator;
   import projects.tanks.clients.fp10.models.tankschatmodel.Activator;
   import alternativa.types.Long;
   import projects.tanks.clients.flash.commons.osgi.Activator;
   import platform.client.fp10.core.osgi.ClientActivator;
   import projects.tanks.clients.fp10.models.tanksgaragemodel.Activator;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.tanks.bg.IBackgroundService;
   import projects.tanks.clients.fp10.tanksforms.Activator;
   import projects.tanks.clients.fp10.models.tanksusermodel.Activator;
   import projects.tanks.clients.flash.resources.osgi.Activator;
   import projects.tanks.clients.flash.commons.Activator;
   import platform.clients.fp10.libraries.alternativaclient.Activator;
   import init.TanksFormsActivator;
   import alternativa.init.GarageModelActivator;
   import alternativa.init.newname_13__END;
   import alternativa.init.newname_14__END;
   import alternativa.init.newname_15__END;
   import alternativa.init.newname_16__END;
   import alternativa.init.UserModelActivator;
   import platform.clients.fp10.models.alternativaspacesmodels.Activator;
   import projects.tanks.clients.fp10.models.tanksbattleselectmodel.Activator;
   import alternativa.protocol.osgi.ProtocolActivator;
   import projects.tanks.clients.flash.resources.Activator;
   import scpacker.networking.Network;
   import projects.tanks.clients.fp10.libraries.tanksservices.Activator;
   import platform.clients.fp10.commonsflash.Activator;
   import platform.clients.fp10.libraries.alternativaclientflash.Activator;
   import alternativa.init.TanksServicesActivator;
   
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
         new newname_15__END().start(osgi);
         new platform.clients.fp10.models.alternativaspacesmodels.Activator().start(osgi);
         new projects.tanks.clients.flash.commons.Activator().start(osgi);
         new projects.tanks.clients.fp10.libraries.tanksservices.Activator().start(osgi);
         new projects.tanks.clients.fp10.models.tankspanelmodel.Activator().start(osgi);
         new newname_13__END().start(osgi);
         new projects.tanks.clients.fp10.models.tankschatmodel.Activator().start(osgi);
         new projects.tanks.clients.fp10.models.tanksgaragemodel.Activator().start(osgi);
         new projects.tanks.clients.fp10.tanksforms.Activator().start(osgi);
         new projects.tanks.clients.flash.commons.osgi.Activator().start(osgi);
         new UserModelActivator().start(osgi);
         new projects.tanks.clients.fp10.models.tanksusermodel.Activator().start(osgi);
         new projects.tanks.clients.fp10.models.tanksbattleselectmodel.Activator().start(osgi);
         new projects.tanks.clients.flash.resources.osgi.Activator().start(osgi);
         new projects.tanks.clients.flash.resources.Activator().start(osgi);
         new newname_16__END().start(osgi);
         new TanksFormsActivator().start(osgi);
         new GarageModelActivator().start(osgi);
         l = new Long(1749,816);
         osgi.injectService(IBackgroundService,function(param1:Object):void
         {
            Network.newname_23__END = IBackgroundService(param1);
         },function():IBackgroundService
         {
            return Network.newname_23__END;
         });
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

