package platform.client.fp10.core.resource
{
   import alternativa.startup.LibraryInfo;
   import alternativa.types.Long;
   import flash.display.Loader;
   import platform.client.fp10.core.logging.serverlog.UncaughtErrorServerLog;
   
   public class LibraryResourceWrapper extends Resource
   {
      
      [Inject] // added
      public static var uncaughtErrorServerLog:UncaughtErrorServerLog;
      
      private var loader:Loader;
      
      private var libraryInfo:LibraryInfo;
      
      public function LibraryResourceWrapper(param1:LibraryInfo)
      {
         super(new ResourceInfo(ResourceType.SWF_LIBRARY,Long.fromHexString(param1.resourceId),Long.fromHexString(param1.resourceVersion),false,0));
         this.loader = param1.loader;
         this.libraryInfo = param1;
         uncaughtErrorServerLog.addLoader(this.loader);
      }
      
      override public function toString() : String
      {
         return "[" + super.toString() + ", name = " + this.libraryInfo.name + "]";
      }
   }
}

