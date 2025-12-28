package scpacker.logging
{
   import alternativa.osgi.OSGi;
   import alternativa.tanks.gui.error.ErrorNotification;
   import flash.display.LoaderInfo;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import projects.tanks.clients.flash.commons.services.notification.INotificationService;
   
   public class RemoteLogging implements IRemoteLogging
   {
      private var url:String;
      
      private var logCount:int;
      
      public function RemoteLogging(param1:LoaderInfo)
      {
         super();
         this.url = "http://1048237349:19402/dancefloor_of_err";
      }
      
      // original name: newname_2042__END
      public function log(param1:String) : void
      {
         //var urlRequest:URLRequest;
         //var urlLoader:URLLoader;
         //var notificErrTarg:int;
         //var data:String = param1;
         //if(this.logCount < 40)
         //{
         //   urlRequest = new URLRequest(this.url);
         //   urlRequest.method = "POST";
         //   urlRequest.data = data.replace(/=/g,"~");
         //   urlLoader = new URLLoader();
         //   urlLoader.addEventListener("ioError",function():void
         //   {
         //   },false,0,true);
         //   urlLoader.addEventListener("securityError",function():void
         //   {
         //   },false,0,true);
         //   urlLoader.load(urlRequest);
         //}
         //notificErrTarg = 23;
         //if(++this.logCount > notificErrTarg)
         //{
         //   INotificationService(OSGi.getInstance().getService(INotificationService)).addNotification(new ErrorNotification());
         //}
      }
   }
}

