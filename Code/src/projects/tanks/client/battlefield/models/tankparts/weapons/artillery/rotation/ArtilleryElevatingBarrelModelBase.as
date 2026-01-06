package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation
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
   
   public class ArtilleryElevatingBarrelModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:ArtilleryElevatingBarrelModelServer;
      
      private var client:IArtilleryElevatingBarrelModelBase = IArtilleryElevatingBarrelModelBase(this);
      
      private var modelId:Long = Long.getLong(2038268188,-682177215);
      
      private var _updateId:Long = Long.getLong(101482701,848604323);
      
      private var _update_stateCodec:ICodec;
      
      public function ArtilleryElevatingBarrelModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new ArtilleryElevatingBarrelModelServer(IModel(this));
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ArtilleryElevatingBarrelCC,false)));
         this._update_stateCodec = this._protocol.getCodec(new TypeCodecInfo(RotateTurretCommand,false));
      }
      
      protected function getInitParam() : ArtilleryElevatingBarrelCC
      {
         return ArtilleryElevatingBarrelCC(initParams[Model.object]);
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._updateId:
               this.client.update(RotateTurretCommand(this._update_stateCodec.decode(param2)));
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

