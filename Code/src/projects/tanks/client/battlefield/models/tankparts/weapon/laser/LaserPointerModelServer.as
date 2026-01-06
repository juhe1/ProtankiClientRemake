package projects.tanks.client.battlefield.models.tankparts.weapon.laser
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class LaserPointerModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _aimAtTankId:Long = Long.getLong(378246388,-1614466693);
      
      private var _aimAtTank_targetTankCodec:ICodec;
      
      private var _aimAtTank_localSpotPositionCodec:ICodec;
      
      private var _hideId:Long = Long.getLong(1929188336,1755522623);
      
      private var _updateDirectionId:Long = Long.getLong(840274237,-606345319);
      
      private var _updateDirection_projectionOnVerticalAxisCodec:ICodec;
      
      private var model:IModel;
      
      public function LaserPointerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._aimAtTank_targetTankCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
         this._aimAtTank_localSpotPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._updateDirection_projectionOnVerticalAxisCodec = this.protocol.getCodec(new TypeCodecInfo(Float,false));
      }
      
      public function aimAtTank(param1:IGameObject, param2:Vector3d) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._aimAtTank_targetTankCodec.encode(this.protocolBuffer,param1);
         this._aimAtTank_localSpotPositionCodec.encode(this.protocolBuffer,param2);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc3_:SpaceCommand = new SpaceCommand(Model.object.id,this._aimAtTankId,this.protocolBuffer);
         var _loc4_:IGameObject = Model.object;
         var _loc5_:ISpace = _loc4_.space;
         _loc5_.commandSender.sendCommand(_loc3_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function hide() : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc1_:SpaceCommand = new SpaceCommand(Model.object.id,this._hideId,this.protocolBuffer);
         var _loc2_:IGameObject = Model.object;
         var _loc3_:ISpace = _loc2_.space;
         _loc3_.commandSender.sendCommand(_loc1_);
         this.protocolBuffer.optionalMap.clear();
      }
      
      public function updateDirection(param1:Number) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._updateDirection_projectionOnVerticalAxisCodec.encode(this.protocolBuffer,param1);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc2_:SpaceCommand = new SpaceCommand(Model.object.id,this._updateDirectionId,this.protocolBuffer);
         var _loc3_:IGameObject = Model.object;
         var _loc4_:ISpace = _loc3_.space;
         _loc4_.commandSender.sendCommand(_loc2_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

