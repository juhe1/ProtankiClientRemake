package alternativa.osgi.catalogs
{
   import alternativa.osgi.ServiceParamNames;
   import flash.utils.Dictionary;
   
   public class ServicesCatalog
   {
       
      
      protected var _namedServicesDictionary:Dictionary;
      
      protected var _nullParamsServiceDictionary:Dictionary;
      
      public function ServicesCatalog()
      {
         super();
         this._namedServicesDictionary = new Dictionary();
         this._nullParamsServiceDictionary = new Dictionary();
      }
      
      public function getService(serviceInterface:Class, filter:String) : Object
      {
         var name:String = null;
         var namedServicesCatalog:NamedServicesCatalog = null;
         if(Boolean(filter))
         {
            name = this.getNameByFilter(filter);
            if(name != null)
            {
               namedServicesCatalog = this._namedServicesDictionary[serviceInterface];
               if(namedServicesCatalog != null)
               {
                  return namedServicesCatalog.getService(name);
               }
            }
            return null;
         }
         return this._nullParamsServiceDictionary[serviceInterface];
      }
      
      public function getNameByFilter(filter:String) : String
      {
         var substr:String = null;
         if(filter == null)
         {
            return null;
         }
         var pattern:RegExp = / /gi;
         filter = filter.replace(pattern,"");
         var index:int = filter.indexOf("name=");
         if(index != -1)
         {
            substr = filter.substr(index + 5,filter.length - index - 5);
            index = substr.indexOf(")");
            if(index != -1)
            {
               return substr.substr(0,index);
            }
            return substr;
         }
         return null;
      }
      
      public function addService(serviceInterface:Class, serviceImplementation:Object, params:Dictionary) : void
      {
         var name:String = null;
         var namedServicesCatalog:NamedServicesCatalog = null;
         if(params == null)
         {
            if(this._nullParamsServiceDictionary[serviceInterface] != null)
            {
               throw new ArgumentError("Service " + serviceInterface + " without parameters is already registered");
            }
            this._nullParamsServiceDictionary[serviceInterface] = serviceImplementation;
         }
         else
         {
            name = String(params[ServiceParamNames.PARAM_NAME]);
            if(name == null)
            {
               throw new ArgumentError("Invalid params. You can only use the parameter \'name\'");
            }
            namedServicesCatalog = this._namedServicesDictionary[serviceInterface];
            if(namedServicesCatalog == null)
            {
               namedServicesCatalog = new NamedServicesCatalog(serviceInterface);
               this._namedServicesDictionary[serviceInterface] = namedServicesCatalog;
            }
            namedServicesCatalog.addService(name,serviceImplementation);
         }
      }
      
      public function removeService(serviceInterface:Class, params:Dictionary) : Object
      {
         var name:String = null;
         var namedServicesCatalog:NamedServicesCatalog = null;
         var result:Object = null;
         if(params != null)
         {
            name = String(params[ServiceParamNames.PARAM_NAME]);
            if(name != null)
            {
               namedServicesCatalog = this._namedServicesDictionary[serviceInterface];
               if(namedServicesCatalog != null)
               {
                  return namedServicesCatalog.removeService(name);
               }
            }
            return null;
         }
         result = this._nullParamsServiceDictionary[serviceInterface];
         delete this._nullParamsServiceDictionary[serviceInterface];
         return result;
      }
      
      public function get serviceList() : Vector.<Object>
      {
         var service:Object = null;
         var namedCatalog:NamedServicesCatalog = null;
         var namedServices:Vector.<Object> = null;
         var i:int = 0;
         var len:int = 0;
         var list:Vector.<Object> = new Vector.<Object>();
         for each(service in this._nullParamsServiceDictionary)
         {
            list.push(service);
         }
         for each(namedCatalog in this._namedServicesDictionary)
         {
            namedServices = namedCatalog.serviceList;
            for(i = 0,len = int(namedServices.length); i < len; i++)
            {
               service = namedServices[i];
               if(list.indexOf(service) == -1)
               {
                  list.push(service);
               }
            }
         }
         return list;
      }
      
      public function getServicesInfo() : Vector.<ServiceInfo>
      {
         var service:Object = null;
         var namedCatalog:NamedServicesCatalog = null;
         var list:Vector.<ServiceInfo> = null;
         var i:int = 0;
         var len:int = 0;
         var result:Vector.<ServiceInfo> = new Vector.<ServiceInfo>();
         for each(service in this._nullParamsServiceDictionary)
         {
            result.push(new ServiceInfo(service,null));
         }
         for each(namedCatalog in this._namedServicesDictionary)
         {
            list = namedCatalog.getServicesInfo();
            for(i = 0,len = int(list.length); i < len; i++)
            {
               result.push(list[i]);
            }
         }
         return result;
      }
   }
}
