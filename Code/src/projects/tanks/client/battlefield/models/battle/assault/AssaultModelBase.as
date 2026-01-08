package projects.tanks.client.battlefield.models.battle.assault
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
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class AssaultModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:AssaultModelServer;
      
      private var client:IAssaultModelBase = IAssaultModelBase(this);
      
      private var modelId:Long = Long.getLong(1012996430,-1521107309);
      
      private var _dropFlagId:Long = Long.getLong(316505180,-455455939);
      
      private var _dropFlag_flagIdCodec:ICodec;
      
      private var _dropFlag_positionCodec:ICodec;
      
      private var _flagDeliveredId:Long = Long.getLong(2051659052,-1157285002);
      
      private var _flagDelivered_flagIdCodec:ICodec;
      
      private var _flagDelivered_baseIdCodec:ICodec;
      
      private var _flagDelivered_delivererTankIdCodec:ICodec;
      
      private var _flagTakenId:Long = Long.getLong(1221726371,2088665273);
      
      private var _flagTaken_flagIdCodec:ICodec;
      
      private var _flagTaken_tankIdCodec:ICodec;
      
      private var _returnFlagToBaseId:Long = Long.getLong(266349932,2077700618);
      
      private var _returnFlagToBase_flagIdCodec:ICodec;
      
      private var _returnFlagToBase_tankCodec:ICodec;
      
      public function AssaultModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new AssaultModelServer(IModel(this));
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(AssaultCC,false)));
         this._dropFlag_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._dropFlag_positionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._flagDelivered_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._flagDelivered_baseIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._flagDelivered_delivererTankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
         this._flagTaken_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._flagTaken_tankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
         this._returnFlagToBase_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._returnFlagToBase_tankCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,true));
      }
      
      protected function getInitParam() : AssaultCC
      {
         return AssaultCC(initParams[Model.object]);
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._dropFlagId:
               this.client.dropFlag(int(this._dropFlag_flagIdCodec.decode(param2)),Vector3d(this._dropFlag_positionCodec.decode(param2)));
               break;
            case this._flagDeliveredId:
               this.client.flagDelivered(int(this._flagDelivered_flagIdCodec.decode(param2)),int(this._flagDelivered_baseIdCodec.decode(param2)),Long(this._flagDelivered_delivererTankIdCodec.decode(param2)));
               break;
            case this._flagTakenId:
               this.client.flagTaken(int(this._flagTaken_flagIdCodec.decode(param2)),Long(this._flagTaken_tankIdCodec.decode(param2)));
               break;
            case this._returnFlagToBaseId:
               this.client.returnFlagToBase(int(this._returnFlagToBase_flagIdCodec.decode(param2)),IGameObject(this._returnFlagToBase_tankCodec.decode(param2)));
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

