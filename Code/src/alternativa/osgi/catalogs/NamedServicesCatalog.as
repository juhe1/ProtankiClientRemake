package alternativa.osgi.catalogs
{
   import alternativa.osgi.ServiceParamNames;
   import flash.utils.Dictionary;
   
   public class NamedServicesCatalog
   {
       
      
      protected var namesDictionary:Dictionary;
      
      private var serviceInterface:Class;
      
      public function NamedServicesCatalog(serviceInterface:Class)
      {
         super();
         this.serviceInterface = serviceInterface;
         this.namesDictionary = new Dictionary();
      }
      
      public function getService(name:String) : Object
      {
         if(name == null)
         {
            throw new ArgumentError("name can\'t be null");
         }
         return this.namesDictionary[name];
      }
      
      public function addService(name:String, serviceImplementation:Object) : void
      {
         var value:Object = null;
         if(name == null)
         {
            throw new ArgumentError("name can\'t be null");
         }
         value = this.namesDictionary[name];
         if(value != null && value != serviceImplementation)
         {
            throw new ArgumentError("Service " + this.serviceInterface + "with name \'" + name + "\' is already registered");
         }
         this.namesDictionary[name] = serviceImplementation;
      }
      
      public function removeService(name:String) : Object
      {
         var result:Object = null;
         if(name == null)
         {
            throw new ArgumentError("name can\'t be null");
         }
         result = this.namesDictionary[name];
         delete this.namesDictionary[name];
         return result;
      }
      
      public function get serviceList() : Vector.<Object>
      {
         var service:Object = null;
         var list:Vector.<Object> = new Vector.<Object>();
         for each(service in this.namesDictionary)
         {
            list.push(service);
         }
         return list;
      }
      
      public function getServicesInfo() : Vector.<ServiceInfo>
      {
         var key:* = undefined;
         var result:Vector.<ServiceInfo> = new Vector.<ServiceInfo>();
         for(key in this.namesDictionary)
         {
            result.push(new ServiceInfo(this.namesDictionary[key],Vector.<ServiceParam>([new ServiceParam(ServiceParamNames.PARAM_NAME,key)])));
         }
         return result;
      }
   }
}
