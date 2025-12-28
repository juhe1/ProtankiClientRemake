package platform.client.fp10.core.network.handler
{
   import alternativa.osgi.service.logging.Logger;
   import platform.client.fp10.core.network.ICommandHandler;
   import platform.client.fp10.core.network.ICommandSender;
   import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
   
   public class ControlCommandHandler implements ICommandHandler
   {
      public function ControlCommandHandler()
      {
         super();
      }
      
      private static function getLogger() : Logger
      {
         return null;
      }
      
      public function getCommandSender() : ICommandSender
      {
         return null;
      }
      
      public function onConnectionOpen(param1:ICommandSender) : void
      {
      }
      
      public function onConnectionClose(param1:ConnectionCloseStatus, param2:String = null) : void
      {
      }
      
      public function executeCommand(param1:Object) : void
      {
      }
   }
}

