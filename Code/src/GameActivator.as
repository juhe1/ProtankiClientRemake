package
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import projects.tanks.clients.fp10.models.battlefieldmodelflash.Activator;
   
   public class GameActivator implements IBundleActivator
   {
      public function GameActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         new Activator().start(param1);
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

