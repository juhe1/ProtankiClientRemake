package projects.tanks.clients.flash.resources.resource
{
   import alternativa.proplib.PropLibRegistry;
   import alternativa.types.Long;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.IResourceSerializationListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.resource.ResourceStatus;
   import platform.client.fp10.core.resource.SafeURLLoader;
   
   public class MapResource extends Resource
   {
      
      [Inject]
      public static var resourceRegistry:ResourceRegistry;
      
      public static const TYPE:int = 7;
      
      private static const BINARY_HEADER:Vector.<int> = Vector.<int>([77,65,80,1]);
      
      private static const LOADING_STATE_IDLE:int = 0;
      
      private static const LOADING_STATE_INFO:int = 1;
      
      private static const LOADING_STATE_PROPLIB_INFO:int = LOADING_STATE_INFO + 1;
      
      private static const LOADING_STATE_MAP:int = LOADING_STATE_INFO + 2;
      
      private static const LIBS_FILE_NAME:String = "proplibs.xml";
      
      private static const MAP_FILE_NAME:String = "map.xml";
      
      public var libRegistry:PropLibRegistry;
      
      public var proplibsData:ByteArray;
      
      public var mapData:ByteArray;
      
      public var libIds:Vector.<Long>;
      
      private var loader:SafeURLLoader;
      
      private var loadingState:int = -1;
      
      public function MapResource(param1:ResourceInfo)
      {
         super(param1);
      }
      
      override public function get description() : String
      {
         return "Map";
      }
      
      override public function load(param1:String, param2:IResourceLoadingListener) : void
      {
         super.load(param1,param2);
         this.loadProplibsInfo();
      }
      
      private function loadProplibsInfo() : void
      {
         this.createUrlLoader(this.onPropLibsInfoLoadingOpen,this.onPropLibsInfoLoadingComplete);
         this.loader.load(new URLRequest(baseUrl + LIBS_FILE_NAME));
         this.loadingState = LOADING_STATE_PROPLIB_INFO;
         status = ResourceStatus.REQUESTED;
         startTimeoutTracking();
      }
      
      override public function close() : void
      {
         if(this.loadingState != LOADING_STATE_IDLE)
         {
            this.loader.close();
         }
         this.destroyLoader();
         this.proplibsData = null;
         this.mapData = null;
      }
      
      override protected function doReload() : void
      {
         switch(this.loadingState)
         {
            case LOADING_STATE_PROPLIB_INFO:
               this.loader.close();
               this.destroyLoader();
               this.loadProplibsInfo();
               break;
            case LOADING_STATE_MAP:
               this.loader.close();
               this.destroyLoader();
               this.loadMap();
         }
      }
      
      override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean
      {
         this.listener = param2;
         if(param1 == null || param1.length < BINARY_HEADER.length)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < BINARY_HEADER.length)
         {
            if(param1.readUnsignedByte() != BINARY_HEADER[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         var _loc4_:int = param1.readInt();
         this.proplibsData = new ByteArray();
         param1.readBytes(this.proplibsData,0,_loc4_);
         _loc4_ = param1.readInt();
         this.mapData = new ByteArray();
         param1.readBytes(this.mapData,0,_loc4_);
         this.buildMap();
         setTimeout(completeLoading,0);
         return true;
      }
      
      override public function serialize(param1:IResourceSerializationListener) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:int = 0;
         while(_loc3_ < BINARY_HEADER.length)
         {
            _loc2_.writeByte(BINARY_HEADER[_loc3_]);
            _loc3_++;
         }
         _loc2_.writeInt(this.proplibsData.length);
         _loc2_.writeBytes(this.proplibsData);
         _loc2_.writeInt(length);
         _loc2_.writeBytes(this.mapData);
         param1.onSerializationComplete(this,_loc2_);
      }
      
      private function onPropLibsInfoLoadingOpen(param1:Event) : void
      {
         updateLastActivityTime();
      }
      
      private function onPropLibsInfoLoadingComplete(param1:Event) : void
      {
         this.proplibsData = this.loader.data;
         this.destroyLoader();
         this.loadMap();
      }
      
      private function parsePropLibsInfo(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:Long = null;
         var _loc5_:PropLibResource = null;
         this.libRegistry = new PropLibRegistry();
         this.libIds = new Vector.<Long>();
         for each(_loc2_ in param1.library)
         {
            _loc3_ = int("0x" + _loc2_.attribute("resource-id").toString());
            _loc4_ = Long.getLong(0,_loc3_);
            this.libIds.push(_loc4_);
            _loc5_ = PropLibResource(resourceRegistry.getResource(_loc4_));
            if(_loc5_ == null)
            {
               throw new Error("Prop library resource [id=" + _loc4_ + "] not found");
            }
            this.libRegistry.addLibrary(_loc5_.lib);
         }
      }
      
      private function loadMap() : void
      {
         this.createUrlLoader(this.onMapLoadingOpen,this.onMapLoadingComplete);
         this.loader.load(new URLRequest(baseUrl + MAP_FILE_NAME));
         this.loadingState = LOADING_STATE_MAP;
         startTimeoutTracking();
      }
      
      private function onMapLoadingOpen(param1:Event) : void
      {
         updateLastActivityTime();
      }
      
      private function onMapLoadingComplete(param1:Event) : void
      {
         this.mapData = this.loader.data;
         this.destroyLoader();
         this.buildMap();
         completeLoading();
      }
      
      private function buildMap() : void
      {
         try
         {
            this.parsePropLibsInfo(XML(this.proplibsData.toString()));
         }
         catch(e:Error)
         {
            listener.onResourceLoadingFatalError(this,e.message + " " + e.getStackTrace());
         }
      }
      
      private function onLoadingError(param1:ErrorEvent) : void
      {
         listener.onResourceLoadingFatalError(this,param1.text);
      }
      
      private function createUrlLoader(param1:Function, param2:Function) : void
      {
         this.loader = new SafeURLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.OPEN,param1);
         this.loader.addEventListener(Event.COMPLETE,param2);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
         this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      }
      
      private function destroyLoader() : void
      {
         if(this.loader == null)
         {
            return;
         }
         this.loader.removeEventListener(Event.OPEN,this.onPropLibsInfoLoadingOpen);
         this.loader.removeEventListener(Event.COMPLETE,this.onPropLibsInfoLoadingComplete);
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
         this.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
         this.loader = null;
      }
   }
}

