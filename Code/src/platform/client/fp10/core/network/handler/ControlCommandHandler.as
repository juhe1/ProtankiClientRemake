package platform.client.fp10.core.network.handler
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.dump.IDumpService;
   import alternativa.osgi.service.dump.IDumper;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.osgi.service.logging.Logger;
   import alternativa.protocol.IProtocol;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.network.ControlChannelContext;
   import platform.client.fp10.core.network.ICommandHandler;
   import platform.client.fp10.core.network.ICommandSender;
   import platform.client.fp10.core.network.command.IServerControlCommand;
   import platform.client.fp10.core.network.command.control.client.HashRequestCommand;
   import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.service.address.AddressService;
   import platform.client.fp10.core.service.clientparam.ClientParamUtil;
   import platform.client.fp10.core.service.errormessage.IErrorMessageService;
   import platform.client.fp10.core.service.errormessage.errors.ConnectionClosedError;
   import platform.client.fp10.core.type.ISpace;
   
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

