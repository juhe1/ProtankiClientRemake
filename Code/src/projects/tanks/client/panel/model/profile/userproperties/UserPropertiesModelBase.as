package projects.tanks.client.panel.model.profile.userproperties
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
   import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;
   import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesCC;
   
   public class UserPropertiesModelBase extends Model
   {
      private var client:IUserPropertiesModelBase = IUserPropertiesModelBase(this);
      
      static public var modelId:Long = Long.getLong(440843623,678812097);
      
      public function UserPropertiesModelBase()
      {
         super();
      }
      
      protected function getInitParam() : UserPropertiesCC
      {
         return UserPropertiesCC(initParams[platform.client.fp10.core.model.impl.Model.currentObject]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

