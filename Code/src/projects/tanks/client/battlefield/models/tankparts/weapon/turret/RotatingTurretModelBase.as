package projects.tanks.client.battlefield.models.tankparts.weapon.turret
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   
   public class RotatingTurretModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:RotatingTurretModelServer;
      
      private var client:IRotatingTurretModelBase = IRotatingTurretModelBase(this);
      
      private var modelId:Long = Long.getLong(652662967,-1245415753);
      
      private var _rotateId:Long = Long.getLong(1536305300,1132390887);
      
      private var _rotate_commandCodec:ICodec;
      
      public function RotatingTurretModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new RotatingTurretModelServer(IModel(this));
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(RotatingTurretCC,false)));
         this._rotate_commandCodec = this._protocol.getCodec(new TypeCodecInfo(RotateTurretCommand,false));
      }
      
      protected function getInitParam() : RotatingTurretCC
      {
         return RotatingTurretCC(initParams[Model.object]);
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._rotateId:
               this.client.rotate(RotateTurretCommand(this._rotate_commandCodec.decode(param2)));
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

