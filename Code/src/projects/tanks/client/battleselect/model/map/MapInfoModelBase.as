package projects.tanks.client.battleselect.model.map
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class MapInfoModelBase extends Model
   {
      private var client:IMapInfoModelBase = IMapInfoModelBase(this);
      
      public static var modelId:Long = Long.getLong(1260204725,-1362969538);
      
      public function MapInfoModelBase()
      {
         super();
      }
      
      protected function getInitParam() : MapInfoCC
      {
         return MapInfoCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

