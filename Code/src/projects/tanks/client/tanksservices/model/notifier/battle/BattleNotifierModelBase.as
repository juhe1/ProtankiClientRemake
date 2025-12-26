package projects.tanks.client.tanksservices.model.notifier.battle
{
   //import alternativa.osgi.OSGi;
   //import alternativa.protocol.ICodec;
   //import alternativa.protocol.IProtocol;
   //import alternativa.protocol.ProtocolBuffer;
   //import alternativa.protocol.info.CollectionCodecInfo;
   //import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   //import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class BattleNotifierModelBase extends Model
   {  
      private var client:IBattleNotifierModelBase = IBattleNotifierModelBase(this);
      
      static public var modelId:Long = Long.getLong(904565121,-177943041);
      
      public function BattleNotifierModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

