package projects.tanks.clients.flash.commons.services.notification
{
   import org.osflash.signals.Signal;
   
   public interface INotification
   {
      function show(param1:Signal) : void;
      
      function destroy() : void;
      
      function get userId() : String;
      
      function get message() : String;
   }
}

