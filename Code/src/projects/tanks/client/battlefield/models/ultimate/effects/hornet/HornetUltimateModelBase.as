package projects.tanks.client.battlefield.models.ultimate.effects.hornet
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.type.IGameObject;
   
   public class HornetUltimateModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:HornetUltimateModelServer;
      
      private var client:IHornetUltimateModelBase = IHornetUltimateModelBase(this);
      
      private var modelId:Long = Long.getLong(1679670805,-112284013);
      
      private var _showUltimateUsedId:Long = Long.getLong(1272053686,1589697139);
      
      private var _showUltimateUsed_userCodec:ICodec;
      
      private var _showUltimateUsed_tanksCodec:ICodec;
      
      public function HornetUltimateModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new HornetUltimateModelServer(IModel(this));
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(HornetUltimateCC,false)));
         this._showUltimateUsed_userCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
         this._showUltimateUsed_tanksCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      }
      
      protected function getInitParam() : HornetUltimateCC
      {
         return HornetUltimateCC(initParams[Model.object]);
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._showUltimateUsedId:
               this.client.showUltimateUsed(IGameObject(this._showUltimateUsed_userCodec.decode(param2)),this._showUltimateUsed_tanksCodec.decode(param2) as Vector.<IGameObject>);
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

