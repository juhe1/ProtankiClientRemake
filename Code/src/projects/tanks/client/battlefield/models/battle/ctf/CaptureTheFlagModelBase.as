package projects.tanks.client.battlefield.models.battle.ctf
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.EnumCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class CaptureTheFlagModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:CaptureTheFlagModelServer;
      
      private var client:ICaptureTheFlagModelBase = ICaptureTheFlagModelBase(this);
      
      private var modelId:Long = Long.getLong(1965338956,1417730743);
      
      private var _dropFlagId:Long = Long.getLong(1487412361,8128743);
      
      private var _dropFlag_positionCodec:ICodec;
      
      private var _dropFlag_flagTeamCodec:ICodec;
      
      private var _flagDeliveredId:Long = Long.getLong(1849471524,-639146266);
      
      private var _flagDelivered_winnerTeamCodec:ICodec;
      
      private var _flagDelivered_delivererTankIdCodec:ICodec;
      
      private var _flagTakenId:Long = Long.getLong(1134857420,-1224060835);
      
      private var _flagTaken_tankIdCodec:ICodec;
      
      private var _flagTaken_flagTeamCodec:ICodec;
      
      private var _returnFlagToBaseId:Long = Long.getLong(794624341,25869850);
      
      private var _returnFlagToBase_flagTeamCodec:ICodec;
      
      private var _returnFlagToBase_tankCodec:ICodec;
      
      public function CaptureTheFlagModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new CaptureTheFlagModelServer(IModel(this));
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(CaptureTheFlagCC,false)));
         this._dropFlag_positionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
         this._dropFlag_flagTeamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
         this._flagDelivered_winnerTeamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
         this._flagDelivered_delivererTankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
         this._flagTaken_tankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
         this._flagTaken_flagTeamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
         this._returnFlagToBase_flagTeamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
         this._returnFlagToBase_tankCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,true));
      }
      
      protected function getInitParam() : CaptureTheFlagCC
      {
         return CaptureTheFlagCC(initParams[Model.object]);
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._dropFlagId:
               this.client.dropFlag(Vector3d(this._dropFlag_positionCodec.decode(param2)),BattleTeam(this._dropFlag_flagTeamCodec.decode(param2)));
               break;
            case this._flagDeliveredId:
               this.client.flagDelivered(BattleTeam(this._flagDelivered_winnerTeamCodec.decode(param2)),Long(this._flagDelivered_delivererTankIdCodec.decode(param2)));
               break;
            case this._flagTakenId:
               this.client.flagTaken(Long(this._flagTaken_tankIdCodec.decode(param2)),BattleTeam(this._flagTaken_flagTeamCodec.decode(param2)));
               break;
            case this._returnFlagToBaseId:
               this.client.returnFlagToBase(BattleTeam(this._returnFlagToBase_flagTeamCodec.decode(param2)),IGameObject(this._returnFlagToBase_tankCodec.decode(param2)));
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

