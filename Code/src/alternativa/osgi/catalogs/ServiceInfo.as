package alternativa.osgi.catalogs
{
   public class ServiceInfo
   {
       
      
      public var service:Object;
      
      public var params:Vector.<ServiceParam>;
      
      public function ServiceInfo(service:Object, params:Vector.<ServiceParam>)
      {
         super();
         this.service = service;
         this.params = params;
      }
   }
}
