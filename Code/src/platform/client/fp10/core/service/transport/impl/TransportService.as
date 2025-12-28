package platform.client.fp10.core.service.transport.impl
{
   import flash.utils.ByteArray;
   import platform.client.fp10.core.network.connection.IConnection;
   import platform.client.fp10.core.network.handler.ControlCommandHandler;
   import platform.client.fp10.core.service.transport.ITransportService;
   
   public class TransportService implements ITransportService
   {
      
      private var _controlCommandHandler:ControlCommandHandler;
      
      private var _hash:ByteArray;
      
      public function TransportService()
      {
         super();
      }
      
      public function get controlCommandHandler() : ControlCommandHandler
      {
         if(this._controlCommandHandler == null)
         {
            this._controlCommandHandler = new ControlCommandHandler();
         }
         return this._controlCommandHandler;
      }
      
      public function get controlConnection() : IConnection
      {
         return IConnection(this.controlCommandHandler.getCommandSender());
      }
      
      public function get hash() : ByteArray
      {
         if(this._hash == null)
         {
            this._hash = this.controlCommandHandler.getChannelContext().hash;
         }
         return this._hash;
      }
   }
}

