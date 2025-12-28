package projects.tanks.client.commons.models.layout
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class LobbyLayoutModelBase extends Model
   {
      
      protected var server:LobbyLayoutModelServer = new LobbyLayoutModelServer(IModel(this));
      
      private var client:ILobbyLayoutModelBase = ILobbyLayoutModelBase(this);
      
      static public var modelId:Long = Long.getLong(1223707112,492148927);
      
      public function LobbyLayoutModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return LobbyLayoutModelBase.modelId;
      }
   }
}

