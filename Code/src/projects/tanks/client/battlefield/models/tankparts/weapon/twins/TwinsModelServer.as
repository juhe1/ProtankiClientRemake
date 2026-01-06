package projects.tanks.client.battlefield.models.tankparts.weapon.twins
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class TwinsModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _fireCommandId:Long = Long.getLong(1277019392,-355104349);
      
      private var _fireCommand_clientTimeCodec:ICodec;
      
      private var _fireCommand_barrelCodec:ICodec;
      
      private var _fireCommand_shotIdCodec:ICodec;
      
      private var _fireCommand_shotDirectionCodec:ICodec;
      
      private var _fireDummyCommandId:Long = Long.getLong(357444731,388730325);
      
      private var _fireDummyCommand_clientTimeCodec:ICodec;
      
      private var _fireDummyCommand_barrelCodec:ICodec;
      
      private var _hitStaticCommandId:Long = Long.getLong(130637440,377170052);
      
      private var _hitStaticCommand_clientTimeCodec:ICodec;
      
      private var _hitStaticCommand_shotIdCodec:ICodec;
      
      private var _hitStaticCommand_hitPointWorldCodec:ICodec;
      
      private var _hitTargetCommandId:Long = Long.getLong(56483500,-1445983993);
      
      private var _hitTargetCommand_clientTimeCodec:ICodec;
      
      private var _hitTargetCommand_shotIdCodec:ICodec;
      
      private var _hitTargetCommand_targetCodec:ICodec;
      
      private var _hitTargetCommand_targetPositionCodec:ICodec;
      
      private var _hitTargetCommand_hitPointWorldCodec:ICodec;
      
      private var model:IModel;
      
      public function TwinsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._fireCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._fireCommand_barrelCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
         this._fireCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._fireCommand_shotDirectionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._fireDummyCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._fireDummyCommand_barrelCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
         this._hitStaticCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._hitStaticCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._hitStaticCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._hitTargetCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._hitTargetCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._hitTargetCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
         this._hitTargetCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._hitTargetCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      }
      
      public function fireCommand(param1:int, param2:int, param3:int, param4:Vector3d) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._fireCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._fireCommand_barrelCodec.encode(this.protocolBuffer,param2);
         this._fireCommand_shotIdCodec.encode(this.protocolBuffer,param3);
         this._fireCommand_shotDirectionCodec.encode(this.protocolBuffer,param4);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc5_:SpaceCommand = new SpaceCommand(Model.object.id,this._fireCommandId,this.protocolBuffer);
         var _loc6_:IGameObject = Model.object;
         var _loc7_:ISpace = _loc6_.space;
         _loc7_.commandSender.sendCommand(_loc5_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function fireDummyCommand(param1:int, param2:int) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._fireDummyCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._fireDummyCommand_barrelCodec.encode(this.protocolBuffer,param2);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc3_:SpaceCommand = new SpaceCommand(Model.object.id,this._fireDummyCommandId,this.protocolBuffer);
         var _loc4_:IGameObject = Model.object;
         var _loc5_:ISpace = _loc4_.space;
         _loc5_.commandSender.sendCommand(_loc3_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function hitStaticCommand(param1:int, param2:int, param3:Vector3d) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._hitStaticCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._hitStaticCommand_shotIdCodec.encode(this.protocolBuffer,param2);
         this._hitStaticCommand_hitPointWorldCodec.encode(this.protocolBuffer,param3);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc4_:SpaceCommand = new SpaceCommand(Model.object.id,this._hitStaticCommandId,this.protocolBuffer);
         var _loc5_:IGameObject = Model.object;
         var _loc6_:ISpace = _loc5_.space;
         _loc6_.commandSender.sendCommand(_loc4_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function hitTargetCommand(param1:int, param2:int, param3:IGameObject, param4:Vector3d, param5:Vector3d) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._hitTargetCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._hitTargetCommand_shotIdCodec.encode(this.protocolBuffer,param2);
         this._hitTargetCommand_targetCodec.encode(this.protocolBuffer,param3);
         this._hitTargetCommand_targetPositionCodec.encode(this.protocolBuffer,param4);
         this._hitTargetCommand_hitPointWorldCodec.encode(this.protocolBuffer,param5);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc6_:SpaceCommand = new SpaceCommand(Model.object.id,this._hitTargetCommandId,this.protocolBuffer);
         var _loc7_:IGameObject = Model.object;
         var _loc8_:ISpace = _loc7_.space;
         _loc8_.commandSender.sendCommand(_loc6_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

