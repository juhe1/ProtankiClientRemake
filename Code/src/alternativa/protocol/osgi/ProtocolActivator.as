package alternativa.protocol.osgi
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.impl.Protocol;
   
   public class ProtocolActivator implements IBundleActivator
   {
      
      public function ProtocolActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         var _loc2_:IProtocol = Protocol.defaultInstance;
         param1.registerService(IProtocol,_loc2_);
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

