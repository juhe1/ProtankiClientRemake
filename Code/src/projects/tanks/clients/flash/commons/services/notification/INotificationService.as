package projects.tanks.clients.flash.commons.services.notification
{
   public interface INotificationService
   {
      function addNotification(param1:INotification, param2:Boolean = false) : void;
      
      function hasNotification(param1:String, param2:String) : Boolean;
   }
}

