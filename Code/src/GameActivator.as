package
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import projects.tanks.clients.fp10.models.battlefieldmodelflash.Activator;
   import projects.tanks.clients.flash.resourcesflash.Activator;
   import alternativa.init.BattlefieldModelActivator;
   
   public class GameActivator implements IBundleActivator
   {
      public function GameActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         new projects.tanks.clients.flash.resourcesflash.Activator().start(param1);
         new BattlefieldModelActivator().start(param1); 
         new projects.tanks.clients.fp10.models.battlefieldmodelflash.Activator().start(param1);
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

