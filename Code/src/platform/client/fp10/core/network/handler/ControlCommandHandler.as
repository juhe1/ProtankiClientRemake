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
      
      [Inject]
      public static var logService:LogService;
      
      private static var logger:Logger;
      
      [Inject]
      public static var messageBoxService:IErrorMessageService;
      
      [Inject]
      public static var spaceRegistry:SpaceRegistry;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var launcherParams:ILauncherParams;
      
      [Inject]
      public static var addressService:AddressService;
      
      private var channelContext:ControlChannelContext = new ControlChannelContext();
      
      private var commandSender:ICommandSender;
      
      public function ControlCommandHandler()
      {
         super();
         var _loc1_:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.channelContext.spaceProtocol = _loc1_;
      }
      
      private static function getLogger() : Logger
      {
         return logger || (logger = logService.getLogger("control"));
      }
      
      public function getCommandSender() : ICommandSender
      {
         return this.commandSender;
      }
      
      public function getChannelContext() : ControlChannelContext
      {
         return this.channelContext;
      }
      
      public function onConnectionOpen(param1:ICommandSender) : void
      {
         this.commandSender = param1;
         this.sendConnectionResponse();
      }
      
      public function onConnectionClose(param1:ConnectionCloseStatus, param2:String = null) : void
      {
         var _loc3_:Object = null;
         var _loc4_:ISpace = null;
         while(spaceRegistry.spaces.length > 0)
         {
            _loc4_ = spaceRegistry.spaces[0];
            _loc4_.close();
         }
         for each(_loc3_ in OSGi.getInstance().serviceList)
         {
            if(_loc3_ is OnConnectionClosedServiceListener)
            {
               OnConnectionClosedServiceListener(_loc3_).onConnectionClosed(param1);
            }
         }
         if(param1 != ConnectionCloseStatus.CLOSED_BY_CLIENT)
         {
            messageBoxService.showMessage(new ConnectionClosedError(param1));
         }
         this.commandSender = null;
         this.logDumpers();
      }
      
      public function executeCommand(param1:Object) : void
      {
         IServerControlCommand(param1).execute(this.channelContext);
      }
      
      private function sendConnectionResponse() : void
      {
         var _loc3_:String = null;
         var _loc4_:Dictionary = null;
         var _loc5_:String = null;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         for each(_loc3_ in launcherParams.parameterNames)
         {
            _loc1_.push(_loc3_);
            _loc2_.push(launcherParams.getParameter(_loc3_));
         }
         _loc1_.push("clientHashURL");
         _loc2_.push(this.getClientHashURL());
         _loc4_ = ClientParamUtil.collectClientParams();
         for(_loc5_ in _loc4_)
         {
            _loc1_.push(_loc5_);
            _loc2_.push(_loc4_[_loc5_]);
         }
         this.commandSender.sendCommand(new HashRequestCommand(_loc1_,_loc2_));
      }
      
      private function logDumpers() : void
      {
         var _loc2_:IDumper = null;
         var _loc1_:IDumpService = IDumpService(OSGi.getInstance().getService(IDumpService));
         for each(_loc2_ in _loc1_.dumpersList)
         {
            logService.getLogger("dumper_" + _loc2_.dumperName).info(_loc2_.dump([]));
         }
      }
      
      private function getClientHashURL() : String
      {
         return addressService.getBaseURL() + "#" + addressService.getValue();
      }
   }
}

