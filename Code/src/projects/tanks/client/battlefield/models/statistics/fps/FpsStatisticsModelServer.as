package projects.tanks.client.battlefield.models.statistics.fps
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
   
   public class FpsStatisticsModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _collectStatisticsId:Long = Long.getLong(1340801043,-1420381609);
      
      private var _collectStatistics_numTicksCodec:ICodec;
      
      private var _collectStatistics_durationCodec:ICodec;
      
      private var _collectStatistics_settingsCodec:ICodec;
      
      private var model:IModel;
      
      public function FpsStatisticsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._collectStatistics_numTicksCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._collectStatistics_durationCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._collectStatistics_settingsCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function collectStatistics(param1:int, param2:int, param3:int) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._collectStatistics_numTicksCodec.encode(this.protocolBuffer,param1);
         this._collectStatistics_durationCodec.encode(this.protocolBuffer,param2);
         this._collectStatistics_settingsCodec.encode(this.protocolBuffer,param3);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc4_:SpaceCommand = new SpaceCommand(Model.object.id,this._collectStatisticsId,this.protocolBuffer);
         var _loc5_:IGameObject = Model.object;
         var _loc6_:ISpace = _loc5_.space;
         _loc6_.commandSender.sendCommand(_loc4_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

