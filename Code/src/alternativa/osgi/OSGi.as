package alternativa.osgi
{
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.bundle.IBundleDescriptor;
   import alternativa.osgi.catalogs.ServiceInfo;
   import alternativa.osgi.catalogs.ServiceListenersCatalog;
   import alternativa.osgi.catalogs.ServicesCatalog;
   import alternativa.osgi.service.IServiceRegisterListener;
   import alternativa.osgi.service.clientlog.IClientLogBase;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.osgi.service.logging.Logger;
   import alternativa.osgi.service.logging.impl.LogServiceImpl;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class OSGi
   {
      
      public static var clientLog:IClientLogBase;
      
      private static var instance:OSGi;
       
      
      private var bundleDescriptors:Object;
      
      private var services:ServicesCatalog;
      
      private var serivceInterface2injectPoints:Dictionary;
      
      private var serviceRegisterListenersByInterface:Dictionary;
      
      private var logger:Logger;
      
      public function OSGi()
      {
         this.bundleDescriptors = {};
         this.services = new ServicesCatalog();
         this.serivceInterface2injectPoints = new Dictionary();
         this.serviceRegisterListenersByInterface = new Dictionary();
         super();
         if(instance == null)
         {
            instance = this;
            this.initLogging();
            return;
         }
         throw new Error("Only one instance of OSGi class is allowed");
      }
      
      public static function getInstance() : OSGi
      {
         if(instance == null)
         {
            instance = new OSGi();
         }
         return instance;
      }
      
      public static function paramsToString(params:Dictionary) : String
      {
         var key:* = undefined;
         var result:String = "";
         for(key in params)
         {
            result += " (" + key + " = " + params[key] + ")";
         }
         return result;
      }
      
      private static function notifyServiceRemovalListeners(serviceInterface:Class, serviceImplementation:Object, listenerInfos:Vector.<ListenerInfo>) : void
      {
         var listenerInfo:ListenerInfo = null;
         var implementations:Vector.<Object> = null;
         var implementation:Object = null;
         for each(listenerInfo in listenerInfos)
         {
            implementations = listenerInfo.implementations;
            for each(implementation in implementations)
            {
               if(implementation == serviceImplementation)
               {
                  listenerInfo.listener.serviceUnregistered(serviceInterface,serviceImplementation);
                  break;
               }
            }
         }
      }
      
      private function initLogging() : void
      {
         var logService:LogServiceImpl = new LogServiceImpl();
         this.logger = logService.getLogger("osgi");
         this.registerService(LogService,logService);
      }
      
      public function installBundle(bundleDescriptor:IBundleDescriptor) : void
      {
         var i:int = 0;
         var activator:IBundleActivator = null;
         if(Boolean(this.bundleDescriptors[bundleDescriptor.name]))
         {
            throw new Error("Bundle " + bundleDescriptor.name + " is already installed");
         }
         this.logger.debug("Installing bundle: " + bundleDescriptor.name);
         this.logger.debug("Bundle activators: " + bundleDescriptor.activators);
         this.bundleDescriptors[bundleDescriptor.name] = bundleDescriptor;
         var activators:Vector.<IBundleActivator> = bundleDescriptor.activators;
         if(activators != null)
         {
            for(i = 0; i < activators.length; i++)
            {
               activator = activators[i];
               this.logger.debug("Invoking start() on activator: " + getQualifiedClassName(activator));
               activator.start(this);
            }
         }
         this.logger.debug("Bundle has been installed: " + bundleDescriptor.name);
      }
      
      public function uninstallBundle(bundleName:String) : void
      {
         var i:int = 0;
         var activator:IBundleActivator = null;
         if(bundleName == null)
         {
            throw new ArgumentError("Bundle name is null");
         }
         var bundleDescriptor:IBundleDescriptor = this.bundleDescriptors[bundleName];
         if(bundleDescriptor == null)
         {
            throw new Error("Bundle " + bundleName + " not found");
         }
         var activators:Vector.<IBundleActivator> = bundleDescriptor.activators;
         if(activators != null)
         {
            for(i = 0; i < activators.length; i++)
            {
               activator = activators[i];
               this.logger.debug("Invoking stop() on activator " + getQualifiedClassName(activator));
               activator.stop(this);
            }
         }
         delete this.bundleDescriptors[bundleName];
         this.logger.debug("Bundle has been uninstalled: " + bundleName);
      }
      
      public function registerService(serviceInterface:Class, serviceImplementation:Object, params:Dictionary = null) : void
      {
         this.services.addService(serviceInterface,serviceImplementation,params);
         this.updateInject(serviceInterface);
         this.logger.debug("Service has been registered: " + serviceInterface + paramsToString(params));
         this.notifyServiceRegistrationListeners(serviceInterface,serviceImplementation);
      }
      
      private function updateInject(serviceInterface:Class) : void
      {
         var injectPoints:Vector.<InjectPoint> = null;
         var ip:InjectPoint = null;
         if(this.serivceInterface2injectPoints[serviceInterface] != null)
         {
            injectPoints = this.serivceInterface2injectPoints[serviceInterface];
            for each(ip in injectPoints)
            {
               ip.injectFunction(this.services.getService(serviceInterface,ip.filter));
               this.logger.debug("Service has been injected: " + serviceInterface);
            }
         }
      }
      
      private function notifyServiceRegistrationListeners(serviceInterface:Class, serviceImplementation:Object) : void
      {
         var listener:IServiceRegisterListener = null;
         var filters:Vector.<String> = null;
         var filter:String = null;
         var service:Object = null;
         var serviceListenersCatalog:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[serviceInterface];
         if(serviceListenersCatalog == null)
         {
            return;
         }
         var listeners:Vector.<IServiceRegisterListener> = serviceListenersCatalog.getListeners();
         if(listeners == null)
         {
            return;
         }
         for each(listener in listeners)
         {
            filters = serviceListenersCatalog.getFilters(listener);
            for each(filter in filters)
            {
               service = this.services.getService(serviceInterface,filter);
               if(service == serviceImplementation)
               {
                  listener.serviceRegistered(serviceInterface,serviceImplementation);
                  break;
               }
            }
         }
      }
      
      public function registerServiceMulti(serviceInterfaces:Array, serviceImplementation:Object, params:Dictionary = null) : void
      {
         var serviceInterface:Class = null;
         for each(serviceInterface in serviceInterfaces)
         {
            this.registerService(serviceInterface,serviceImplementation,params);
         }
      }
      
      public function unregisterService(serviceInterface:Class, params:Dictionary = null) : void
      {
         var j:int = 0;
         var injectPoint:InjectPoint = null;
         var listenerInfos:Vector.<ListenerInfo> = this.getListenerInfos(serviceInterface);
         var serviceImplementation:Object = this.services.removeService(serviceInterface,params);
         if(serviceImplementation == null)
         {
            return;
         }
         var injectPoints:Vector.<InjectPoint> = this.serivceInterface2injectPoints[serviceInterface];
         if(injectPoints != null)
         {
            for(j = injectPoints.length - 1; j >= 0; j--)
            {
               injectPoint = injectPoints[j];
               if(injectPoint.valueReturnInjectFunction() == serviceImplementation)
               {
                  injectPoint.injectFunction(null);
               }
            }
         }
         this.logger.debug("Service has been unregistered: " + serviceInterface + paramsToString(params));
         notifyServiceRemovalListeners(serviceInterface,serviceImplementation,listenerInfos);
      }
      
      private function getListenerInfos(serviceInterface:Class) : Vector.<ListenerInfo>
      {
         var listeners:Vector.<IServiceRegisterListener> = null;
         var listener:IServiceRegisterListener = null;
         var filters:Vector.<String> = null;
         var listenerInfo:ListenerInfo = null;
         var filter:String = null;
         var service:Object = null;
         var listenerInfos:Vector.<ListenerInfo> = new Vector.<ListenerInfo>();
         var serviceListenersCatalog:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[serviceInterface];
         if(serviceListenersCatalog != null)
         {
            listeners = serviceListenersCatalog.getListeners();
            if(listeners != null)
            {
               for each(listener in listeners)
               {
                  filters = serviceListenersCatalog.getFilters(listener);
                  listenerInfo = new ListenerInfo(listener);
                  for each(filter in filters)
                  {
                     service = this.services.getService(serviceInterface,filter);
                     if(service != null)
                     {
                        listenerInfo.addService(service);
                     }
                  }
                  listenerInfos.push(listenerInfo);
               }
            }
         }
         return listenerInfos;
      }
      
      public function getService(serviceInterface:Class, filter:String = "") : Object
      {
         return this.services.getService(serviceInterface,filter);
      }
      
      public function addServiceRegisterListener(serviceInterface:Class, listener:IServiceRegisterListener, filter:String = "") : void
      {
         var serviceListenersCatalog:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[serviceInterface];
         if(serviceListenersCatalog == null)
         {
            serviceListenersCatalog = new ServiceListenersCatalog();
            this.serviceRegisterListenersByInterface[serviceInterface] = serviceListenersCatalog;
         }
         serviceListenersCatalog.addListener(listener,filter);
      }
      
      public function removeServiceRegisterListener(serviceInterface:Class, listener:IServiceRegisterListener, filter:String = "") : void
      {
         var serviceListenersCatalog:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[serviceInterface];
         if(serviceListenersCatalog != null)
         {
            serviceListenersCatalog.removeListener(listener,filter);
         }
      }
      
      public function injectService(serviceInterface:Class, injectFunction:Function, valueReturnInjectFunction:Function, filter:String = "") : void
      {
         if(!this.serivceInterface2injectPoints[serviceInterface])
         {
            this.serivceInterface2injectPoints[serviceInterface] = new Vector.<InjectPoint>();
         }
         this.serivceInterface2injectPoints[serviceInterface].push(new InjectPoint(injectFunction,valueReturnInjectFunction,filter));
         var serviceImplementation:Object = this.services.getService(serviceInterface,filter);
         injectFunction(serviceImplementation);
         this.logger.debug("Inject %1 have been processed. Current value is %2",[serviceInterface,serviceImplementation]);
      }
      
      public function get bundleList() : Vector.<IBundleDescriptor>
      {
         var bundleDescriptor:IBundleDescriptor = null;
         var list:Vector.<IBundleDescriptor> = new Vector.<IBundleDescriptor>();
         for each(bundleDescriptor in this.bundleDescriptors)
         {
            list.push(bundleDescriptor);
         }
         return list;
      }
      
      public function get serviceList() : Vector.<Object>
      {
         return this.services.serviceList;
      }
      
      public function getServicesInfo() : Vector.<ServiceInfo>
      {
         return this.services.getServicesInfo();
      }
      
      public function createSharedObject(name:String, localPath:String = null, secure:Boolean = false) : SharedObject
      {
         return SharedObject.getLocal(name,localPath,secure);
      }
   }
}

class InjectPoint
{
    
   
   public var injectFunction:Function;
   
   public var valueReturnInjectFunction:Function;
   
   public var filter:String;
   
   public function InjectPoint(injectFunction:Function, valueReturnInjectFunction:Function, filter:String)
   {
      super();
      this.injectFunction = injectFunction;
      this.valueReturnInjectFunction = valueReturnInjectFunction;
      this.filter = filter;
   }
}

import alternativa.osgi.service.IServiceRegisterListener;

class ListenerInfo
{
    
   
   public var listener:IServiceRegisterListener;
   
   public var implementations:Vector.<Object>;
   
   public function ListenerInfo(listener:IServiceRegisterListener)
   {
      this.implementations = new Vector.<Object>();
      super();
      this.listener = listener;
   }
   
   public function addService(serviceImplementation:Object) : void
   {
      if(this.implementations.indexOf(serviceImplementation) == -1)
      {
         this.implementations.push(serviceImplementation);
      }
   }
}
