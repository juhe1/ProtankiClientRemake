package projects.tanks.client.battlefield.models.tankparts.weapon.turret
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
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   
   public class RotatingTurretModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _rotateId:Long = Long.getLong(136019789,1687443311);
      
      private var _rotate_clientTimeCodec:ICodec;
      
      private var _rotate_incarnationIdCodec:ICodec;
      
      private var _rotate_turretStateCodec:ICodec;
      
      private var model:IModel;
      
      public function RotatingTurretModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._rotate_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._rotate_incarnationIdCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
         this._rotate_turretStateCodec = this.protocol.getCodec(new TypeCodecInfo(RotateTurretCommand,false));
      }
      
      public function rotate(param1:int, param2:int, param3:RotateTurretCommand) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._rotate_clientTimeCodec.encode(this.protocolBuffer,param1);
         this._rotate_incarnationIdCodec.encode(this.protocolBuffer,param2);
         this._rotate_turretStateCodec.encode(this.protocolBuffer,param3);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("Execute method without model context.");
         }
         var _loc4_:SpaceCommand = new SpaceCommand(Model.object.id,this._rotateId,this.protocolBuffer);
         var _loc5_:IGameObject = Model.object;
         var _loc6_:ISpace = _loc5_.space;
         _loc6_.commandSender.sendCommand(_loc4_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

