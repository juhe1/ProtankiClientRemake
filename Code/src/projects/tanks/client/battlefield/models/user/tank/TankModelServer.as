package projects.tanks.client.battlefield.models.user.tank
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   
   public class TankModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _deathConfirmationCommandId:Long = Long.getLong(674088239,-466180297);
      
      private var _handleCollisionWithOtherTankId:Long = Long.getLong(27305946,689085087);
      
      private var _handleCollisionWithOtherTank_otherTankZVelocityCodec:ICodec;
      
      private var _moveCommandId:Long = Long.getLong(2114337908,577714981);
      
      private var _moveCommand_clientTimeCodec:ICodec;
      
      private var _moveCommand_specificationIdCodec:ICodec;
      
      private var _moveCommand_moveCommandCodec:ICodec;
      
      private var _movementControlCommandId:Long = Long.getLong(1028282615,1943158798);
      
      private var _movementControlCommand_clientTimeCodec:ICodec;
      
      private var _movementControlCommand_specificationIdCodec:ICodec;
      
      private var _movementControlCommand_controlCodec:ICodec;
      
      private var _movementControlCommand_turnSpeedNumberCodec:ICodec;
      
      private var model:IModel;
      
      public function TankModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._handleCollisionWithOtherTank_otherTankZVelocityCodec = this.protocol.getCodec(new TypeCodecInfo(Float,false));
         this._moveCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._moveCommand_specificationIdCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
         this._moveCommand_moveCommandCodec = this.protocol.getCodec(new TypeCodecInfo(MoveCommand,false));
         this._movementControlCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._movementControlCommand_specificationIdCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
         this._movementControlCommand_controlCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
         this._movementControlCommand_turnSpeedNumberCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
      }
      
      public function deathConfirmationCommand() : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc1_:SpaceCommand = new SpaceCommand(Model.object.id,this._deathConfirmationCommandId,this.protocolBuffer);
         var _loc2_:IGameObject = Model.object;
         var _loc3_:ISpace = _loc2_.space;
         _loc3_.commandSender.sendCommand(_loc1_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function handleCollisionWithOtherTank(param1:Number) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._handleCollisionWithOtherTank_otherTankZVelocityCodec.encode(this.protocolBuffer,param1);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc2_:SpaceCommand = new SpaceCommand(Model.object.id,this._handleCollisionWithOtherTankId,this.protocolBuffer);
         var _loc3_:IGameObject = Model.object;
         var _loc4_:ISpace = _loc3_.space;
         _loc4_.commandSender.sendCommand(_loc2_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function moveCommand(param1:int, param2:int, param3:MoveCommand) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._moveCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._moveCommand_specificationIdCodec.encode(this.protocolBuffer,param2);
         this._moveCommand_moveCommandCodec.encode(this.protocolBuffer,param3);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc4_:SpaceCommand = new SpaceCommand(Model.object.id,this._moveCommandId,this.protocolBuffer);
         var _loc5_:IGameObject = Model.object;
         var _loc6_:ISpace = _loc5_.space;
         _loc6_.commandSender.sendCommand(_loc4_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function movementControlCommand(param1:int, param2:int, param3:int, param4:int) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._movementControlCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._movementControlCommand_specificationIdCodec.encode(this.protocolBuffer,param2);
         this._movementControlCommand_controlCodec.encode(this.protocolBuffer,param3);
         this._movementControlCommand_turnSpeedNumberCodec.encode(this.protocolBuffer,param4);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc5_:SpaceCommand = new SpaceCommand(Model.object.id,this._movementControlCommandId,this.protocolBuffer);
         var _loc6_:IGameObject = Model.object;
         var _loc7_:ISpace = _loc6_.space;
         _loc7_.commandSender.sendCommand(_loc5_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

