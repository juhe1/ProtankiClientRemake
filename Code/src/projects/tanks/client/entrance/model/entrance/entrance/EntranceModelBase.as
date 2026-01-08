package projects.tanks.client.entrance.model.entrance.entrance
{
   //import alternativa.osgi.OSGi;
   //import alternativa.protocol.IProtocol;
   //import alternativa.protocol.ProtocolBuffer;
   //import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   //import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   //import platform.client.fp10.core.registry.ModelRegistry;

   public class EntranceModelBase extends Model
   {
      static public var modelId:Long = Long.getLong(687101726,-1582366168);

      public function EntranceModelBase()
      {
         super();
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
