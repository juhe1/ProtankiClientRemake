package projects.tanks.client.battlefield.models.anticheat.timechecker
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class TimeCheckerModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _pongId:Long = Long.getLong(829170552,1724953279);
      
      private var _pong_clientTimeCodec:ICodec;
      
      private var _pong_serverSessionTimeCodec:ICodec;
      
      private var model:IModel;
      
      public function TimeCheckerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._pong_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._pong_serverSessionTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function pong(param1:int, param2:int) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._pong_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._pong_serverSessionTimeCodec.encode(this.protocolBuffer,param2);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc3_:SpaceCommand = new SpaceCommand(Model.object.id,this._pongId,this.protocolBuffer);
         var _loc4_:IGameObject = Model.object;
         var _loc5_:ISpace = _loc4_.space;
         _loc5_.commandSender.sendCommand(_loc3_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

