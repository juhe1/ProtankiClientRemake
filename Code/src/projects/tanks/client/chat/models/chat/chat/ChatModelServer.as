package projects.tanks.client.chat.models.chat.chat
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.EnumCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class ChatModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _changeChannelId:Long = Long.getLong(1556150623,-1920786149);
      
      private var _changeChannel_channelCodec:ICodec;
      
      private var _sendMessageId:Long = Long.getLong(727072716,-952919953);
      
      private var _sendMessage_targetUserNameCodec:ICodec;
      
      private var _sendMessage_addressModeCodec:ICodec;
      
      private var _sendMessage_channelCodec:ICodec;
      
      private var _sendMessage_textCodec:ICodec;
      
      private var model:IModel;
      
      public function ChatModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._changeChannel_channelCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
         this._sendMessage_targetUserNameCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
         this._sendMessage_addressModeCodec = this.protocol.getCodec(new EnumCodecInfo(ChatAddressMode,false));
         this._sendMessage_channelCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
         this._sendMessage_textCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      }
      
      public function changeChannel(param1:String) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._changeChannel_channelCodec.encode(this.protocolBuffer,param1);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc2_:SpaceCommand = new SpaceCommand(Model.object.id,this._changeChannelId,this.protocolBuffer);
         var _loc3_:IGameObject = Model.object;
         var _loc4_:ISpace = _loc3_.space;
         _loc4_.commandSender.sendCommand(_loc2_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function sendMessage(param1:String, param2:ChatAddressMode, param3:String, param4:String) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._sendMessage_targetUserNameCodec.encode(this.protocolBuffer,param1);
         this._sendMessage_addressModeCodec.encode(this.protocolBuffer,param2);
         this._sendMessage_channelCodec.encode(this.protocolBuffer,param3);
         this._sendMessage_textCodec.encode(this.protocolBuffer,param4);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc5_:SpaceCommand = new SpaceCommand(Model.object.id,this._sendMessageId,this.protocolBuffer);
         var _loc6_:IGameObject = Model.object;
         var _loc7_:ISpace = _loc6_.space;
         _loc7_.commandSender.sendCommand(_loc5_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

