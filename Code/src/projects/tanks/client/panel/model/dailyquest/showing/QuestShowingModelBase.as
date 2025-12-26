package projects.tanks.client.panel.model.dailyquest.showing
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
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   
   public class QuestShowingModelBase extends Model
   {
      protected var server:QuestShowingModelServer;
      
      private var client:IQuestShowingModelBase = IQuestShowingModelBase(this);
      
      static public var modelId:Long = Long.getLong(1726782619,1524609945);
      
      public function QuestShowingModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return QuestShowingModelBase.modelId;
      }
   }
}

