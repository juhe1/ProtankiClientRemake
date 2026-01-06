package projects.tanks.client.battlefield.models.tankparts.weapon.thunder
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class ThunderModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _shootCommandId:Long = Long.getLong(304771021,-505618508);
      
      private var _shootCommand_shotTimeCodec:ICodec;
      
      private var _shootStaticCommandId:Long = Long.getLong(119662358,318565694);
      
      private var _shootStaticCommand_shotTimeCodec:ICodec;
      
      private var _shootStaticCommand_directionCodec:ICodec;
      
      private var _shootTargetCommandId:Long = Long.getLong(193816297,2141719739);
      
      private var _shootTargetCommand_shotTimeCodec:ICodec;
      
      private var _shootTargetCommand_relativeHitPointCodec:ICodec;
      
      private var _shootTargetCommand_targetCodec:ICodec;
      
      private var _shootTargetCommand_targetIncarnationCodec:ICodec;
      
      private var _shootTargetCommand_targetPositionCodec:ICodec;
      
      private var _shootTargetCommand_hitPointWorldCodec:ICodec;
      
      private var model:IModel;
      
      public function ThunderModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._shootCommand_shotTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._shootStaticCommand_shotTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._shootStaticCommand_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._shootTargetCommand_shotTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._shootTargetCommand_relativeHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._shootTargetCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
         this._shootTargetCommand_targetIncarnationCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
         this._shootTargetCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._shootTargetCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      }
      
      public function shootCommand(param1:int) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._shootCommand_shotTimeCodec.encode(this.protocolBuffer,param1);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc2_:SpaceCommand = new SpaceCommand(Model.object.id,this._shootCommandId,this.protocolBuffer);
         var _loc3_:IGameObject = Model.object;
         var _loc4_:ISpace = _loc3_.space;
         _loc4_.commandSender.sendCommand(_loc2_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function shootStaticCommand(param1:int, param2:Vector3d) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._shootStaticCommand_shotTimeCodec.encode(this.protocolBuffer,param1);
         this._shootStaticCommand_directionCodec.encode(this.protocolBuffer,param2);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc3_:SpaceCommand = new SpaceCommand(Model.object.id,this._shootStaticCommandId,this.protocolBuffer);
         var _loc4_:IGameObject = Model.object;
         var _loc5_:ISpace = _loc4_.space;
         _loc5_.commandSender.sendCommand(_loc3_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function shootTargetCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:int, param5:Vector3d, param6:Vector3d) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._shootTargetCommand_shotTimeCodec.encode(this.protocolBuffer,param1);
         this._shootTargetCommand_relativeHitPointCodec.encode(this.protocolBuffer,param2);
         this._shootTargetCommand_targetCodec.encode(this.protocolBuffer,param3);
         this._shootTargetCommand_targetIncarnationCodec.encode(this.protocolBuffer,param4);
         this._shootTargetCommand_targetPositionCodec.encode(this.protocolBuffer,param5);
         this._shootTargetCommand_hitPointWorldCodec.encode(this.protocolBuffer,param6);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc7_:SpaceCommand = new SpaceCommand(Model.object.id,this._shootTargetCommandId,this.protocolBuffer);
         var _loc8_:IGameObject = Model.object;
         var _loc9_:ISpace = _loc8_.space;
         _loc9_.commandSender.sendCommand(_loc7_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

