package projects.tanks.client.battlefield.models.ultimate.effects.wasp
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
   
   public class WaspUltimateModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:WaspUltimateModelServer;
      
      private var client:IWaspUltimateModelBase = IWaspUltimateModelBase(this);
      
      private var modelId:Long = Long.getLong(706050434,1960652493);
      
      private var _showUltimateUsedId:Long = Long.getLong(35469051,-1124131565);
      
      private var _showUltimateUsed_tankObjectCodec:ICodec;
      
      private var _showUltimateUsed_tanksInspiredCodec:ICodec;
      
      public function WaspUltimateModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new WaspUltimateModelServer(IModel(this));
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(WaspUltimateCC,false)));
         this._showUltimateUsed_tankObjectCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
         this._showUltimateUsed_tanksInspiredCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      }
      
      protected function getInitParam() : WaspUltimateCC
      {
         return WaspUltimateCC(initParams[Model.object]);
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._showUltimateUsedId:
               this.client.showUltimateUsed(IGameObject(this._showUltimateUsed_tankObjectCodec.decode(param2)),this._showUltimateUsed_tanksInspiredCodec.decode(param2) as Vector.<IGameObject>);
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

